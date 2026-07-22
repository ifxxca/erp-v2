<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Company;
use App\Modules\Identity\Application\EffectivePermissionResolver;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class IdentityCompanyController extends Controller
{
    public function __construct(private readonly EffectivePermissionResolver $permissions) {}

    public function index(Request $request): JsonResponse
    {
        $user = $request->user();
        $hasGlobalView = $this->permissions->allowsGlobal($user, 'identity.user.view');
        $companies = Company::query()
            ->where('status', 'active')
            ->orderBy('code')
            ->get(['id', 'code', 'legal_name'])
            ->map(function (Company $company) use ($user, $hasGlobalView): ?array {
                $canViewUsers = $hasGlobalView
                    || $this->permissions->allows($user, 'identity.user.view', $company->id);
                if (! $canViewUsers) {
                    return null;
                }

                return [
                    ...$company->only(['id', 'code', 'legal_name']),
                    'capabilities' => [
                        'can_view_users' => true,
                        'can_invite_users' => $this->permissions->allows(
                            $user,
                            'identity.user.manage',
                            $company->id,
                        ),
                        'can_manage_employment' => $this->permissions->allows(
                            $user,
                            'identity.employment.manage',
                            $company->id,
                        ),
                        'can_request_access' => $this->permissions->allows(
                            $user,
                            'identity.access.request',
                            $company->id,
                        ),
                        'can_approve_access' => $this->permissions->allows(
                            $user,
                            'identity.access.approve',
                            $company->id,
                        ),
                        'can_revoke_access' => $this->permissions->allows(
                            $user,
                            'identity.access.revoke',
                            $company->id,
                        ),
                    ],
                ];
            })
            ->filter()
            ->values();

        return response()->json([
            'data' => $companies,
            'meta' => [
                'can_manage_identity_status' => $this->permissions->allowsGlobal(
                    $user,
                    'identity.user.status.manage',
                ),
                'can_view_roles' => $this->permissions->allowsGlobal($user, 'identity.role.view'),
                'can_manage_roles' => $this->permissions->allowsGlobal($user, 'identity.role.manage'),
            ],
        ]);
    }

    public function organization(Company $company): JsonResponse
    {
        return response()->json([
            'data' => [
                'company' => $company->only(['id', 'code', 'legal_name']),
                'departments' => $company->departments()
                    ->where('status', 'active')
                    ->orderBy('name')
                    ->get(['id', 'code', 'name', 'parent_id']),
                'locations' => $company->locations()
                    ->where('status', 'active')
                    ->orderBy('name')
                    ->get(['id', 'code', 'name', 'timezone']),
            ],
        ]);
    }
}
