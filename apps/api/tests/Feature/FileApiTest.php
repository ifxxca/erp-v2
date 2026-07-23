<?php

namespace Tests\Feature;

use App\Models\AuditLog;
use App\Models\Company;
use App\Models\FileAsset;
use App\Models\Permission;
use App\Models\Role;
use App\Models\User;
use App\Models\UserCompanyMembership;
use App\Models\UserRoleAssignment;
use App\Modules\Files\Application\FileScanner;
use App\Modules\Files\Application\FileScanResult;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Storage;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class FileApiTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        Storage::fake('local');
        config(['files.disk' => 'local', 'files.scan_driver' => 'skipped', 'files.allow_unscanned' => true]);
    }

    public function test_file_is_initiated_uploaded_scanned_and_downloaded_without_exposing_storage_key(): void
    {
        [$company, $actor] = $this->actor(['file.asset.create', 'file.asset.view']);
        Sanctum::actingAs($actor);
        $content = "%PDF-1.7\nRajawali checklist evidence\n%%EOF";
        $file = $this->initiate($company, $content)
            ->assertCreated()
            ->assertJsonPath('data.status', 'pending')
            ->assertJsonPath('upload.method', 'POST')
            ->assertJsonMissingPath('data.object_key')
            ->json('data');

        $this->post(
            "/api/v1/companies/{$company->id}/files/{$file['id']}/content",
            ['file' => UploadedFile::fake()->createWithContent('evidence.pdf', $content)],
            ['Accept' => 'application/json'],
        )->assertOk()
            ->assertJsonPath('data.status', 'uploaded')
            ->assertJsonPath('data.scan_status', 'not_started');

        $this->post(
            "/api/v1/companies/{$company->id}/files/{$file['id']}/content",
            ['file' => UploadedFile::fake()->createWithContent('evidence.pdf', $content)],
            ['Accept' => 'application/json'],
        )->assertOk()->assertJsonPath('data.status', 'uploaded');
        $this->assertDatabaseCount('files', 1);
        $this->assertSame(1, AuditLog::query()->where('event', 'file.uploaded')->count());

        $this->postJson("/api/v1/companies/{$company->id}/files/{$file['id']}/finalize")
            ->assertAccepted()
            ->assertJsonPath('data.status', 'ready')
            ->assertJsonPath('data.scan_status', 'skipped');

        $asset = FileAsset::query()->findOrFail($file['id']);
        Storage::disk('local')->assertExists($asset->object_key);
        $this->getJson("/api/v1/companies/{$company->id}/files/{$file['id']}")
            ->assertOk()
            ->assertJsonPath('data.checksum_sha256', hash('sha256', $content));
        $this->get("/api/v1/companies/{$company->id}/files/{$file['id']}/download", [
            'Accept' => 'application/pdf',
        ])->assertOk()->assertHeader('content-type', 'application/pdf');

        $this->assertDatabaseHas('audit_logs', ['event' => 'file.ready', 'subject_id' => $file['id']]);
        $this->assertDatabaseHas('audit_logs', ['event' => 'file.downloaded', 'subject_id' => $file['id']]);
    }

    public function test_checksum_or_signature_mismatch_is_rejected_and_binary_is_not_kept(): void
    {
        [$company, $actor] = $this->actor(['file.asset.create']);
        Sanctum::actingAs($actor);
        $declared = "%PDF-1.7\nExpected";
        $fileId = $this->initiate($company, $declared)->json('data.id');

        $this->post(
            "/api/v1/companies/{$company->id}/files/{$fileId}/content",
            ['file' => UploadedFile::fake()->createWithContent('evidence.pdf', "%PDF-1.7\nDifferent")],
            ['Accept' => 'application/json'],
        )->assertUnprocessable()->assertJsonPath('code', 'FILE_CONTENT_REJECTED');

        $asset = FileAsset::query()->findOrFail($fileId);
        $this->assertSame('rejected', $asset->status);
        Storage::disk('local')->assertMissing($asset->object_key);
    }

    public function test_company_scope_and_upload_ownership_are_enforced(): void
    {
        [$companyA, $owner] = $this->actor(['file.asset.create', 'file.asset.view']);
        [$companyB, $other] = $this->actor(['file.asset.create', 'file.asset.view']);
        $content = "%PDF-1.7\nOwned";
        Sanctum::actingAs($owner);
        $fileId = $this->initiate($companyA, $content)->json('data.id');

        Sanctum::actingAs($other);
        $this->getJson("/api/v1/companies/{$companyB->id}/files/{$fileId}")
            ->assertNotFound()
            ->assertJsonPath('code', 'FILE_NOT_FOUND');

        UserCompanyMembership::query()->create([
            'user_id' => $other->id,
            'company_id' => $companyA->id,
            'employment_status' => 'active',
            'is_primary' => false,
            'valid_from' => today(),
        ]);
        $this->grant($other, $companyA, ['file.asset.create']);
        $this->post(
            "/api/v1/companies/{$companyA->id}/files/{$fileId}/content",
            ['file' => UploadedFile::fake()->createWithContent('owned.pdf', $content)],
            ['Accept' => 'application/json'],
        )->assertForbidden()->assertJsonPath('code', 'FILE_OWNER_REQUIRED');
    }

    public function test_infected_file_is_removed_and_never_downloadable(): void
    {
        $this->app->bind(FileScanner::class, fn () => new class implements FileScanner
        {
            public function scan($stream): FileScanResult
            {
                return FileScanResult::infected('Eicar-Test-Signature FOUND');
            }
        });
        [$company, $actor] = $this->actor(['file.asset.create', 'file.asset.view']);
        Sanctum::actingAs($actor);
        $content = "%PDF-1.7\nMalicious test fixture";
        $fileId = $this->initiate($company, $content)->json('data.id');
        $this->post(
            "/api/v1/companies/{$company->id}/files/{$fileId}/content",
            ['file' => UploadedFile::fake()->createWithContent('infected.pdf', $content)],
            ['Accept' => 'application/json'],
        )->assertOk();
        $this->postJson("/api/v1/companies/{$company->id}/files/{$fileId}/finalize")
            ->assertAccepted()
            ->assertJsonPath('data.status', 'rejected')
            ->assertJsonPath('data.scan_status', 'infected');

        $asset = FileAsset::query()->findOrFail($fileId);
        Storage::disk('local')->assertMissing($asset->object_key);
        $this->getJson("/api/v1/companies/{$company->id}/files/{$fileId}/download")
            ->assertConflict()
            ->assertJsonPath('code', 'FILE_NOT_DOWNLOADABLE');
    }

    public function test_authorized_delete_removes_binary_but_preserves_audited_metadata(): void
    {
        [$company, $actor] = $this->actor(['file.asset.create', 'file.asset.delete']);
        Sanctum::actingAs($actor);
        $content = "%PDF-1.7\nDisposable";
        $fileId = $this->initiate($company, $content)->json('data.id');
        $this->post(
            "/api/v1/companies/{$company->id}/files/{$fileId}/content",
            ['file' => UploadedFile::fake()->createWithContent('delete.pdf', $content)],
            ['Accept' => 'application/json'],
        )->assertOk();

        $this->deleteJson("/api/v1/companies/{$company->id}/files/{$fileId}")
            ->assertNoContent();
        $this->assertDatabaseHas('files', ['id' => $fileId, 'status' => 'deleted', 'deleted_by' => $actor->id]);
        $this->assertDatabaseHas('audit_logs', ['event' => 'file.deleted', 'subject_id' => $fileId]);
    }

    public function test_initiation_replay_does_not_create_duplicate_metadata_or_audit(): void
    {
        [$company, $actor] = $this->actor(['file.asset.create']);
        Sanctum::actingAs($actor);
        $content = "%PDF-1.7\nRetry safe";
        $headers = ['Idempotency-Key' => '01JFILEINITIATERETRY000000001'];
        $payload = [
            'purpose' => 'checklist_evidence',
            'original_name' => 'retry.pdf',
            'mime_type' => 'application/pdf',
            'size' => strlen($content),
            'checksum_sha256' => hash('sha256', $content),
        ];

        $first = $this->withHeaders($headers)
            ->postJson("/api/v1/companies/{$company->id}/files", $payload)
            ->assertCreated()
            ->assertHeader('Idempotency-Replayed', 'false');
        $this->withHeaders($headers)
            ->postJson("/api/v1/companies/{$company->id}/files", $payload)
            ->assertCreated()
            ->assertHeader('Idempotency-Replayed', 'true')
            ->assertExactJson($first->json());

        $this->assertDatabaseCount('files', 1);
        $this->assertDatabaseCount('audit_logs', 1);
    }

    public function test_scheduler_expires_abandoned_upload_and_keeps_audit_evidence(): void
    {
        [$company, $actor] = $this->actor(['file.asset.create']);
        Sanctum::actingAs($actor);
        $content = "%PDF-1.7\nAbandoned";
        $fileId = $this->initiate($company, $content)->json('data.id');
        $asset = FileAsset::query()->findOrFail($fileId);
        Storage::disk('local')->put($asset->object_key, $content);
        $asset->forceFill(['pending_expires_at' => now()->subMinute()])->save();

        Artisan::call('files:expire-abandoned');

        Storage::disk('local')->assertMissing($asset->object_key);
        $this->assertDatabaseHas('files', ['id' => $fileId, 'status' => 'expired']);
        $this->assertDatabaseHas('audit_logs', ['event' => 'file.expired', 'subject_id' => $fileId]);
    }

    private function initiate(Company $company, string $content)
    {
        return $this->postJson("/api/v1/companies/{$company->id}/files", [
            'purpose' => 'checklist_evidence',
            'original_name' => 'evidence.pdf',
            'mime_type' => 'application/pdf',
            'size' => strlen($content),
            'checksum_sha256' => hash('sha256', $content),
        ]);
    }

    /** @param array<int, string> $permissions */
    private function actor(array $permissions): array
    {
        $company = Company::query()->create([
            'code' => 'C'.Company::query()->count(),
            'legal_name' => 'Company '.Company::query()->count(),
        ]);
        $user = User::factory()->create();
        UserCompanyMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'employment_status' => 'active',
            'is_primary' => true,
            'valid_from' => today(),
        ]);
        $this->grant($user, $company, $permissions);

        return [$company, $user];
    }

    /** @param array<int, string> $permissions */
    private function grant(User $user, Company $company, array $permissions): void
    {
        $role = Role::query()->create([
            'code' => 'file-role-'.Role::query()->count(),
            'name' => 'File Role',
            'assignment_scope' => 'company',
        ]);
        foreach ($permissions as $code) {
            $permission = Permission::query()->firstOrCreate(
                ['code' => $code],
                ['module' => 'file', 'resource' => 'asset', 'action' => str($code)->afterLast('.')->toString()],
            );
            $role->permissions()->attach($permission);
        }
        UserRoleAssignment::query()->create([
            'user_id' => $user->id,
            'role_id' => $role->id,
            'company_id' => $company->id,
            'valid_from' => now(),
            'assigned_by' => $user->id,
        ]);
    }
}
