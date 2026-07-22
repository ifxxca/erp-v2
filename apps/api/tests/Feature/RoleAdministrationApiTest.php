<?php

namespace Tests\Feature;

use App\Models\AccessRequest;
use App\Models\Company;
use App\Models\Permission;
use App\Models\PersonalAccessToken;
use App\Models\Role;
use App\Models\User;
use App\Models\UserRoleAssignment;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class RoleAdministrationApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_catalog_requires_global_view_and_projects_manage_capability(): void
    {
        $scoped = $this->adminToken(['identity.role.view'], global: false);
        $this->withToken($scoped)->getJson('/api/v1/identity/roles')
            ->assertForbidden()
            ->assertJsonPath('code', 'GLOBAL_PERMISSION_DENIED');

        $viewer = $this->adminToken(['identity.role.view']);
        $this->withToken($viewer)->getJson('/api/v1/identity/roles')
            ->assertOk()
            ->assertJsonPath('meta.can_manage', false);

        $manager = $this->adminToken(['identity.role.view', 'identity.role.manage']);
        $this->withToken($manager)->getJson('/api/v1/identity/roles')
            ->assertOk()
            ->assertJsonPath('meta.can_manage', true);
    }

    public function test_catalog_marks_system_roles_and_global_only_permissions(): void
    {
        $system = Role::query()->create([
            'code' => 'security-admin',
            'name' => 'Security Administrator',
            'is_system' => true,
            'is_privileged' => true,
            'assignment_scope' => 'global',
        ]);
        $globalPermission = $this->permission('identity.user.status.manage');
        $system->permissions()->attach($globalPermission);

        $response = $this->withToken($this->adminToken(['identity.role.view']))
            ->getJson('/api/v1/identity/roles')
            ->assertOk();

        $response->assertJsonFragment([
            'code' => 'security-admin',
            'is_system' => true,
            'can_edit' => false,
        ])->assertJsonFragment([
            'code' => 'identity.user.status.manage',
            'global_only' => true,
        ]);
    }

    public function test_manager_can_create_custom_role_with_audit(): void
    {
        $fleetView = $this->permission('fleet.vehicle.view');
        $fleetManage = $this->permission('fleet.vehicle.manage');

        $this->withToken($this->adminToken(['identity.role.manage'], mfaVerified: true))
            ->postJson('/api/v1/identity/roles', [
                'code' => 'regional-fleet-coordinator',
                'name' => 'Regional Fleet Coordinator',
                'description' => 'Coordinates vehicles for one operating location.',
                'is_privileged' => false,
                'assignment_scope' => 'location',
                'permission_ids' => [$fleetView->id, $fleetManage->id],
                'reason' => 'Create least-privilege fleet coordination role.',
            ])
            ->assertCreated()
            ->assertJsonPath('data.code', 'regional-fleet-coordinator')
            ->assertJsonPath('data.is_system', false);

        $role = Role::query()->where('code', 'regional-fleet-coordinator')->firstOrFail();
        $this->assertCount(2, $role->permissions);
        $this->assertDatabaseHas('audit_logs', [
            'event' => 'identity.role.created',
            'subject_id' => $role->id,
        ]);
    }

    public function test_custom_role_cannot_receive_global_only_permission(): void
    {
        $globalPermission = $this->permission('identity.role.manage');

        $this->withToken($this->adminToken(['identity.role.manage'], mfaVerified: true))
            ->postJson('/api/v1/identity/roles', [
                'code' => 'unsafe-role',
                'name' => 'Unsafe Role',
                'is_privileged' => false,
                'assignment_scope' => 'company',
                'permission_ids' => [$globalPermission->id],
                'reason' => 'Attempt a global permission on custom role.',
            ])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'ROLE_GLOBAL_PERMISSION_DENIED');

        $this->assertDatabaseMissing('roles', ['code' => 'unsafe-role']);
    }

    public function test_system_role_is_read_only(): void
    {
        $permission = $this->permission('fleet.vehicle.view');
        $system = Role::query()->create([
            'code' => 'platform-admin',
            'name' => 'Platform Administrator',
            'is_system' => true,
            'is_privileged' => true,
            'assignment_scope' => 'global',
        ]);
        $token = $this->adminToken(['identity.role.manage'], mfaVerified: true);

        $this->withToken($token)->patchJson("/api/v1/identity/roles/{$system->id}", [
            'name' => 'Changed',
            'is_privileged' => true,
            'assignment_scope' => 'company',
            'reason' => 'Attempt to change a protected system role.',
        ])->assertConflict()->assertJsonPath('code', 'ROLE_SYSTEM_PROTECTED');

        $this->withToken($token)->putJson("/api/v1/identity/roles/{$system->id}/permissions", [
            'permission_ids' => [$permission->id],
            'reason' => 'Attempt to change protected permissions.',
        ])->assertConflict()->assertJsonPath('code', 'ROLE_SYSTEM_PROTECTED');

        $this->withToken($token)->deleteJson("/api/v1/identity/roles/{$system->id}", [
            'reason' => 'Attempt to delete a protected system role.',
        ])->assertConflict()->assertJsonPath('code', 'ROLE_SYSTEM_PROTECTED');
    }

    public function test_classification_change_is_blocked_while_role_is_active(): void
    {
        $role = $this->customRole();
        $target = User::factory()->create();
        UserRoleAssignment::query()->create([
            'user_id' => $target->id,
            'role_id' => $role->id,
            'valid_from' => now(),
            'assigned_by' => $target->id,
        ]);

        $this->withToken($this->adminToken(['identity.role.manage'], mfaVerified: true))
            ->patchJson("/api/v1/identity/roles/{$role->id}", [
                'name' => $role->name,
                'description' => null,
                'is_privileged' => true,
                'assignment_scope' => 'department',
                'reason' => 'Attempt classification change while actively assigned.',
            ])
            ->assertConflict()
            ->assertJsonPath('code', 'ROLE_CLASSIFICATION_IN_USE');
    }

    public function test_classification_change_is_blocked_while_role_is_scheduled(): void
    {
        $role = $this->customRole();
        $target = User::factory()->create();
        UserRoleAssignment::query()->create([
            'user_id' => $target->id,
            'role_id' => $role->id,
            'valid_from' => now()->addWeek(),
            'valid_until' => now()->addMonth(),
            'assigned_by' => $target->id,
        ]);

        $this->withToken($this->adminToken(['identity.role.manage'], mfaVerified: true))
            ->patchJson("/api/v1/identity/roles/{$role->id}", [
                'name' => $role->name,
                'description' => null,
                'is_privileged' => true,
                'assignment_scope' => 'department',
                'reason' => 'Attempt classification change while assignment is scheduled.',
            ])
            ->assertConflict()
            ->assertJsonPath('code', 'ROLE_CLASSIFICATION_IN_USE');
    }

    public function test_permission_sync_records_added_and_removed_permissions(): void
    {
        $view = $this->permission('fleet.vehicle.view');
        $manage = $this->permission('fleet.vehicle.manage');
        $role = $this->customRole();
        $role->permissions()->attach($view);

        $this->withToken($this->adminToken(['identity.role.manage'], mfaVerified: true))
            ->putJson("/api/v1/identity/roles/{$role->id}/permissions", [
                'permission_ids' => [$manage->id],
                'reason' => 'Replace read access with fleet management capability.',
            ])
            ->assertOk();

        $this->assertDatabaseMissing('role_permissions', ['role_id' => $role->id, 'permission_id' => $view->id]);
        $this->assertDatabaseHas('role_permissions', ['role_id' => $role->id, 'permission_id' => $manage->id]);
        $this->assertDatabaseHas('audit_logs', [
            'event' => 'identity.role.permissions_updated',
            'subject_id' => $role->id,
        ]);
    }

    public function test_only_unused_custom_role_can_be_deleted(): void
    {
        $unused = $this->customRole('unused-role');
        $used = $this->customRole('used-role');
        AccessRequest::query()->create([
            'target_user_id' => User::factory()->create()->id,
            'role_id' => $used->id,
            'requested_by' => User::factory()->create()->id,
            'status' => 'rejected',
            'reason' => 'Historical rejected access request.',
        ]);
        $token = $this->adminToken(['identity.role.manage'], mfaVerified: true);

        $this->withToken($token)->deleteJson("/api/v1/identity/roles/{$used->id}", [
            'reason' => 'Attempt deleting a role with historical usage.',
        ])->assertConflict()->assertJsonPath('code', 'ROLE_HAS_HISTORY');

        $this->withToken($token)->deleteJson("/api/v1/identity/roles/{$unused->id}", [
            'reason' => 'Remove unused role created during configuration.',
        ])->assertNoContent();
        $this->assertDatabaseMissing('roles', ['id' => $unused->id]);
        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.role.deleted', 'subject_id' => $unused->id]);
    }

    public function test_role_mutations_require_recent_mfa(): void
    {
        $permission = $this->permission('fleet.vehicle.view');

        $this->withToken($this->adminToken(['identity.role.manage']))
            ->postJson('/api/v1/identity/roles', [
                'code' => 'no-step-up',
                'name' => 'No Step Up',
                'is_privileged' => false,
                'assignment_scope' => 'company',
                'permission_ids' => [$permission->id],
                'reason' => 'Attempt mutation without recent MFA verification.',
            ])
            ->assertForbidden()
            ->assertJsonPath('code', 'MFA_STEP_UP_REQUIRED');
    }

    /** @param array<int, string> $permissionCodes */
    private function adminToken(array $permissionCodes, bool $global = true, bool $mfaVerified = false): string
    {
        $user = User::factory()->create();
        $role = Role::query()->create([
            'code' => 'admin-'.str()->lower(str()->random(8)),
            'name' => 'Role Administrator',
            'assignment_scope' => $global ? 'global' : 'company',
        ]);
        $role->permissions()->attach(collect($permissionCodes)->map(fn (string $code) => $this->permission($code)));
        UserRoleAssignment::query()->create([
            'user_id' => $user->id,
            'role_id' => $role->id,
            'company_id' => $global ? null : $this->companyId(),
            'valid_from' => now(),
            'assigned_by' => $user->id,
        ]);
        $plainTextToken = $user->createToken('Role Admin')->plainTextToken;
        if ($mfaVerified) {
            PersonalAccessToken::findToken($plainTextToken)
                ->forceFill(['mfa_verified_at' => now()])
                ->save();
        }
        $this->app['auth']->forgetGuards();

        return $plainTextToken;
    }

    private function permission(string $code): Permission
    {
        return Permission::query()->firstOrCreate(
            ['code' => $code],
            [
                'module' => str($code)->before('.'),
                'resource' => str($code)->between('.', '.'),
                'action' => str($code)->afterLast('.'),
            ],
        );
    }

    private function customRole(string $code = 'custom-role'): Role
    {
        return Role::query()->create([
            'code' => $code,
            'name' => str($code)->headline(),
            'is_system' => false,
            'is_privileged' => false,
            'assignment_scope' => 'company',
        ]);
    }

    private function companyId(): string
    {
        return Company::query()->firstOrCreate(
            ['code' => 'RKS'],
            ['legal_name' => 'Company RKS'],
        )->id;
    }
}
