<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\ApproveAccessRequest;
use App\Http\Requests\CreatePrivilegedAccessRequest;
use App\Http\Requests\RejectAccessRequest;
use App\Http\Requests\RevokeRoleAssignmentRequest;
use App\Models\AccessRequest;
use App\Models\Company;
use App\Models\Role;
use App\Models\User;
use App\Models\UserRoleAssignment;
use App\Modules\Identity\Application\PrivilegedAccessService;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Symfony\Component\HttpFoundation\Response;

class PrivilegedAccessController extends Controller
{
    public function __construct(private readonly PrivilegedAccessService $access) {}

    public function index(Request $request, Company $company): JsonResponse
    {
        $validated = $request->validate([
            'status' => ['nullable', Rule::in(['pending', 'approved', 'rejected', 'cancelled'])],
        ]);

        $requests = AccessRequest::query()
            ->where('company_id', $company->id)
            ->when($validated['status'] ?? null, fn ($query, $status) => $query->where('status', $status))
            ->with($this->accessRequestRelations())
            ->latest()
            ->paginate(25)
            ->through(fn (AccessRequest $accessRequest) => $this->accessRequestData($accessRequest));

        return response()->json($requests);
    }

    public function mine(Request $request, Company $company): JsonResponse
    {
        $requests = AccessRequest::query()
            ->where('company_id', $company->id)
            ->where('requested_by', $request->user()->id)
            ->with($this->accessRequestRelations())
            ->latest()
            ->paginate(25)
            ->through(fn (AccessRequest $accessRequest) => $this->accessRequestData($accessRequest));

        return response()->json($requests);
    }

    public function catalog(Company $company): JsonResponse
    {
        $today = today();
        $users = User::query()
            ->where('status', 'active')
            ->whereHas('companyMemberships', fn (Builder $query) => $query
                ->where('company_id', $company->id)
                ->where('employment_status', 'active')
                ->where('valid_from', '<=', $today)
                ->where(fn (Builder $query) => $query
                    ->whereNull('valid_until')
                    ->orWhere('valid_until', '>=', $today)))
            ->withExists(['mfaMethods as mfa_enabled' => fn (Builder $query) => $query->where('status', 'active')])
            ->with([
                'departmentMemberships' => fn ($query) => $query
                    ->where('company_id', $company->id)
                    ->where('valid_from', '<=', $today)
                    ->where(fn (Builder $query) => $query
                        ->whereNull('valid_until')
                        ->orWhere('valid_until', '>=', $today)),
                'locationMemberships' => fn ($query) => $query
                    ->where('company_id', $company->id)
                    ->where('valid_from', '<=', $today)
                    ->where(fn (Builder $query) => $query
                        ->whereNull('valid_until')
                        ->orWhere('valid_until', '>=', $today)),
            ])
            ->orderBy('name')
            ->get(['id', 'name', 'email'])
            ->map(fn (User $user) => [
                ...$user->only(['id', 'name', 'email', 'mfa_enabled']),
                'department_ids' => $user->departmentMemberships->pluck('department_id')->values(),
                'location_ids' => $user->locationMemberships->pluck('location_id')->values(),
            ]);
        $roles = Role::query()
            ->where('is_privileged', true)
            ->whereIn('assignment_scope', ['company', 'department', 'location'])
            ->orderBy('name')
            ->get(['id', 'code', 'name', 'description', 'assignment_scope']);

        return response()->json(['data' => ['users' => $users, 'roles' => $roles]]);
    }

    public function assignments(Company $company): JsonResponse
    {
        $assignments = UserRoleAssignment::query()
            ->active()
            ->where('company_id', $company->id)
            ->whereHas('role', fn (Builder $query) => $query->where('is_privileged', true))
            ->with([
                'user:id,name,email',
                'role:id,code,name,assignment_scope',
            ])
            ->latest('valid_from')
            ->paginate(25)
            ->through(fn (UserRoleAssignment $assignment) => [
                'id' => $assignment->id,
                'user' => $assignment->user,
                'role' => $assignment->role,
                'company_id' => $assignment->company_id,
                'department_id' => $assignment->department_id,
                'location_id' => $assignment->location_id,
                'access_request_id' => $assignment->access_request_id,
                'valid_from' => $assignment->valid_from->toIso8601String(),
                'valid_until' => $assignment->valid_until?->toIso8601String(),
            ]);

        return response()->json($assignments);
    }

    public function store(CreatePrivilegedAccessRequest $request, Company $company): JsonResponse
    {
        $accessRequest = $this->access->request($company, $request->user(), $request->validated(), $request);

        return response()->json($this->accessRequestData($accessRequest), Response::HTTP_CREATED);
    }

    public function approve(
        ApproveAccessRequest $request,
        Company $company,
        AccessRequest $accessRequest,
    ): JsonResponse {
        $assignment = $this->access->approve(
            $company,
            $accessRequest,
            $request->user(),
            $request->validated('note'),
            $request,
        );

        return response()->json([
            'access_request_id' => $accessRequest->id,
            'assignment_id' => $assignment->id,
            'status' => 'approved',
            'valid_until' => $assignment->valid_until->toIso8601String(),
        ]);
    }

    public function reject(
        RejectAccessRequest $request,
        Company $company,
        AccessRequest $accessRequest,
    ): JsonResponse {
        $accessRequest = $this->access->reject(
            $company,
            $accessRequest,
            $request->user(),
            $request->validated('note'),
            $request,
        );

        return response()->json($this->accessRequestData($accessRequest));
    }

    public function revoke(
        RevokeRoleAssignmentRequest $request,
        Company $company,
        UserRoleAssignment $assignment,
    ): JsonResponse {
        $assignment = $this->access->revoke(
            $company,
            $assignment,
            $request->user(),
            $request->validated('reason'),
            $request,
        );

        return response()->json([
            'assignment_id' => $assignment->id,
            'status' => 'revoked',
            'revoked_at' => $assignment->revoked_at->toIso8601String(),
        ]);
    }

    /** @return array<string, mixed> */
    private function accessRequestData(AccessRequest $accessRequest): array
    {
        $accessRequest->loadMissing($this->accessRequestRelations());
        $targetMfaEnabled = array_key_exists('mfa_enabled', $accessRequest->targetUser->getAttributes())
            ? (bool) $accessRequest->targetUser->mfa_enabled
            : $accessRequest->targetUser->mfaMethods()->where('status', 'active')->exists();

        return [
            'id' => $accessRequest->id,
            'status' => $accessRequest->status,
            'target_user' => $accessRequest->targetUser,
            'target_mfa_enabled' => $targetMfaEnabled,
            'role' => $accessRequest->role,
            'company_id' => $accessRequest->company_id,
            'department_id' => $accessRequest->department_id,
            'location_id' => $accessRequest->location_id,
            'reason' => $accessRequest->reason,
            'valid_until' => $accessRequest->requested_valid_until->toIso8601String(),
            'requested_by' => $accessRequest->requester,
            'decided_by' => $accessRequest->decider,
            'decided_at' => $accessRequest->decided_at?->toIso8601String(),
            'decision_note' => $accessRequest->decision_note,
        ];
    }

    /** @return array<int|string, callable|string> */
    private function accessRequestRelations(): array
    {
        return [
            'targetUser' => fn ($query) => $query
                ->select(['id', 'name', 'email'])
                ->withExists(['mfaMethods as mfa_enabled' => fn (Builder $query) => $query
                    ->where('status', 'active')]),
            'role:id,code,name',
            'requester:id,name',
            'decider:id,name',
        ];
    }
}
