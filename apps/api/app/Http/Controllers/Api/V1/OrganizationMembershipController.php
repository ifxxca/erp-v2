<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\UpdateOrganizationMembershipsRequest;
use App\Models\Company;
use App\Models\User;
use App\Modules\Identity\Application\IdentityAdministrationService;
use Illuminate\Http\JsonResponse;

class OrganizationMembershipController extends Controller
{
    public function __construct(private readonly IdentityAdministrationService $identity) {}

    public function update(
        UpdateOrganizationMembershipsRequest $request,
        Company $company,
        User $user,
    ): JsonResponse {
        $this->identity->updateOrganizationMemberships(
            $company,
            $user,
            $request->user(),
            $request->validated(),
            $request,
        );

        return response()->json([
            'status' => 'scheduled',
            'effective_from' => $request->validated('effective_from'),
        ]);
    }
}
