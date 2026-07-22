<?php

namespace Tests\Feature;

use App\Models\Company;
use App\Models\Location;
use App\Models\Permission;
use App\Models\Role;
use App\Models\User;
use App\Models\UserCompanyMembership;
use App\Models\UserLocationMembership;
use App\Models\UserRoleAssignment;
use App\Modules\Identity\Application\EffectivePermissionResolver;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class EffectivePermissionResolverTest extends TestCase
{
    use RefreshDatabase;

    public function test_company_scoped_permission_does_not_leak_to_another_company(): void
    {
        $user = User::factory()->create();
        $companyA = Company::query()->create(['code' => 'A', 'legal_name' => 'Company A']);
        $companyB = Company::query()->create(['code' => 'B', 'legal_name' => 'Company B']);

        foreach ([$companyA, $companyB] as $company) {
            UserCompanyMembership::query()->create([
                'user_id' => $user->id,
                'company_id' => $company->id,
                'employment_status' => 'active',
                'is_primary' => $company->is($companyA),
                'valid_from' => today(),
            ]);
        }

        $permission = Permission::query()->create([
            'code' => 'fleet.vehicle.view',
            'module' => 'fleet',
            'resource' => 'vehicle',
            'action' => 'view',
        ]);
        $role = Role::query()->create(['code' => 'fleet-manager', 'name' => 'Fleet Manager']);
        $role->permissions()->attach($permission);

        UserRoleAssignment::query()->create([
            'user_id' => $user->id,
            'role_id' => $role->id,
            'company_id' => $companyA->id,
            'valid_from' => now(),
            'assigned_by' => $user->id,
        ]);

        $resolver = app(EffectivePermissionResolver::class);

        $this->assertTrue($resolver->allows($user, 'fleet.vehicle.view', $companyA->id));
        $this->assertFalse($resolver->allows($user, 'fleet.vehicle.view', $companyB->id));
    }

    public function test_disabled_user_is_always_denied(): void
    {
        $user = User::factory()->create(['status' => 'disabled']);
        $company = Company::query()->create(['code' => 'A', 'legal_name' => 'Company A']);

        $this->assertFalse(
            app(EffectivePermissionResolver::class)->allows($user, 'fleet.vehicle.view', $company->id),
        );
    }

    public function test_global_permission_applies_across_companies_without_company_employment(): void
    {
        $user = User::factory()->create();
        $company = Company::query()->create(['code' => 'A', 'legal_name' => 'Company A']);
        $permission = Permission::query()->create([
            'code' => 'identity.user.view',
            'module' => 'identity',
            'resource' => 'user',
            'action' => 'view',
        ]);
        $role = Role::query()->create(['code' => 'security-admin', 'name' => 'Security Administrator']);
        $role->permissions()->attach($permission);
        UserRoleAssignment::query()->create([
            'user_id' => $user->id,
            'role_id' => $role->id,
            'valid_from' => now(),
            'assigned_by' => $user->id,
        ]);

        $resolver = app(EffectivePermissionResolver::class);

        $this->assertTrue($resolver->allowsGlobal($user, 'identity.user.view'));
        $this->assertTrue($resolver->allows($user, 'identity.user.view', $company->id));
    }

    public function test_location_scoped_permission_requires_active_location_membership(): void
    {
        $user = User::factory()->create();
        $company = Company::query()->create(['code' => 'A', 'legal_name' => 'Company A']);
        $location = Location::query()->create([
            'company_id' => $company->id,
            'code' => 'WH-A',
            'name' => 'Warehouse A',
        ]);
        UserCompanyMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'employment_status' => 'active',
            'is_primary' => true,
            'valid_from' => today(),
        ]);
        $permission = Permission::query()->create([
            'code' => 'fleet.vehicle.view',
            'module' => 'fleet',
            'resource' => 'vehicle',
            'action' => 'view',
        ]);
        $role = Role::query()->create(['code' => 'fleet-manager', 'name' => 'Fleet Manager']);
        $role->permissions()->attach($permission);
        UserRoleAssignment::query()->create([
            'user_id' => $user->id,
            'role_id' => $role->id,
            'company_id' => $company->id,
            'location_id' => $location->id,
            'valid_from' => now(),
            'assigned_by' => $user->id,
        ]);

        $resolver = app(EffectivePermissionResolver::class);
        $this->assertFalse($resolver->allows($user, 'fleet.vehicle.view', $company->id, locationId: $location->id));

        UserLocationMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'location_id' => $location->id,
            'valid_from' => today(),
        ]);

        $this->assertTrue($resolver->allows($user, 'fleet.vehicle.view', $company->id, locationId: $location->id));
    }
}
