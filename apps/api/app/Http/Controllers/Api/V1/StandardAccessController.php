<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\CreateStandardRoleAssignmentRequest;
use App\Http\Requests\RevokeStandardRoleAssignmentRequest;
use App\Models\Company;
use App\Models\Role;
use App\Models\User;
use App\Models\UserRoleAssignment;
use App\Modules\Identity\Application\StandardAccessService;
use Illuminate\Http\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

class StandardAccessController extends Controller
{
    public function __construct(private readonly StandardAccessService $access) {}

    public function index(Company $company, User $user): JsonResponse
    {
        $this->assertCompanyUser($company, $user);
        $roles = Role::query()
            ->where('is_privileged', false)
            ->whereIn('assignment_scope', ['company', 'department', 'location'])
            ->orderBy('name')
            ->get(['id', 'code', 'name', 'description', 'assignment_scope']);
        $assignments = UserRoleAssignment::query()
            ->where('company_id', $company->id)
            ->where('user_id', $user->id)
            ->whereNull('access_request_id')
            ->with(['role:id,code,name,assignment_scope,is_privileged', 'department:id,code,name', 'location:id,code,name', 'assignedBy:id,name', 'revokedBy:id,name'])
            ->latest('valid_from')
            ->get()
            ->map(fn (UserRoleAssignment $assignment) => $this->assignmentData($assignment));

        return response()->json(['data' => ['roles' => $roles, 'assignments' => $assignments]]);
    }

    public function store(
        CreateStandardRoleAssignmentRequest $request,
        Company $company,
        User $user,
    ): JsonResponse {
        $this->assertCompanyUser($company, $user);
        $assignment = $this->access->assign($company, $user, $request->user(), $request->validated(), $request);

        return response()->json(['data' => $this->assignmentData($assignment)], Response::HTTP_CREATED);
    }

    public function revoke(
        RevokeStandardRoleAssignmentRequest $request,
        Company $company,
        User $user,
        UserRoleAssignment $assignment,
    ): JsonResponse {
        $assignment = $this->access->revoke(
            $company,
            $user,
            $assignment,
            $request->user(),
            $request->validated('reason'),
            $request,
        );

        return response()->json(['data' => $this->assignmentData($assignment)]);
    }

    private function assertCompanyUser(Company $company, User $user): void
    {
        if (! $user->companyMemberships()->where('company_id', $company->id)->exists()) {
            abort(Response::HTTP_NOT_FOUND);
        }
    }

    /** @return array<string, mixed> */
    private function assignmentData(UserRoleAssignment $assignment): array
    {
        $status = match (true) {
            (bool) $assignment->revoked_at => 'revoked',
            $assignment->valid_until?->isPast() => 'expired',
            $assignment->valid_from->isFuture() => 'scheduled',
            default => 'active',
        };

        return [
            'id' => $assignment->id,
            'role' => $assignment->role,
            'company_id' => $assignment->company_id,
            'department' => $assignment->department,
            'location' => $assignment->location,
            'valid_from' => $assignment->valid_from->toIso8601String(),
            'valid_until' => $assignment->valid_until?->toIso8601String(),
            'assigned_by' => $assignment->assignedBy,
            'revoked_at' => $assignment->revoked_at?->toIso8601String(),
            'revoked_by' => $assignment->revokedBy,
            'revocation_reason' => $assignment->revocation_reason,
            'status' => $status,
            'can_revoke' => in_array($status, ['active', 'scheduled'], true),
        ];
    }
}
