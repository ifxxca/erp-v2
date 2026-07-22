<?php

namespace App\Modules\Identity\Application;

use App\Models\Company;
use App\Models\Department;
use App\Models\Location;
use App\Models\User;
use App\Models\UserDepartmentMembership;
use App\Models\UserLocationMembership;
use Carbon\CarbonImmutable;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;

class IdentityAdministrationService
{
    public function __construct(
        private readonly AuditLogger $audit,
        private readonly IdentityEligibility $eligibility,
        private readonly MobileTokenService $mobileTokens,
    ) {}

    /** @param array<string, mixed> $data */
    public function updateOrganizationMemberships(
        Company $company,
        User $user,
        User $actor,
        array $data,
        Request $request,
    ): void {
        $effectiveFrom = CarbonImmutable::parse($data['effective_from'])->startOfDay();
        $departmentIds = array_values($data['department_ids']);
        $locationIds = array_values($data['location_ids']);

        DB::transaction(function () use (
            $company,
            $user,
            $actor,
            $data,
            $request,
            $effectiveFrom,
            $departmentIds,
            $locationIds,
        ): void {
            $activeEmployment = $user->companyMemberships()
                ->where('company_id', $company->id)
                ->where('employment_status', 'active')
                ->where('valid_from', '<=', $effectiveFrom->toDateString())
                ->where(fn (Builder $query) => $query
                    ->whereNull('valid_until')
                    ->orWhere('valid_until', '>=', $effectiveFrom->toDateString()))
                ->lockForUpdate()
                ->first();

            if (! $activeEmployment) {
                throw new AccessGovernanceException(
                    'The identity has no active employment in this company on the effective date.',
                    'EMPLOYMENT_NOT_ACTIVE',
                    Response::HTTP_CONFLICT,
                );
            }

            $validDepartmentIds = Department::query()
                ->where('company_id', $company->id)
                ->where('status', 'active')
                ->whereKey($departmentIds)
                ->pluck('id');
            if ($validDepartmentIds->count() !== count($departmentIds)) {
                throw new AccessGovernanceException(
                    'Every department must be active and belong to the requested company.',
                    'DEPARTMENT_SCOPE_INVALID',
                );
            }

            $validLocationIds = Location::query()
                ->where('company_id', $company->id)
                ->where('status', 'active')
                ->whereKey($locationIds)
                ->pluck('id');
            if ($validLocationIds->count() !== count($locationIds)) {
                throw new AccessGovernanceException(
                    'Every location must be active and belong to the requested company.',
                    'LOCATION_SCOPE_INVALID',
                );
            }

            $hasFutureConflict = $user->departmentMemberships()
                ->where('company_id', $company->id)
                ->where('valid_from', '>=', $effectiveFrom->toDateString())
                ->exists()
                || $user->locationMemberships()
                    ->where('company_id', $company->id)
                    ->where('valid_from', '>=', $effectiveFrom->toDateString())
                    ->exists();
            if ($hasFutureConflict) {
                throw new AccessGovernanceException(
                    'Organization memberships are already scheduled on or after this effective date.',
                    'ORGANIZATION_SCHEDULE_CONFLICT',
                    Response::HTTP_CONFLICT,
                );
            }

            $activeDepartments = $user->departmentMemberships()
                ->where('company_id', $company->id)
                ->where('valid_from', '<', $effectiveFrom->toDateString())
                ->where(fn (Builder $query) => $query
                    ->whereNull('valid_until')
                    ->orWhere('valid_until', '>=', $effectiveFrom->toDateString()))
                ->lockForUpdate()
                ->get();
            $activeLocations = $user->locationMemberships()
                ->where('company_id', $company->id)
                ->where('valid_from', '<', $effectiveFrom->toDateString())
                ->where(fn (Builder $query) => $query
                    ->whereNull('valid_until')
                    ->orWhere('valid_until', '>=', $effectiveFrom->toDateString()))
                ->lockForUpdate()
                ->get();
            $previousDepartmentIds = $activeDepartments->pluck('department_id')->values()->all();
            $previousLocationIds = $activeLocations->pluck('location_id')->values()->all();
            $closesAt = $effectiveFrom->subDay()->toDateString();
            UserDepartmentMembership::query()->whereKey($activeDepartments->modelKeys())
                ->update(['valid_until' => $closesAt]);
            UserLocationMembership::query()->whereKey($activeLocations->modelKeys())
                ->update(['valid_until' => $closesAt]);

            foreach ($departmentIds as $departmentId) {
                UserDepartmentMembership::query()->create([
                    'user_id' => $user->id,
                    'company_id' => $company->id,
                    'department_id' => $departmentId,
                    'is_primary' => $departmentId === $data['primary_department_id'],
                    'valid_from' => $effectiveFrom,
                ]);
            }
            foreach ($locationIds as $locationId) {
                UserLocationMembership::query()->create([
                    'user_id' => $user->id,
                    'company_id' => $company->id,
                    'location_id' => $locationId,
                    'valid_from' => $effectiveFrom,
                ]);
            }

            $this->audit->record(
                'identity.organization_memberships_changed',
                $actor,
                $user,
                [
                    'company_id' => $company->id,
                    'effective_from' => $effectiveFrom->toDateString(),
                    'previous_department_ids' => $previousDepartmentIds,
                    'department_ids' => $departmentIds,
                    'primary_department_id' => $data['primary_department_id'],
                    'previous_location_ids' => $previousLocationIds,
                    'location_ids' => $locationIds,
                    'reason' => $data['reason'],
                ],
                $request,
            );
        });
    }

    public function changeStatus(
        User $user,
        User $actor,
        string $status,
        string $reason,
        Request $request,
    ): User {
        if ($actor->is($user)) {
            throw new AccessGovernanceException(
                'You cannot change your own identity status.',
                'SELF_STATUS_CHANGE_DENIED',
            );
        }

        return DB::transaction(function () use ($user, $actor, $status, $reason, $request): User {
            $user = User::query()->lockForUpdate()->findOrFail($user->id);
            $previousStatus = $user->status;

            if ($previousStatus === $status) {
                throw new AccessGovernanceException(
                    'The identity already has the requested status.',
                    'IDENTITY_STATUS_UNCHANGED',
                    Response::HTTP_CONFLICT,
                );
            }
            if ($previousStatus === 'invited' && $status === 'active') {
                throw new AccessGovernanceException(
                    'An invited identity must complete invitation acceptance before activation.',
                    'INVITATION_ACCEPTANCE_REQUIRED',
                    Response::HTTP_CONFLICT,
                );
            }
            if ($status === 'active' && ! $this->eligibility->hasActiveEmployment($user)) {
                throw new AccessGovernanceException(
                    'An identity can only be re-enabled while active employment exists.',
                    'ACTIVE_EMPLOYMENT_REQUIRED',
                    Response::HTTP_CONFLICT,
                );
            }

            $user->update(['status' => $status]);
            if (in_array($status, ['suspended', 'disabled'], true)) {
                $this->mobileTokens->revokeAllForUser($user, "identity_{$status}");
                $user->tokens()->delete();
            }
            $this->audit->record(
                'identity.user_status_changed',
                $actor,
                $user,
                ['from' => $previousStatus, 'to' => $status, 'reason' => $reason],
                $request,
            );

            return $user;
        });
    }
}
