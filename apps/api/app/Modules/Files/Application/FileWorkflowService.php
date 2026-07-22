<?php

namespace App\Modules\Files\Application;

use App\Jobs\ScanUploadedFile;
use App\Models\Company;
use App\Models\FileAsset;
use App\Models\User;
use App\Modules\Identity\Application\AuditLogger;
use Illuminate\Http\Request;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Symfony\Component\HttpFoundation\Response;

class FileWorkflowService
{
    public function __construct(private readonly AuditLogger $audit) {}

    /** @param array{purpose:string,original_name:string,mime_type:string,size:int,checksum_sha256:string} $attributes */
    public function initiate(Company $company, User $actor, array $attributes, Request $request): FileAsset
    {
        return DB::transaction(function () use ($company, $actor, $attributes, $request): FileAsset {
            $id = (string) Str::ulid();
            $file = FileAsset::query()->create([
                'id' => $id,
                'company_id' => $company->id,
                'created_by' => $actor->id,
                'purpose' => $attributes['purpose'],
                'original_name' => $this->safeName($attributes['original_name']),
                'disk' => (string) config('files.disk'),
                'object_key' => "companies/{$company->id}/files/{$id}",
                'declared_mime_type' => $attributes['mime_type'],
                'expected_size' => $attributes['size'],
                'expected_checksum_sha256' => strtolower($attributes['checksum_sha256']),
                'status' => 'pending',
                'scan_status' => 'not_started',
                'pending_expires_at' => now()->addHours((int) config('files.pending_lifetime_hours')),
                // Domain retention starts when a file is attached; legal policy Q-206 is still open.
                'retention_until' => null,
            ]);

            $this->audit->record('file.initiated', $actor, $file, [
                'company_id' => $company->id,
                'purpose' => $file->purpose,
                'expected_size' => $file->expected_size,
            ], $request);

            return $file;
        });
    }

