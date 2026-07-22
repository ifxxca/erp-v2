<?php

namespace App\Jobs;

use App\Models\FileAsset;
use App\Modules\Files\Application\FileScanner;
use App\Modules\Identity\Application\AuditLogger;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use RuntimeException;

class ScanUploadedFile implements ShouldBeUnique, ShouldQueue
{
    use Queueable;

    public int $tries = 5;

    public int $uniqueFor = 3600;

    /** @var array<int, int> */
    public array $backoff = [10, 30, 120, 300];

    public function __construct(public readonly string $fileId) {}

    public function uniqueId(): string
    {
        return $this->fileId;
    }

    public function handle(FileScanner $scanner, AuditLogger $audit): void
    {
        $file = FileAsset::query()->findOrFail($this->fileId);
        if ($file->status !== 'quarantined' || ! in_array($file->scan_status, ['pending', 'failed'], true)) {
            return;
        }

        $stream = Storage::disk($file->disk)->readStream($file->object_key);
        if (! is_resource($stream)) {
            $this->failScan($file, $audit, 'Stored object cannot be read.');
            throw new RuntimeException('Stored object cannot be read.');
        }

        try {
            $result = $scanner->scan($stream);
        } catch (RuntimeException $exception) {
            $this->failScan($file, $audit, $exception->getMessage());
            throw $exception;
        } finally {
            fclose($stream);
        }

        if ($result->status === 'infected') {
            Storage::disk($file->disk)->delete($file->object_key);
            DB::transaction(function () use ($file, $audit, $result): void {
                $file->forceFill([
                    'status' => 'rejected',
                    'scan_status' => 'infected',
                    'rejection_reason' => 'Malware scanner rejected this file.',
                ])->save();
                $audit->record('file.scan_infected', null, $file, [
                    'company_id' => $file->company_id,
                    'initiated_by' => $file->created_by,
                    'scanner_detail' => $result->detail,
                ]);
            });

            return;
        }

        if ($result->status === 'skipped' && ! config('files.allow_unscanned')) {
            $this->failScan($file, $audit, $result->detail ?? 'Malware scanning is required.');

            return;
        }

        DB::transaction(function () use ($file, $audit, $result): void {
            $file->forceFill([
                'status' => 'ready',
                'scan_status' => $result->status,
                'finalized_at' => now(),
            ])->save();
            $audit->record('file.ready', null, $file, [
                'company_id' => $file->company_id,
                'initiated_by' => $file->created_by,
                'scan_status' => $result->status,
            ]);
        });
    }

    private function failScan(FileAsset $file, AuditLogger $audit, string $detail): void
    {
        DB::transaction(function () use ($file, $audit, $detail): void {
            $file->forceFill(['scan_status' => 'failed'])->save();
            $audit->record('file.scan_failed', null, $file, [
                'company_id' => $file->company_id,
                'initiated_by' => $file->created_by,
                'scanner_detail' => $detail,
            ]);
        });
    }
}
