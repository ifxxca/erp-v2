<?php

namespace Tests\Feature;

use App\Models\AccessRequest;
use App\Models\Company;
use App\Models\Permission;
use App\Models\Role;
use App\Models\User;
use App\Models\UserCompanyMembership;
use App\Models\UserMfaMethod;
use App\Models\UserRoleAssignment;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class AccessAdministrationApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_company_capabilities_reflect_each_access_governance_permission(): void
    {
        $company = $this->company('A');
        $actor = User::factory()->create();
        $this->activeEmployment($actor, $company);
        foreach (['identity.user.view', 'identity.access.request', 'identity.access.approve', 'identity.access.revoke'] as $permission) {
            $this->grant($actor, $company, $permission);
        }
        Sanctum::actingAs($actor);

        $this->getJson('/api/v1/identity/companies')
            ->assertOk()
            ->assertJsonPath('data.0.capabilities.can_request_access', true)
            ->assertJsonPath('data.0.capabilities.can_approve_access', true)
            ->assertJsonPath('data.0.capabilities.can_revoke_access', true);
    }

    public function test_access_catalog_contains_only_active_company_targets_and_company_assignable_roles(): void
    {
        $company = $this->company('A');
        $otherCompany = $this->company('B');
        $actor = User::factory()->create();
        $eligible = User::factory()->create(['name' => 'Eligible Target']);
        $otherTarget = User::factory()->create(['name' => 'Other Target']);
        $this->activeEmployment($actor, $company);
        $this->activeEmployment($eligible, $company);
        $this->activeEmployment($otherTarget, $otherCompany);
        $this->grant($actor, $company, 'identity.access.request');
        UserMfaMethod::query()->create([
            'user_id' => $eligible->id,
            'type' => 'totp',
            'secret' => 'JBSWY3DPEHPK3PXPJBSWY3DPEHPK3PXP',
            'status' => 'active',
            'confirmed_at' => now(),
        ]);
        $companyRole = Role::query()->create([
            'code' => 'company-owner',
            'name' => 'Company Owner',
            'is_privileged' => true,
            'assignment_scope' => 'company',
        ]);
        Role::query()->create([
            'code' => 'platform-admin',
            'name' => 'Platform Admin',
            'is_privileged' => true,
            'assignment_scope' => 'global',
        ]);
        Sanctum::actingAs($actor);

        $this->getJson("/api/v1/identity/companies/{$company->id}/access-catalog")
            ->assertOk()
            ->assertJsonFragment(['id' => $eligible->id, 'mfa_enabled' => true])
            ->assertJsonFragment(['id' => $companyRole->id, 'assignment_scope' => 'company'])
            ->assertJsonMissing(['id' => $otherTarget->id])
            ->assertJsonMissing(['code' => 'platform-admin']);
    }

    public function test_maker_history_and_approval_queue_have_distinct_visibility(): void
    {
        $company = $this->company('A');
        $maker = User::factory()->create();
        $otherMaker = User::factory()->create();
        $target = User::factory()->create();
        $role = Role::query()->create([
            'code' => 'company-owner',
            'name' => 'Company Owner',
            'is_privileged' => true,
        ]);
        foreach ([$maker, $otherMaker, $target] as $user) {
            $this->activeEmployment($user, $company);
        }
        $this->grant($maker, $company, 'identity.access.request');
        $this->grant($otherMaker, $company, 'identity.access.approve');
        $mine = $this->accessRequest($company, $maker, $target, $role);
        $other = $this->accessRequest($company, $otherMaker, $target, $role);

        Sanctum::actingAs($maker);
        $this->getJson("/api/v1/identity/companies/{$company->id}/access-requests/mine")
            ->assertOk()
            ->assertJsonFragment(['id' => $mine->id])
            ->assertJsonMissing(['id' => $other->id]);

        Sanctum::actingAs($otherMaker);
        $this->getJson("/api/v1/identity/companies/{$company->id}/access-requests")
            ->assertOk()
            ->assertJsonFragment(['id' => $mine->id])
            ->assertJsonFragment(['id' => $other->id]);
    }

    public function test_revocation_list_contains_only_active_privileged_assignments_in_company(): void
    {
        $company = $this->company('A');
        $otherCompany = $this->company('B');
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->activeEmployment($actor, $company);
        $this->grant($actor, $company, 'identity.access.revoke');
        $privilegedRole = Role::query()->create([
            'code' => 'company-owner',
            'name' => 'Company Owner',
            'is_privileged' => true,
        ]);
        $ordinaryRole = Role::query()->create(['code' => 'reader', 'name' => 'Reader']);
        $active = $this->assignment($target, $actor, $company, $privilegedRole);
        $revoked = $this->assignment($target, $actor, $company, $privilegedRole, revoked: true);
        $ordinary = $this->assignment($target, $actor, $company, $ordinaryRole);
        $other = $this->assignment($target, $actor, $otherCompany, $privilegedRole);
        Sanctum::actingAs($actor);

        $this->getJson("/api/v1/identity/companies/{$company->id}/role-assignments")
            ->assertOk()
            ->assertJsonFragment(['id' => $active->id])
            ->assertJsonMissing(['id' => $revoked->id])
            ->assertJsonMissing(['id' => $ordinary->id])
            ->assertJsonMissing(['id' => $other->id]);
    }

    public function test_request_rejects_scope_that_does_not_match_role_policy(): void
    {
        $company = $this->company('A');
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->activeEmployment($actor, $company);
        $this->activeEmployment($target, $company);
        $this->grant($actor, $company, 'identity.access.request');
        $departmentRole = Role::query()->create([
            'code' => 'privileged-department-owner',
            'name' => 'Privileged Department Owner',
            'is_privileged' => true,
            'assignment_scope' => 'department',
        ]);
        $token = $actor->createToken('Admin', expiresAt: now()->addHour());
        $token->accessToken->forceFill(['mfa_verified_at' => now()])->save();

        $this->withToken($token->plainTextToken)
            ->postJson("/api/v1/identity/companies/{$company->id}/access-requests", [
                'target_user_id' => $target->id,
                'role_id' => $departmentRole->id,
                'reason' => 'Temporary department-level approval cover.',
                'valid_until' => now()->addDays(10)->toIso8601String(),
            ])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'ACCESS_ROLE_SCOPE_INVALID');
    }

    private function company(string $code): Company
    {
        return Company::query()->create(['code' => $code, 'legal_name' => "Company {$code}"]);
    }

    private function activeEmployment(User $user, Company $company): void
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

    private function grant(User $user, Company $company, string $permissionCode): void
    {
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

    private function accessRequest(Company $company, User $maker, User $target, Role $role): AccessRequest
    {
        return AccessRequest::query()->create([
            'target_user_id' => $target->id,
            'role_id' => $role->id,
            'company_id' => $company->id,
            'requested_by' => $maker->id,
            'status' => 'pending',
            'reason' => 'Temporary access for operational coverage.',
            'requested_valid_until' => now()->addDays(10),
        ]);
    }

    private function assignment(
        User $target,
        User $actor,
        Company $company,
        Role $role,
        bool $revoked = false,
    ): UserRoleAssignment {
        return UserRoleAssignment::query()->create([
            'user_id' => $target->id,
            'role_id' => $role->id,
            'company_id' => $company->id,
            'valid_from' => now(),
            'valid_until' => now()->addDays(10),
            'assigned_by' => $actor->id,
            'revoked_at' => $revoked ? now() : null,
            'revoked_by' => $revoked ? $actor->id : null,
            'revocation_reason' => $revoked ? 'Test revocation' : null,
        ]);
    }
}
