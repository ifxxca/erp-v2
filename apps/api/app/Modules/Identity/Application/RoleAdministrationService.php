<?php

namespace App\Modules\Identity\Application;

use App\Models\Permission;
use App\Models\Role;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;

class RoleAdministrationService
{
    private const GLOBAL_ONLY_PERMISSIONS = [
        'identity.user.status.manage',
        'identity.role.view',
        'identity.role.manage',
    ];

    public function __construct(private readonly AuditLogger $audit) {}

    /** @param array<string, mixed> $data */
    public function create(User $actor, array $data, Request $request): Role
    {
        return DB::transaction(function () use ($actor, $data, $request): Role {
            $permissionIds = $data['permission_ids'];
            $this->assertPermissionsAssignable($permissionIds);

            $role = Role::query()->create([
                'code' => $data['code'],
                'name' => $data['name'],
                'description' => $data['description'] ?? null,
                'is_system' => false,
                'is_privileged' => $data['is_privileged'],
                'assignment_scope' => $data['assignment_scope'],
            ]);
            $role->permissions()->sync($permissionIds);

            $this->audit->record('identity.role.created', $actor, $role, [
                'reason' => $data['reason'],
                'classification' => $this->classification($role),
                'permission_codes' => $this->permissionCodes($permissionIds),
            ], $request);

            return $role->load('permissions');
        });
    }

    /** @param array<string, mixed> $data */
    public function update(Role $role, User $actor, array $data, Request $request): Role
    {
        return DB::transaction(function () use ($role, $actor, $data, $request): Role {
            $role = Role::query()->lockForUpdate()->findOrFail($role->getKey());
            $this->assertCustomRole($role);
            $classificationChanged = $role->is_privileged !== (bool) $data['is_privileged']
                || $role->assignment_scope !== $data['assignment_scope'];
            if ($classificationChanged && ($role->assignments()
                ->whereNull('revoked_at')
                ->where(fn ($query) => $query->whereNull('valid_until')->orWhere('valid_until', '>', now()))
                ->exists()
                || $role->accessRequests()->where('status', 'pending')->exists())) {
                throw new AccessGovernanceException(
                    'Role classification cannot change while current or scheduled assignments or pending requests exist.',
                    'ROLE_CLASSIFICATION_IN_USE',
                    Response::HTTP_CONFLICT,
                );
            }

            $before = [
                ...$role->only(['name', 'description']),
                ...$this->classification($role),
            ];
            $role->update([
                'name' => $data['name'],
                'description' => $data['description'] ?? null,
                'is_privileged' => $data['is_privileged'],
                'assignment_scope' => $data['assignment_scope'],
            ]);

            $this->audit->record('identity.role.updated', $actor, $role, [
                'reason' => $data['reason'],
                'before' => $before,
                'after' => [
                    ...$role->only(['name', 'description']),
                    ...$this->classification($role),
                ],
            ], $request);

            return $role->load('permissions');
        });
    }

    /** @param array<int, string> $permissionIds */
    public function syncPermissions(Role $role, User $actor, array $permissionIds, string $reason, Request $request): Role
    {
        return DB::transaction(function () use ($role, $actor, $permissionIds, $reason, $request): Role {
            $role = Role::query()->lockForUpdate()->findOrFail($role->getKey());
            $this->assertCustomRole($role);
            $this->assertPermissionsAssignable($permissionIds);
            $before = $role->permissions()->orderBy('code')->pluck('code')->all();
            $after = $this->permissionCodes($permissionIds);
            $role->permissions()->sync($permissionIds);

            $this->audit->record('identity.role.permissions_updated', $actor, $role, [
                'reason' => $reason,
                'added' => array_values(array_diff($after, $before)),
                'removed' => array_values(array_diff($before, $after)),
            ], $request);

            return $role->load('permissions');
        });
    }

    public function delete(Role $role, User $actor, string $reason, Request $request): void
    {
        DB::transaction(function () use ($role, $actor, $reason, $request): void {
            $role = Role::query()->lockForUpdate()->findOrFail($role->getKey());
            $this->assertCustomRole($role);
            if ($role->assignments()->exists() || $role->accessRequests()->exists()) {
                throw new AccessGovernanceException(
                    'A role with assignment or request history cannot be deleted.',
                    'ROLE_HAS_HISTORY',
                    Response::HTTP_CONFLICT,
                );
            }

            $this->audit->record('identity.role.deleted', $actor, $role, [
                'reason' => $reason,
                'role' => [
                    ...$role->only(['code', 'name', 'description']),
                    ...$this->classification($role),
                    'permission_codes' => $role->permissions()->orderBy('code')->pluck('code')->all(),
                ],
            ], $request);
            $role->permissions()->detach();
            $role->delete();
        });
    }

    private function assertCustomRole(Role $role): void
    {
        if ($role->is_system) {
            throw new AccessGovernanceException(
                'System roles are read-only and must change through a reviewed release.',
                'ROLE_SYSTEM_PROTECTED',
                Response::HTTP_CONFLICT,
            );
        }
    }

    /** @param array<int, string> $permissionIds */
    private function assertPermissionsAssignable(array $permissionIds): void
    {
        $containsGlobalOnly = Permission::query()
            ->whereKey($permissionIds)
            ->whereIn('code', self::GLOBAL_ONLY_PERMISSIONS)
            ->exists();
        if ($containsGlobalOnly) {
            throw new AccessGovernanceException(
                'Global-only permissions cannot be attached to custom roles.',
                'ROLE_GLOBAL_PERMISSION_DENIED',
            );
        }
    }

    /** @param array<int, string> $permissionIds
     * @return array<int, string>
     */
    private function permissionCodes(array $permissionIds): array
    {
        return Permission::query()->whereKey($permissionIds)->orderBy('code')->pluck('code')->all();
    }

    /** @return array{is_privileged: bool, assignment_scope: string} */
    private function classification(Role $role): array
    {
        return [
            'is_privileged' => $role->is_privileged,
            'assignment_scope' => $role->assignment_scope,
        ];
    }
}
