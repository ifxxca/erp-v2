<?php

namespace Tests\Feature;

use App\Models\Company;
use App\Models\Department;
use App\Models\Location;
use App\Models\MobileRefreshTokenFamily;
use App\Models\Permission;
use App\Models\Role;
use App\Models\User;
use App\Models\UserCompanyMembership;
use App\Models\UserDepartmentMembership;
use App\Models\UserLocationMembership;
use App\Models\UserRoleAssignment;
use App\Modules\Identity\Application\MobileTokenService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class IdentityAdministrationApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_company_directory_and_user_list_are_limited_to_authorized_company(): void
    {
        [$companyA, $companyB] = $this->companies();
        $actor = User::factory()->create();
        $targetA = User::factory()->create(['name' => 'Alpha Employee', 'email' => 'alpha@example.test']);
        $targetB = User::factory()->create(['name' => 'Beta Employee', 'email' => 'beta@example.test']);
        $this->activeEmployment($actor, $companyA);
        $this->activeEmployment($targetA, $companyA, 'A-100');
        $this->activeEmployment($targetB, $companyB, 'B-100');
        $this->grant($actor, 'identity.user.view', $companyA);
        Sanctum::actingAs($actor);

        $this->getJson('/api/v1/identity/companies')
            ->assertOk()
            ->assertJsonCount(1, 'data')
            ->assertJsonPath('data.0.id', $companyA->id);

        $this->getJson("/api/v1/identity/companies/{$companyA->id}/users?search=alpha")
            ->assertOk()
            ->assertJsonCount(1, 'data')
            ->assertJsonPath('data.0.id', $targetA->id)
            ->assertJsonMissing(['email' => $targetB->email]);

        $this->getJson("/api/v1/identity/companies/{$companyB->id}/users")
            ->assertForbidden()
            ->assertJsonPath('code', 'PERMISSION_DENIED');
    }

    public function test_user_detail_does_not_leak_identity_from_another_company(): void
    {
        [$companyA, $companyB] = $this->companies();
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->activeEmployment($actor, $companyA);
        $this->activeEmployment($actor, $companyB);
        $this->activeEmployment($target, $companyA);
        $this->grant($actor, 'identity.user.view', $companyA);
        $this->grant($actor, 'identity.user.view', $companyB);
        Sanctum::actingAs($actor);

        $this->getJson("/api/v1/identity/companies/{$companyB->id}/users/{$target->id}")
            ->assertNotFound();
    }

    public function test_hr_can_schedule_effective_dated_department_and_location_change(): void
    {
        [$company] = $this->companies();
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->activeEmployment($actor, $company);
        $this->activeEmployment($target, $company);
        $this->grant($actor, 'identity.employment.manage', $company);
        $oldDepartment = $this->department($company, 'OLD', 'Old Department');
        $newDepartment = $this->department($company, 'NEW', 'New Department');
        $secondaryDepartment = $this->department($company, 'SECONDARY', 'Secondary Department');
        $oldLocation = $this->location($company, 'OLD');
        $newLocation = $this->location($company, 'NEW');
        $oldDepartmentMembership = UserDepartmentMembership::query()->create([
            'user_id' => $target->id,
            'company_id' => $company->id,
            'department_id' => $oldDepartment->id,
            'is_primary' => true,
            'valid_from' => today()->subMonth(),
        ]);
        $oldLocationMembership = UserLocationMembership::query()->create([
            'user_id' => $target->id,
            'company_id' => $company->id,
            'location_id' => $oldLocation->id,
            'valid_from' => today()->subMonth(),
        ]);
        Sanctum::actingAs($actor);
        $effectiveFrom = today()->addDay();

        $this->putJson("/api/v1/identity/companies/{$company->id}/users/{$target->id}/organization-memberships", [
            'department_ids' => [$newDepartment->id, $secondaryDepartment->id],
            'primary_department_id' => $newDepartment->id,
            'location_ids' => [$newLocation->id],
            'effective_from' => $effectiveFrom->toDateString(),
            'reason' => 'Approved internal organization transfer.',
        ])->assertOk()->assertExactJson([
            'status' => 'scheduled',
            'effective_from' => $effectiveFrom->toDateString(),
        ]);

        $this->assertSame(today()->toDateString(), $oldDepartmentMembership->fresh()->valid_until->toDateString());
        $this->assertSame(today()->toDateString(), $oldLocationMembership->fresh()->valid_until->toDateString());
        $this->assertDatabaseHas('user_department_memberships', [
            'user_id' => $target->id,
            'department_id' => $newDepartment->id,
            'is_primary' => true,
            'valid_from' => $effectiveFrom->toDateString().' 00:00:00',
        ]);
        $this->assertDatabaseHas('user_department_memberships', [
            'user_id' => $target->id,
            'department_id' => $secondaryDepartment->id,
            'is_primary' => false,
        ]);
        $this->assertDatabaseHas('user_location_memberships', [
            'user_id' => $target->id,
            'location_id' => $newLocation->id,
        ]);
        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.organization_memberships_changed']);
    }

    public function test_organization_change_rejects_cross_company_ids_and_schedule_conflicts(): void
    {
        [$companyA, $companyB] = $this->companies();
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->activeEmployment($actor, $companyA);
        $this->activeEmployment($target, $companyA);
        $this->grant($actor, 'identity.employment.manage', $companyA);
        $departmentA = $this->department($companyA, 'A', 'Department A');
        $departmentB = $this->department($companyB, 'B', 'Department B');
        Sanctum::actingAs($actor);
        $effectiveFrom = today()->addDay()->toDateString();
        $payload = [
            'department_ids' => [$departmentB->id],
            'primary_department_id' => $departmentB->id,
            'location_ids' => [],
            'effective_from' => $effectiveFrom,
            'reason' => 'Attempted invalid cross-company transfer.',
        ];

        $this->putJson("/api/v1/identity/companies/{$companyA->id}/users/{$target->id}/organization-memberships", $payload)
            ->assertUnprocessable()
            ->assertJsonPath('code', 'DEPARTMENT_SCOPE_INVALID');

        UserDepartmentMembership::query()->create([
            'user_id' => $target->id,
            'company_id' => $companyA->id,
            'department_id' => $departmentA->id,
            'is_primary' => true,
            'valid_from' => $effectiveFrom,
        ]);
        $payload['department_ids'] = [$departmentA->id];
        $payload['primary_department_id'] = $departmentA->id;
        $this->putJson("/api/v1/identity/companies/{$companyA->id}/users/{$target->id}/organization-memberships", $payload)
            ->assertConflict()
            ->assertJsonPath('code', 'ORGANIZATION_SCHEDULE_CONFLICT');
    }

    public function test_company_scoped_status_permission_cannot_change_global_identity_status(): void
    {
        [$company] = $this->companies();
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->activeEmployment($actor, $company);
        $this->activeEmployment($target, $company);
        $this->grant($actor, 'identity.user.status.manage', $company);
        $token = $this->recentMfaToken($actor);

        $this->withToken($token)->patchJson("/api/v1/identity/users/{$target->id}/status", [
            'status' => 'disabled',
            'reason' => 'Security incident requires immediate containment.',
        ])->assertForbidden()->assertJsonPath('code', 'GLOBAL_PERMISSION_DENIED');

        $this->assertSame('active', $target->fresh()->status);
    }

    public function test_global_admin_can_disable_and_reenable_identity_with_active_employment(): void
    {
        [$company] = $this->companies();
        $actor = User::factory()->create();
        $target = User::factory()->create();
        $this->activeEmployment($actor, $company);
        $this->activeEmployment($target, $company);
        $this->grant($actor, 'identity.user.status.manage');
        $target->createToken('ERP Browser');
        $mobile = $this->app->make(MobileTokenService::class)->issue($target, 'Target Phone');
        $token = $this->recentMfaToken($actor);

        $this->withToken($token)->patchJson("/api/v1/identity/users/{$target->id}/status", [
            'status' => 'disabled',
            'reason' => 'Security incident requires immediate containment.',
        ])->assertOk()->assertJsonPath('data.status', 'disabled');

        $this->assertDatabaseMissing('personal_access_tokens', ['tokenable_id' => $target->id]);
        $this->assertSame('identity_disabled', MobileRefreshTokenFamily::query()->findOrFail($mobile['family_id'])->revocation_reason);
        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.user_status_changed']);

        $this->withToken($token)->patchJson("/api/v1/identity/users/{$target->id}/status", [
            'status' => 'active',
            'reason' => 'Security review completed and employment remains active.',
        ])->assertOk()->assertJsonPath('data.status', 'active');
    }

    public function test_reenable_requires_active_employment_and_self_status_change_is_denied(): void
    {
        [$company] = $this->companies();
        $actor = User::factory()->create();
        $target = User::factory()->create(['status' => 'disabled']);
        $invitedTarget = User::factory()->create(['status' => 'invited']);
        $this->activeEmployment($actor, $company);
        $this->activeEmployment($invitedTarget, $company);
        $this->grant($actor, 'identity.user.status.manage');
        $token = $this->recentMfaToken($actor);

        $this->withToken($token)->patchJson("/api/v1/identity/users/{$target->id}/status", [
            'status' => 'active',
            'reason' => 'Attempt to restore identity without employment.',
        ])->assertConflict()->assertJsonPath('code', 'ACTIVE_EMPLOYMENT_REQUIRED');

        $this->withToken($token)->patchJson("/api/v1/identity/users/{$invitedTarget->id}/status", [
            'status' => 'active',
            'reason' => 'Attempt to bypass invitation acceptance workflow.',
        ])->assertConflict()->assertJsonPath('code', 'INVITATION_ACCEPTANCE_REQUIRED');

        $this->withToken($token)->patchJson("/api/v1/identity/users/{$actor->id}/status", [
            'status' => 'disabled',
            'reason' => 'Attempted self-service status change is forbidden.',
        ])->assertUnprocessable()->assertJsonPath('code', 'SELF_STATUS_CHANGE_DENIED');
    }

    /** @return array{Company, Company} */
    private function companies(): array
    {
        return [
            Company::query()->create(['code' => 'A', 'legal_name' => 'Company A']),
            Company::query()->create(['code' => 'B', 'legal_name' => 'Company B']),
        ];
    }

    private function activeEmployment(User $user, Company $company, ?string $employeeNo = null): void
    {
        UserCompanyMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'employee_no' => $employeeNo,
            'employment_status' => 'active',
            'is_primary' => true,
            'valid_from' => today(),
        ]);
    }

    private function grant(User $user, string $permissionCode, ?Company $company = null): void
    {
        $permission = Permission::query()->firstOrCreate(
            ['code' => $permissionCode],
            ['module' => 'identity', 'resource' => 'administration', 'action' => 'manage'],
        );
        $role = Role::query()->create([
            'code' => 'role-'.str()->random(12),
            'name' => 'Test role',
        ]);
        $role->permissions()->attach($permission);
        UserRoleAssignment::query()->create([
            'user_id' => $user->id,
            'role_id' => $role->id,
            'company_id' => $company?->id,
            'valid_from' => now()->subMinute(),
            'assigned_by' => $user->id,
        ]);
    }

    private function recentMfaToken(User $user): string
    {
        $token = $user->createToken('Admin Browser');
        $token->accessToken->forceFill(['mfa_verified_at' => now()])->save();

        return $token->plainTextToken;
    }

    private function department(Company $company, string $code, string $name): Department
    {
        return Department::query()->create([
            'company_id' => $company->id,
            'code' => $code,
            'name' => $name,
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
}