    public function upload(Company $company, FileAsset $file, User $actor, UploadedFile $upload, Request $request): FileAsset
    {
        $this->assertCompany($company, $file);
        $this->assertOwner($file, $actor);
        if ($file->status === 'uploaded') {
            return $file;
        }
        if ($file->status !== 'pending' || $file->pending_expires_at->isPast()) {
            throw new FileWorkflowException(
                'This upload reservation is no longer writable.',
                'FILE_UPLOAD_NOT_WRITABLE',
                Response::HTTP_CONFLICT,
            );
        }

        $path = $upload->getRealPath();
        $actualSize = $upload->getSize();
        $detectedMime = $upload->getMimeType();
        $actualChecksum = is_string($path) ? hash_file('sha256', $path) : false;
        $reason = $this->invalidUploadReason($file, $path, $actualSize, $detectedMime, $actualChecksum);

        if ($reason !== null) {
            $this->reject($file, $actor, $reason, $request);
            throw new FileWorkflowException($reason, 'FILE_CONTENT_REJECTED', Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        $stream = fopen($path, 'rb');
        $stored = is_resource($stream)
            && Storage::disk($file->disk)->put($file->object_key, $stream, ['visibility' => 'private']);
        if (is_resource($stream)) {
            fclose($stream);
        }
        if (! $stored) {
            throw new FileWorkflowException(
                'The file could not be written to private object storage.',
                'FILE_STORAGE_FAILED',
                Response::HTTP_SERVICE_UNAVAILABLE,
            );
        }

        DB::transaction(function () use ($file, $actualSize, $actualChecksum, $detectedMime, $actor, $company, $request): void {
            $file->forceFill([
                'actual_size' => $actualSize,
                'actual_checksum_sha256' => $actualChecksum,
                'detected_mime_type' => $detectedMime,
                'status' => 'uploaded',
                'uploaded_at' => now(),
            ])->save();
            $this->audit->record('file.uploaded', $actor, $file, [
                'company_id' => $company->id,
                'actual_size' => $actualSize,
                'detected_mime_type' => $detectedMime,
            ], $request);
        });

        return $file->refresh();
    }

    public function finalize(Company $company, FileAsset $file, User $actor, Request $request): FileAsset
    {
        $this->assertCompany($company, $file);
        $this->assertOwner($file, $actor);
        if ($file->status !== 'uploaded') {
            throw new FileWorkflowException(
                'Only a structurally validated upload can be finalized.',
                'FILE_NOT_READY_TO_FINALIZE',
                Response::HTTP_CONFLICT,
            );
        }

        DB::transaction(function () use ($file, $actor, $request): void {
            $file->forceFill(['status' => 'quarantined', 'scan_status' => 'pending'])->save();
            $this->audit->record('file.finalize_requested', $actor, $file, [
                'company_id' => $file->company_id,
            ], $request);
            ScanUploadedFile::dispatch($file->id)->afterCommit();
        });

        return $file->refresh();
    }

    public function delete(Company $company, FileAsset $file, User $actor, Request $request): void
    {
        $this->assertCompany($company, $file);
        if ($file->status === 'deleted') {
            throw new FileWorkflowException('The file is already deleted.', 'FILE_ALREADY_DELETED', Response::HTTP_CONFLICT);
        }
        if ($file->attached_id !== null) {
            throw new FileWorkflowException(
                'An attached file must be deleted through its owning domain workflow.',
                'FILE_ATTACHED_DELETE_DENIED',
                Response::HTTP_CONFLICT,
            );
        }

        Storage::disk($file->disk)->delete($file->object_key);
        DB::transaction(function () use ($file, $actor, $company, $request): void {
            $file->forceFill([
                'status' => 'deleted',
                'deleted_at' => now(),
                'deleted_by' => $actor->id,
            ])->save();
            $this->audit->record('file.deleted', $actor, $file, ['company_id' => $company->id], $request);
        });
    }

    public function assertCompany(Company $company, FileAsset $file): void
    {
        if ($file->company_id !== $company->id) {
            throw new FileWorkflowException('The file does not belong to this company.', 'FILE_NOT_FOUND', Response::HTTP_NOT_FOUND);
        }
    }

    public function assertDownloadable(FileAsset $file): void
    {
        if ($file->status !== 'ready' || ! Storage::disk($file->disk)->exists($file->object_key)) {
            throw new FileWorkflowException(
                'The file is not available for download.',
                'FILE_NOT_DOWNLOADABLE',
                Response::HTTP_CONFLICT,
            );
        }
    }

    private function assertOwner(FileAsset $file, User $actor): void
    {
        if ($file->created_by !== $actor->id) {
            throw new FileWorkflowException(
                'Only the upload owner may change this pending file.',
                'FILE_OWNER_REQUIRED',
                Response::HTTP_FORBIDDEN,
            );
        }
    }

    private function invalidUploadReason(
        FileAsset $file,
        string|false $path,
        int|false $size,
        ?string $mime,
        string|false $checksum,
    ): ?string {
        if (! is_string($path) || ! is_int($size) || ! is_string($checksum) || ! is_string($mime)) {
            return 'The uploaded binary could not be inspected.';
        }
        if ($size !== $file->expected_size) {
            return 'The uploaded size does not match the initiated metadata.';
        }
        if (! hash_equals($file->expected_checksum_sha256, $checksum)) {
            return 'The uploaded SHA-256 checksum does not match the initiated metadata.';
        }
        if ($mime !== $file->declared_mime_type || ! array_key_exists($mime, config('files.mime_signatures'))) {
            return 'The detected MIME type is not allowed or does not match the declaration.';
        }
        if (! $this->hasValidSignature($path, $mime)) {
            return 'The binary signature does not match the detected MIME type.';
        }

        return null;
    }

    private function hasValidSignature(string $path, string $mime): bool
    {
        $handle = fopen($path, 'rb');
        $bytes = is_resource($handle) ? fread($handle, 16) : false;
        if (is_resource($handle)) {
            fclose($handle);
        }
        if (! is_string($bytes)) {
            return false;
        }

        $hex = bin2hex($bytes);
        $validPrefix = collect(config("files.mime_signatures.{$mime}", []))
            ->contains(fn (string $signature) => str_starts_with($hex, strtolower($signature)));

        return $validPrefix && ($mime !== 'image/webp' || substr($bytes, 8, 4) === 'WEBP');
    }

    private function reject(FileAsset $file, User $actor, string $reason, Request $request): void
    {
        Storage::disk($file->disk)->delete($file->object_key);
        DB::transaction(function () use ($file, $actor, $reason, $request): void {
            $file->forceFill(['status' => 'rejected', 'rejection_reason' => $reason])->save();
            $this->audit->record('file.rejected', $actor, $file, [
                'company_id' => $file->company_id,
                'reason' => $reason,
            ], $request);
        });
    }

    private function safeName(string $name): string
    {
        $name = basename(str_replace('\\', '/', $name));

        return Str::limit(preg_replace('/[\x00-\x1F\x7F]/u', '', $name) ?: 'file', 255, '');
    }
}
