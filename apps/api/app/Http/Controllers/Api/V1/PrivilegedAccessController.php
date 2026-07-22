<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\ApproveAccessRequest;
use App\Http\Requests\CreatePrivilegedAccessRequest;
use App\Http\Requests\RejectAccessRequest;
use App\Http\Requests\RevokeRoleAssignmentRequest;
use App\Models\AccessRequest;
use App\Models\Company;
use App\Models\UserRoleAssignment;
use App\Modules\Identity\Application\PrivilegedAccessService;
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
            ->with(['targetUser:id,name,email', 'role:id,code,name', 'requester:id,name', 'decider:id,name'])
            ->latest()
            ->paginate(25)
            ->through(fn (AccessRequest $accessRequest) => $this->accessRequestData($accessRequest));

        return response()->json($requests);
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
        $accessRequest->loadMissing(['targetUser:id,name,email', 'role:id,code,name', 'requester:id,name', 'decider:id,name']);

        return [
            'id' => $accessRequest->id,
            'status' => $accessRequest->status,
            'target_user' => $accessRequest->targetUser,
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
}
