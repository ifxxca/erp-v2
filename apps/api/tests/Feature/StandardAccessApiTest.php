<?php

namespace Tests\Feature;

use App\Models\AccessRequest;
use App\Models\Company;
use App\Models\Department;
use App\Models\Location;
use App\Models\Permission;
use App\Models\Role;
use App\Models\User;
use App\Models\UserCompanyMembership;
use App\Models\UserDepartmentMembership;
use App\Models\UserLocationMembership;
use App\Models\UserRoleAssignment;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class StandardAccessApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_company_capability_and_catalog_require_scoped_assign_permission(): void
    {
        $companyA = $this->company('A');
        $companyB = $this->company('B');
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->employment($actor, $companyA);
        $this->employment($target, $companyA);
        $this->grant($actor, $companyA, ['identity.user.view', 'identity.access.assign']);
        $this->standardRole('company-reader', 'company');
        $this->standardRole('global-reader', 'global');
        $this->standardRole('privileged-reader', 'company', privileged: true);
        $token = $this->token($actor);

        $this->withToken($token)->getJson('/api/v1/identity/companies')
            ->assertOk()
            ->assertJsonPath('data.0.capabilities.can_assign_access', true);

        $this->withToken($token)
            ->getJson("/api/v1/identity/companies/{$companyA->id}/users/{$target->id}/role-assignments")
            ->assertOk()
            ->assertJsonFragment(['code' => 'company-reader'])
            ->assertJsonMissing(['code' => 'global-reader'])
            ->assertJsonMissing(['code' => 'privileged-reader']);

        $this->withToken($token)
            ->getJson("/api/v1/identity/companies/{$companyB->id}/users/{$target->id}/role-assignments")
            ->assertForbidden()
            ->assertJsonPath('code', 'PERMISSION_DENIED');
    }

    public function test_manager_can_assign_company_role_with_audit(): void
    {
        $company = $this->company('A');
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->employment($actor, $company);
        $this->employment($target, $company);
        $this->grant($actor, $company, ['identity.access.assign']);
        $role = $this->standardRole('fleet-reader', 'company');

        $response = $this->withToken($this->token($actor, mfaVerified: true))
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$target->id}/role-assignments", [
                'role_id' => $role->id,
                'valid_from' => today()->toDateString(),
                'valid_until' => today()->addMonth()->toDateString(),
                'reason' => 'Fleet visibility is required for daily coordination.',
            ])
            ->assertCreated()
            ->assertJsonPath('data.role.code', 'fleet-reader')
            ->assertJsonPath('data.status', 'active')
            ->assertJsonPath('data.can_revoke', true);

        $assignmentId = $response->json('data.id');
        $this->assertDatabaseHas('user_role_assignments', [
            'id' => $assignmentId,
            'user_id' => $target->id,
            'role_id' => $role->id,
            'company_id' => $company->id,
            'assigned_by' => $actor->id,
        ]);
        $this->assertDatabaseHas('audit_logs', [
            'event' => 'identity.standard_access_assigned',
            'subject_id' => $assignmentId,
        ]);
    }

    public function test_department_and_location_scopes_require_matching_target_membership(): void
    {
        $company = $this->company('A');
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $department = $this->department($company, 'OPS');
        $location = $this->location($company, 'KRESEK');
        $this->employment($actor, $company);
        $this->employment($target, $company);
        $this->grant($actor, $company, ['identity.access.assign']);
        $departmentRole = $this->standardRole('department-reader', 'department');
        $locationRole = $this->standardRole('location-reader', 'location');
        $token = $this->token($actor, mfaVerified: true);

        $this->withToken($token)
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$target->id}/role-assignments", [
                'role_id' => $departmentRole->id,
                'department_id' => $department->id,
                'valid_from' => today()->toDateString(),
                'reason' => 'Attempt assignment before organization membership exists.',
            ])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'STANDARD_ACCESS_TARGET_SCOPE_NOT_COVERED');

        $this->departmentMembership($target, $company, $department);
        $this->locationMembership($target, $company, $location);

        $this->withToken($token)
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$target->id}/role-assignments", [
                'role_id' => $locationRole->id,
                'department_id' => $department->id,
                'location_id' => $location->id,
                'valid_from' => today()->toDateString(),
                'reason' => 'Assign location access with a narrower department restriction.',
            ])
            ->assertCreated()
            ->assertJsonPath('data.department.id', $department->id)
            ->assertJsonPath('data.location.id', $location->id);
    }

    public function test_role_scope_shape_and_privileged_direct_assignment_are_denied(): void
    {
        $company = $this->company('A');
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->employment($actor, $company);
        $this->employment($target, $company);
        $this->grant($actor, $company, ['identity.access.assign']);
        $departmentRole = $this->standardRole('department-reader', 'department');
        $privilegedRole = $this->standardRole('privileged-owner', 'company', privileged: true);
        $token = $this->token($actor, mfaVerified: true);

        $this->withToken($token)
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$target->id}/role-assignments", [
                'role_id' => $departmentRole->id,
                'valid_from' => today()->toDateString(),
                'reason' => 'Department role without department scope must fail.',
            ])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'STANDARD_ACCESS_ROLE_SCOPE_INVALID');

        $this->withToken($token)
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$target->id}/role-assignments", [
                'role_id' => $privilegedRole->id,
                'valid_from' => today()->toDateString(),
                'reason' => 'Privileged role must use request and approval flow.',
            ])
            ->assertUnprocessable()
            ->assertJsonValidationErrors('role_id');
    }

    public function test_assignment_period_must_be_covered_by_employment(): void
    {
        $company = $this->company('A');
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->employment($actor, $company);
        $this->employment($target, $company, today()->addDays(5));
        $this->grant($actor, $company, ['identity.access.assign']);
        $role = $this->standardRole('temporary-reader', 'company');
        $token = $this->token($actor, mfaVerified: true);

        $this->withToken($token)
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$target->id}/role-assignments", [
                'role_id' => $role->id,
                'valid_from' => today()->toDateString(),
                'valid_until' => today()->addDays(10)->toDateString(),
                'reason' => 'Assignment must not outlive the target employment period.',
            ])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'STANDARD_ACCESS_TARGET_SCOPE_NOT_COVERED');

        $this->withToken($token)
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$target->id}/role-assignments", [
                'role_id' => $role->id,
                'valid_from' => today()->toDateString(),
                'valid_until' => today()->addDays(4)->toDateString(),
                'reason' => 'Time-bounded access remains within employment validity.',
            ])
            ->assertCreated();
    }

    public function test_overlapping_equivalent_assignment_is_rejected(): void
    {
        $company = $this->company('A');
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->employment($actor, $company);
        $this->employment($target, $company);
        $this->grant($actor, $company, ['identity.access.assign']);
        $role = $this->standardRole('fleet-reader', 'company');
        UserRoleAssignment::query()->create([
            'user_id' => $target->id,
            'role_id' => $role->id,
            'company_id' => $company->id,
            'valid_from' => today(),
            'valid_until' => today()->addMonth(),
            'assigned_by' => $actor->id,
        ]);

        $this->withToken($this->token($actor, mfaVerified: true))
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$target->id}/role-assignments", [
                'role_id' => $role->id,
                'valid_from' => today()->addWeek()->toDateString(),
                'valid_until' => today()->addMonths(2)->toDateString(),
                'reason' => 'Duplicate overlapping access should not be created.',
            ])
            ->assertConflict()
            ->assertJsonPath('code', 'STANDARD_ACCESS_ASSIGNMENT_OVERLAP');
    }

    public function test_manager_can_revoke_direct_assignment_but_not_privileged_assignment(): void
    {
        $company = $this->company('A');
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->employment($actor, $company);
        $this->employment($target, $company);
        $this->grant($actor, $company, ['identity.access.assign']);
        $standardRole = $this->standardRole('fleet-reader', 'company');
        $privilegedRole = $this->standardRole('fleet-owner', 'company', privileged: true);
        $direct = $this->assignment($target, $actor, $company, $standardRole);
        $accessRequest = AccessRequest::query()->create([
            'target_user_id' => $target->id,
            'role_id' => $privilegedRole->id,
            'company_id' => $company->id,
            'requested_by' => $actor->id,
            'status' => 'approved',
            'reason' => 'Approved privileged access used to verify endpoint isolation.',
            'requested_valid_until' => now()->addMonth(),
        ]);
        $privileged = $this->assignment($target, $actor, $company, $privilegedRole, $accessRequest->id);
        $token = $this->token($actor, mfaVerified: true);

        $this->withToken($token)
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$target->id}/role-assignments/{$direct->id}/revoke", [
                'reason' => 'Operational access is no longer required by target.',
            ])
            ->assertOk()
            ->assertJsonPath('data.status', 'revoked')
            ->assertJsonPath('data.can_revoke', false);
        $this->assertDatabaseHas('audit_logs', [
            'event' => 'identity.standard_access_revoked',
            'subject_id' => $direct->id,
        ]);

        $this->withToken($token)
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$target->id}/role-assignments/{$privileged->id}/revoke", [
                'reason' => 'Attempt bypass of privileged revocation endpoint.',
            ])
            ->assertNotFound();
    }

    public function test_self_assignment_self_revocation_and_missing_recent_mfa_are_denied(): void
    {
        $company = $this->company('A');
        $actor = User::factory()->create();
        $this->employment($actor, $company);
        $this->grant($actor, $company, ['identity.access.assign']);
        $role = $this->standardRole('fleet-reader', 'company');
        $assignment = $this->assignment($actor, $actor, $company, $role);
        $payload = [
            'role_id' => $role->id,
            'valid_from' => today()->addMonth()->toDateString(),
            'reason' => 'Self-assignment must remain forbidden for access owners.',
        ];

        $this->withToken($this->token($actor, mfaVerified: true))
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$actor->id}/role-assignments", $payload)
            ->assertUnprocessable()
            ->assertJsonPath('code', 'STANDARD_ACCESS_SELF_ASSIGNMENT_DENIED');

        $this->withToken($this->token($actor, mfaVerified: true))
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$actor->id}/role-assignments/{$assignment->id}/revoke", [
                'reason' => 'Self-revocation must remain forbidden for access owners.',
            ])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'STANDARD_ACCESS_SELF_REVOCATION_DENIED');

        $this->withToken($this->token($actor))
            ->postJson("/api/v1/identity/companies/{$company->id}/users/{$actor->id}/role-assignments", $payload)
            ->assertForbidden()
            ->assertJsonPath('code', 'MFA_STEP_UP_REQUIRED');
    }

    private function company(string $code): Company
    {
        return Company::query()->create(['code' => $code, 'legal_name' => "Company {$code}"]);
    }

    private function employment(User $user, Company $company, $validUntil = null): void
    {
        UserCompanyMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'employment_status' => 'active',
            'is_primary' => true,
            'valid_from' => today(),
            'valid_until' => $validUntil,
        ]);
    }

    /** @param array<int, string> $permissionCodes */
    private function grant(User $user, Company $company, array $permissionCodes): void
    {
        $role = Role::query()->create([
            'code' => 'access-owner-'.str()->lower(str()->random(8)),
            'name' => 'Access Owner',
            'is_privileged' => false,
            'assignment_scope' => 'company',
        ]);
        $permissions = collect($permissionCodes)->map(fn (string $code) => Permission::query()->firstOrCreate(
            ['code' => $code],
            ['module' => 'identity', 'resource' => 'access', 'action' => str($code)->afterLast('.')],
        ));
        $role->permissions()->attach($permissions);
        UserRoleAssignment::query()->create([
            'user_id' => $user->id,
            'role_id' => $role->id,
            'company_id' => $company->id,
            'valid_from' => now(),
            'assigned_by' => $user->id,
        ]);
    }

    private function token(User $user, bool $mfaVerified = false): string
    {
        $token = $user->createToken('Standard Access Admin');
        if ($mfaVerified) {
            $token->accessToken->forceFill(['mfa_verified_at' => now()])->save();
        }
        $this->app['auth']->forgetGuards();

        return $token->plainTextToken;
    }

    private function standardRole(string $code, string $scope, bool $privileged = false): Role
    {
        return Role::query()->create([
            'code' => $code,
            'name' => str($code)->headline(),
            'is_privileged' => $privileged,
            'assignment_scope' => $scope,
        ]);
    }

    private function department(Company $company, string $code): Department
    {
        return Department::query()->create([
            'company_id' => $company->id,
            'code' => $code,
            'name' => "Department {$code}",
        ]);
    }

    private function location(Company $company, string $code): Location
    {
        return Location::query()->create([
            'company_id' => $company->id,
            'code' => $code,
            'name' => "Location {$code}",
        ]);
    }

    private function departmentMembership(User $user, Company $company, Department $department): void
    {
        UserDepartmentMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'department_id' => $department->id,
            'is_primary' => true,
            'valid_from' => today(),
        ]);
    }

    private function locationMembership(User $user, Company $company, Location $location): void
    {
        UserLocationMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'location_id' => $location->id,
            'valid_from' => today(),
        ]);
    }

    private function assignment(
        User $target,
        User $actor,
        Company $company,
        Role $role,
        ?string $accessRequestId = null,
    ): UserRoleAssignment {
        return UserRoleAssignment::query()->create([
            'user_id' => $target->id,
            'role_id' => $role->id,
            'company_id' => $company->id,
            'access_request_id' => $accessRequestId,
            'valid_from' => now(),
            'valid_until' => now()->addMonth(),
            'assigned_by' => $actor->id,
        ]);
    }
}
