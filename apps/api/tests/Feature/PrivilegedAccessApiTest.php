<?php

namespace Tests\Feature;

use App\Models\AuditLog;
use App\Models\Company;
use App\Models\Permission;
use App\Models\PersonalAccessToken;
use App\Models\Role;
use App\Models\User;
use App\Models\UserCompanyMembership;
use App\Models\UserRoleAssignment;
use App\Notifications\PrivilegedAccessNotification;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Notification;
use Tests\TestCase;

class PrivilegedAccessApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_privileged_request_requires_recent_mfa(): void
    {
        Notification::fake();
        [$company, $maker, $target, $privilegedRole] = $this->accessScenario();
        $this->grant($maker, $company, 'identity.access.request');

        $this->withToken($this->tokenFor($maker, mfaVerified: false))
            ->postJson("/api/v1/identity/companies/{$company->id}/access-requests", [
                'target_user_id' => $target->id,
                'role_id' => $privilegedRole->id,
                'reason' => 'Temporary security administration cover',
                'valid_until' => now()->addDays(30)->toIso8601String(),
            ])->assertForbidden()->assertJsonPath('code', 'MFA_STEP_UP_REQUIRED');

        $this->assertDatabaseCount('access_requests', 0);
    }

    public function test_distinct_maker_and_approver_create_a_time_bounded_assignment(): void
    {
        Notification::fake();
        [$company, $maker, $target, $privilegedRole] = $this->accessScenario();
        $approver = User::factory()->create();
        $this->grant($maker, $company, 'identity.access.request');
        $this->grant($approver, $company, 'identity.access.approve');
        $validUntil = now()->addDays(30);

        $requestResponse = $this->withToken($this->tokenFor($maker))
            ->postJson("/api/v1/identity/companies/{$company->id}/access-requests", [
                'target_user_id' => $target->id,
                'role_id' => $privilegedRole->id,
                'reason' => 'Temporary security administration cover',
                'valid_until' => $validUntil->toIso8601String(),
            ])
            ->assertCreated()
            ->assertJsonPath('status', 'pending');

        $accessRequestId = $requestResponse->json('id');
        $this->withToken($this->tokenFor($approver))
            ->postJson(
                "/api/v1/identity/companies/{$company->id}/access-requests/{$accessRequestId}/approve",
                ['note' => 'Approved for a defined operational period'],
            )
            ->assertOk()
            ->assertJsonPath('status', 'approved')
            ->assertJsonStructure(['assignment_id', 'valid_until']);

        $this->assertDatabaseHas('access_requests', [
            'id' => $accessRequestId,
            'status' => 'approved',
            'decided_by' => $approver->id,
        ]);
        $this->assertDatabaseHas('user_role_assignments', [
            'user_id' => $target->id,
            'role_id' => $privilegedRole->id,
            'company_id' => $company->id,
            'access_request_id' => $accessRequestId,
            'assigned_by' => $approver->id,
        ]);
        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.privileged_access_requested']);
        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.privileged_access_approved']);
        Notification::assertSentTo($target, PrivilegedAccessNotification::class);
    }

    public function test_requester_cannot_approve_their_own_request_even_with_both_permissions(): void
    {
        Notification::fake();
        [$company, $maker, $target, $privilegedRole] = $this->accessScenario();
        $this->grant($maker, $company, 'identity.access.request');
        $this->grant($maker, $company, 'identity.access.approve');
        $token = $this->tokenFor($maker);

        $accessRequestId = $this->withToken($token)
            ->postJson("/api/v1/identity/companies/{$company->id}/access-requests", [
                'target_user_id' => $target->id,
                'role_id' => $privilegedRole->id,
                'reason' => 'Requested by maker',
                'valid_until' => now()->addDays(10)->toIso8601String(),
            ])->json('id');

        $this->withToken($token)
            ->postJson(
                "/api/v1/identity/companies/{$company->id}/access-requests/{$accessRequestId}/approve",
            )
            ->assertUnprocessable()
            ->assertJsonPath('code', 'ACCESS_SELF_APPROVAL_DENIED');

        $this->assertDatabaseHas('access_requests', ['id' => $accessRequestId, 'status' => 'pending']);
        $this->assertDatabaseCount('user_role_assignments', 2);
    }

    public function test_target_user_cannot_approve_access_for_themselves(): void
    {
        Notification::fake();
        [$company, $maker, $target, $privilegedRole] = $this->accessScenario();
        $this->grant($maker, $company, 'identity.access.request');
        $this->grant($target, $company, 'identity.access.approve');

        $accessRequestId = $this->withToken($this->tokenFor($maker))
            ->postJson("/api/v1/identity/companies/{$company->id}/access-requests", [
                'target_user_id' => $target->id,
                'role_id' => $privilegedRole->id,
                'reason' => 'Sensitive access',
                'valid_until' => now()->addDays(10)->toIso8601String(),
            ])->json('id');

        $this->withToken($this->tokenFor($target))
            ->postJson(
                "/api/v1/identity/companies/{$company->id}/access-requests/{$accessRequestId}/approve",
            )
            ->assertUnprocessable()
            ->assertJsonPath('code', 'ACCESS_SELF_APPROVAL_DENIED');
    }

    public function test_privileged_assignment_expiry_cannot_exceed_ninety_days(): void
    {
        Notification::fake();
        [$company, $maker, $target, $privilegedRole] = $this->accessScenario();
        $this->grant($maker, $company, 'identity.access.request');

        $this->withToken($this->tokenFor($maker))
            ->postJson("/api/v1/identity/companies/{$company->id}/access-requests", [
                'target_user_id' => $target->id,
                'role_id' => $privilegedRole->id,
                'reason' => 'Overlong request',
                'valid_until' => now()->addDays(91)->toIso8601String(),
            ])->assertUnprocessable()->assertJsonValidationErrors('valid_until');

        $this->assertDatabaseCount('access_requests', 0);
    }

    public function test_equivalent_pending_request_is_rejected_as_duplicate(): void
    {
        Notification::fake();
        [$company, $maker, $target, $privilegedRole] = $this->accessScenario();
        $this->grant($maker, $company, 'identity.access.request');
        $token = $this->tokenFor($maker);
        $payload = [
            'target_user_id' => $target->id,
            'role_id' => $privilegedRole->id,
            'reason' => 'Duplicate test',
            'valid_until' => now()->addDays(10)->toIso8601String(),
        ];

        $this->withToken($token)
            ->postJson("/api/v1/identity/companies/{$company->id}/access-requests", $payload)
            ->assertCreated();
        $this->withToken($token)
            ->postJson("/api/v1/identity/companies/{$company->id}/access-requests", $payload)
            ->assertConflict()
            ->assertJsonPath('code', 'ACCESS_REQUEST_DUPLICATE');

        $this->assertDatabaseCount('access_requests', 1);
    }

    public function test_approver_can_reject_request_with_a_required_note(): void
    {
        Notification::fake();
        [$company, $maker, $target, $privilegedRole] = $this->accessScenario();
        $approver = User::factory()->create();
        $this->grant($maker, $company, 'identity.access.request');
        $this->grant($approver, $company, 'identity.access.approve');
        $accessRequestId = $this->withToken($this->tokenFor($maker))
            ->postJson("/api/v1/identity/companies/{$company->id}/access-requests", [
                'target_user_id' => $target->id,
                'role_id' => $privilegedRole->id,
                'reason' => 'Rejected test request',
                'valid_until' => now()->addDays(10)->toIso8601String(),
            ])->json('id');

        $this->withToken($this->tokenFor($approver))
            ->postJson(
                "/api/v1/identity/companies/{$company->id}/access-requests/{$accessRequestId}/reject",
                ['note' => 'Business justification is insufficient'],
            )
            ->assertOk()
            ->assertJsonPath('status', 'rejected');

        $this->assertDatabaseHas('access_requests', [
            'id' => $accessRequestId,
            'status' => 'rejected',
            'decided_by' => $approver->id,
            'decision_note' => 'Business justification is insufficient',
        ]);
        $this->assertDatabaseMissing('user_role_assignments', ['access_request_id' => $accessRequestId]);
    }

    public function test_company_scoped_permission_does_not_authorize_request_in_another_company(): void
    {
        Notification::fake();
        [$companyA, $maker, $target, $privilegedRole] = $this->accessScenario();
        $companyB = Company::query()->create(['code' => 'B', 'legal_name' => 'Company B']);
        $this->activeMembership($target, $companyB);
        $this->grant($maker, $companyA, 'identity.access.request');

        $this->withToken($this->tokenFor($maker))
            ->postJson("/api/v1/identity/companies/{$companyB->id}/access-requests", [
                'target_user_id' => $target->id,
                'role_id' => $privilegedRole->id,
                'reason' => 'Wrong scope',
                'valid_until' => now()->addDays(10)->toIso8601String(),
            ])->assertForbidden()->assertJsonPath('code', 'PERMISSION_DENIED');
    }

    public function test_immediate_revocation_marks_assignment_and_revokes_target_tokens(): void
    {
        Notification::fake();
        [$company, $securityAdmin, $target, $privilegedRole] = $this->accessScenario();
        $this->grant($securityAdmin, $company, 'identity.access.revoke');
        $targetToken = $target->createToken('Target Browser')->plainTextToken;
        $assignment = UserRoleAssignment::query()->create([
            'user_id' => $target->id,
            'role_id' => $privilegedRole->id,
            'company_id' => $company->id,
            'valid_from' => now(),
            'valid_until' => now()->addDays(10),
            'assigned_by' => $securityAdmin->id,
        ]);

        $this->withToken($this->tokenFor($securityAdmin))
            ->postJson(
                "/api/v1/identity/companies/{$company->id}/role-assignments/{$assignment->id}/revoke",
                ['reason' => 'Access no longer required'],
            )
            ->assertOk()
            ->assertJsonPath('status', 'revoked');

        $this->assertNotNull($assignment->fresh()->revoked_at);
        $this->assertNull(PersonalAccessToken::findToken($targetToken));
        $audit = AuditLog::query()->where('event', 'identity.privileged_access_revoked')->sole();
        $this->assertSame('Access no longer required', $audit->metadata['reason']);
        Notification::assertSentTo($target, PrivilegedAccessNotification::class);
    }

    /** @return array{Company, User, User, Role} */
    private function accessScenario(): array
    {
        $company = Company::query()->create(['code' => 'RKS', 'legal_name' => 'Company RKS']);
        $maker = User::factory()->create();
        $target = User::factory()->create();
        $this->activeMembership($maker, $company);
        $this->activeMembership($target, $company);
        $privilegedRole = Role::query()->create([
            'code' => 'security-admin',
            'name' => 'Security Administrator',
            'is_privileged' => true,
        ]);

        return [$company, $maker, $target, $privilegedRole];
    }

    private function grant(User $user, Company $company, string $permissionCode): void
    {
        $this->activeMembership($user, $company);
        $permission = Permission::query()->firstOrCreate(
            ['code' => $permissionCode],
            ['module' => 'identity', 'resource' => 'access', 'action' => str($permissionCode)->afterLast('.')],
        );
        $role = Role::query()->create([
            'code' => str($permissionCode)->replace('.', '-').'-'.str()->lower(str()->random(6)),
            'name' => $permissionCode,
        ]);
        $role->permissions()->attach($permission);
        UserRoleAssignment::query()->create([
            'user_id' => $user->id,
            'role_id' => $role->id,
            'company_id' => $company->id,
            'valid_from' => now(),
            'assigned_by' => $user->id,
        ]);
    }

    private function activeMembership(User $user, Company $company): void
    {
        if ($user->companyMemberships()->where('company_id', $company->id)->exists()) {
            return;
        }

        UserCompanyMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'employment_status' => 'active',
            'is_primary' => true,
            'valid_from' => today(),
        ]);
    }

    private function tokenFor(User $user, bool $mfaVerified = true): string
    {
        $plainTextToken = $user->createToken('Test Device')->plainTextToken;
        $token = PersonalAccessToken::findToken($plainTextToken);

        if ($mfaVerified) {
            $token->forceFill(['mfa_verified_at' => now()])->save();
        }

        // Feature tests issue requests as multiple actors in one application instance.
        $this->app['auth']->forgetGuards();

        return $plainTextToken;
    }
}
