<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\CreateRoleRequest;
use App\Http\Requests\DeleteRoleRequest;
use App\Http\Requests\SyncRolePermissionsRequest;
use App\Http\Requests\UpdateRoleRequest;
use App\Models\Permission;
use App\Models\Role;
use App\Modules\Identity\Application\EffectivePermissionResolver;
use App\Modules\Identity\Application\RoleAdministrationService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RoleAdministrationController extends Controller
{
    public function __construct(
        private readonly RoleAdministrationService $roles,
        private readonly EffectivePermissionResolver $permissions,
    ) {}

    public function index(Request $request): JsonResponse
    {
        $roles = Role::query()
            ->with('permissions:id,code')
            ->withCount('assignments')
            ->withCount('accessRequests')
            ->withCount(['assignments as active_assignments_count' => fn ($query) => $query->active()])
            ->orderByDesc('is_system')
            ->orderBy('name')
            ->get()
            ->map(fn (Role $role) => [
                ...$role->only(['id', 'code', 'name', 'description', 'is_system', 'is_privileged', 'assignment_scope']),
                'permission_ids' => $role->permissions->pluck('id')->all(),
                'permission_count' => $role->permissions->count(),
                'assignment_count' => $role->assignments_count,
                'active_assignment_count' => $role->active_assignments_count,
                'has_history' => $role->assignments_count > 0 || $role->access_requests_count > 0,
                'can_edit' => ! $role->is_system,
            ]);

        $permissions = Permission::query()
            ->orderBy('module')
            ->orderBy('code')
            ->get(['id', 'code', 'module', 'resource', 'action', 'description'])
            ->map(fn (Permission $permission) => [
                ...$permission->toArray(),
                'global_only' => in_array($permission->code, [
                    'identity.user.status.manage',
                    'identity.role.view',
                    'identity.role.manage',
                ], true),
            ]);

        return response()->json([
            'data' => ['roles' => $roles, 'permissions' => $permissions],
            'meta' => [
                'can_manage' => $this->permissions->allowsGlobal($request->user(), 'identity.role.manage'),
            ],
        ]);
    }

    public function store(CreateRoleRequest $request): JsonResponse
    {
        return response()->json([
            'data' => $this->roles->create($request->user(), $request->validated(), $request),
        ], Response::HTTP_CREATED);
    }

    public function update(UpdateRoleRequest $request, Role $role): JsonResponse
    {
        return response()->json([
            'data' => $this->roles->update($role, $request->user(), $request->validated(), $request),
        ]);
    }

    public function syncPermissions(SyncRolePermissionsRequest $request, Role $role): JsonResponse
    {
        return response()->json([
            'data' => $this->roles->syncPermissions(
                $role,
                $request->user(),
                $request->validated('permission_ids'),
                $request->validated('reason'),
                $request,
            ),
        ]);
    }

    public function destroy(DeleteRoleRequest $request, Role $role): Response
    {
        $this->roles->delete($role, $request->user(), $request->validated('reason'), $request);

        return response()->noContent();
    }
}
