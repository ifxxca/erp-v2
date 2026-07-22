<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\TerminateCompanyMembershipRequest;
use App\Models\Company;
use App\Models\User;
use App\Modules\Identity\Application\AuditLogger;
use App\Modules\Identity\Application\MobileTokenService;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;

class CompanyMembershipController extends Controller
{
    public function __construct(
        private readonly AuditLogger $audit,
        private readonly MobileTokenService $mobileTokens,
    ) {}

    public function terminate(
        TerminateCompanyMembershipRequest $request,
        User $user,
        Company $company,
    ): JsonResponse {
        $actor = $request->user();

        if ($actor->is($user)) {
            return response()->json([
                'message' => 'You cannot terminate your own company membership.',
                'code' => 'SELF_TERMINATION_DENIED',
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        $terminated = DB::transaction(function () use ($request, $actor, $user, $company): bool {
            $membership = $user->companyMemberships()
                ->where('company_id', $company->id)
                ->whereIn('employment_status', ['invited', 'active', 'leave'])
                ->lockForUpdate()
                ->first();

            if (! $membership) {
                return false;
            }

            $membership->update([
                'employment_status' => 'terminated',
                'valid_until' => today(),
            ]);
            $user->departmentMemberships()
                ->where('company_id', $company->id)
                ->where(fn (Builder $query) => $query
                    ->whereNull('valid_until')
                    ->orWhere('valid_until', '>', today()))
                ->update(['valid_until' => today()]);
            $user->locationMemberships()
                ->where('company_id', $company->id)
                ->where(fn (Builder $query) => $query
                    ->whereNull('valid_until')
                    ->orWhere('valid_until', '>', today()))
                ->update(['valid_until' => today()]);
            $user->roleAssignments()
                ->active()
                ->where('company_id', $company->id)
                ->update([
                    'revoked_at' => now(),
                    'revoked_by' => $actor->id,
                    'revocation_reason' => $request->validated('reason'),
                ]);

            $hasOtherActiveMembership = $user->companyMemberships()
                ->where('employment_status', 'active')
                ->where('valid_from', '<=', today())
                ->where(fn (Builder $query) => $query
                    ->whereNull('valid_until')
                    ->orWhere('valid_until', '>', today()))
                ->exists();

            if (! $hasOtherActiveMembership) {
                $user->update(['status' => 'disabled']);
            }

            // Tokens are not company-scoped yet, so all devices are revoked to prevent stale access.
            $this->mobileTokens->revokeAllForUser($user, 'company_membership_terminated');
            $user->tokens()->delete();

            $this->audit->record(
                'identity.company_membership_terminated',
                $actor,
                $user,
                [
                    'company_id' => $company->id,
                    'reason' => $request->validated('reason'),
                    'identity_disabled' => ! $hasOtherActiveMembership,
                ],
                $request,
            );

            return true;
        });

        if (! $terminated) {
            return response()->json([
                'message' => 'An active company membership was not found.',
                'code' => 'MEMBERSHIP_NOT_ACTIVE',
            ], Response::HTTP_NOT_FOUND);
        }

        return response()->json(['status' => 'terminated']);
    }
}
