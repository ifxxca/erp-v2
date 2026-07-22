<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Company;
use App\Models\FileAsset;
use App\Modules\Files\Application\FileWorkflowService;
use App\Modules\Identity\Application\AuditLogger;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;
use Symfony\Component\HttpFoundation\Response;

class FileController extends Controller
{
    public function __construct(
        private readonly FileWorkflowService $files,
        private readonly AuditLogger $audit,
    ) {}

    public function store(Company $company, Request $request): JsonResponse
    {
        $validated = $request->validate([
            'purpose' => ['required', 'string', Rule::in(config('files.purposes'))],
            'original_name' => ['required', 'string', 'max:255'],
            'mime_type' => ['required', 'string', Rule::in(array_keys(config('files.mime_signatures')))],
            'size' => ['required', 'integer', 'min:1', 'max:'.config('files.max_bytes')],
            'checksum_sha256' => ['required', 'string', 'regex:/^[a-fA-F0-9]{64}$/'],
        ]);
        $file = $this->files->initiate($company, $request->user(), $validated, $request);

        return response()->json([
            'data' => $this->resource($file),
            'upload' => [
                'method' => 'POST',
                'url' => route('files.upload', [$company, $file], false),
                'content_type' => 'multipart/form-data',
                'field' => 'file',
                'expires_at' => $file->pending_expires_at->toIso8601String(),
            ],
        ], Response::HTTP_CREATED);
    }

    public function upload(Company $company, FileAsset $file, Request $request): JsonResponse
    {
        $validated = $request->validate([
            'file' => ['required', 'file', 'max:'.(int) ceil(config('files.max_bytes') / 1024)],
        ]);
        $file = $this->files->upload($company, $file, $request->user(), $validated['file'], $request);

        return response()->json(['data' => $this->resource($file)]);
    }

    public function finalize(Company $company, FileAsset $file, Request $request): JsonResponse
    {
        $file = $this->files->finalize($company, $file, $request->user(), $request);

        return response()->json(['data' => $this->resource($file)], Response::HTTP_ACCEPTED);
    }

    public function show(Company $company, FileAsset $file): JsonResponse
    {
        $this->files->assertCompany($company, $file);

        return response()->json(['data' => $this->resource($file)]);
    }

    public function download(Company $company, FileAsset $file, Request $request): Response
    {
        $this->files->assertCompany($company, $file);
        $this->files->assertDownloadable($file);
        $this->audit->record('file.downloaded', $request->user(), $file, [
            'company_id' => $company->id,
        ], $request);

        return Storage::disk($file->disk)->download(
            $file->object_key,
            $file->original_name,
            ['Content-Type' => $file->detected_mime_type],
        );
    }

    public function destroy(Company $company, FileAsset $file, Request $request): Response
    {
        $this->files->delete($company, $file, $request->user(), $request);

        return response()->noContent();
    }

    /** @return array<string, mixed> */
    private function resource(FileAsset $file): array
    {
        return [
            'id' => $file->id,
            'company_id' => $file->company_id,
            'created_by' => $file->created_by,
            'purpose' => $file->purpose,
            'original_name' => $file->original_name,
            'mime_type' => $file->detected_mime_type ?? $file->declared_mime_type,
            'size' => $file->actual_size ?? $file->expected_size,
            'checksum_sha256' => $file->actual_checksum_sha256 ?? $file->expected_checksum_sha256,
            'status' => $file->status,
            'scan_status' => $file->scan_status,
            'rejection_reason' => $file->rejection_reason,
            'attached_type' => $file->attached_type,
            'attached_id' => $file->attached_id,
            'pending_expires_at' => $file->pending_expires_at->toIso8601String(),
            'retention_until' => $file->retention_until?->toIso8601String(),
            'uploaded_at' => $file->uploaded_at?->toIso8601String(),
            'finalized_at' => $file->finalized_at?->toIso8601String(),
            'created_at' => $file->created_at->toIso8601String(),
        ];
    }
}
