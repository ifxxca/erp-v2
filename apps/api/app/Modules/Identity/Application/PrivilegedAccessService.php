<?php

namespace App\Modules\Identity\Application;

use App\Models\AccessRequest;
use App\Models\Company;
use App\Models\Role;
use App\Models\User;
use App\Models\UserRoleAssignment;
use App\Notifications\PrivilegedAccessNotification;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Notification;
use Symfony\Component\HttpFoundation\Response;

class PrivilegedAccessService
{
    public function __construct(
        private readonly AuditLogger $audit,
        private readonly MobileTokenService $mobileTokens,
    ) {}

    /** @param array<string, mixed> $data */
    public function request(Company $company, User $actor, array $data, Request $httpRequest): AccessRequest
    {
        $target = User::query()->findOrFail($data['target_user_id']);
        $role = Role::query()->findOrFail($data['role_id']);

        if ($actor->is($target)) {
            throw new AccessGovernanceException(
                'Requester and target user must be different.',
                'ACCESS_REQUEST_SELF_TARGET_DENIED',
            );
        }

        $this->assertActiveTargetScope(
            $target,
            $company,
            $data['department_id'] ?? null,
            $data['location_id'] ?? null,
        );
        $this->assertRoleScope($role, $data['department_id'] ?? null, $data['location_id'] ?? null);

        $accessRequest = DB::transaction(function () use ($company, $actor, $target, $data, $httpRequest) {
            $duplicate = $this->scopeQuery(
                AccessRequest::query()
                    ->where('target_user_id', $target->id)
                    ->where('role_id', $data['role_id'])
                    ->where('company_id', $company->id)
                    ->where('status', 'pending'),
                $data['department_id'] ?? null,
                $data['location_id'] ?? null,
            )->lockForUpdate()->exists();

            if ($duplicate) {
                throw new AccessGovernanceException(
                    'An equivalent privileged access request is already pending.',
                    'ACCESS_REQUEST_DUPLICATE',
                    Response::HTTP_CONFLICT,
                );
            }

            $activeAssignment = $this->scopeQuery(
                UserRoleAssignment::query()
                    ->active()
                    ->where('user_id', $target->id)
                    ->where('role_id', $data['role_id'])
                    ->where('company_id', $company->id),
                $data['department_id'] ?? null,
                $data['location_id'] ?? null,
            )->exists();

            if ($activeAssignment) {
                throw new AccessGovernanceException(
                    'The target already has an equivalent active assignment.',
                    'ACCESS_ASSIGNMENT_EXISTS',
                    Response::HTTP_CONFLICT,
                );
            }

            $accessRequest = AccessRequest::query()->create([
                'target_user_id' => $target->id,
                'role_id' => $data['role_id'],
                'company_id' => $company->id,
                'department_id' => $data['department_id'] ?? null,
                'location_id' => $data['location_id'] ?? null,
                'requested_by' => $actor->id,
                'status' => 'pending',
                'reason' => $data['reason'],
                'requested_valid_until' => $data['valid_until'],
            ]);

            $this->audit->record(
                'identity.privileged_access_requested',
                $actor,
                $accessRequest,
                [
                    'target_user_id' => $target->id,
                    'role_id' => $data['role_id'],
                    'company_id' => $company->id,
                ],
                $httpRequest,
            );

            return $accessRequest;
        });

        $accessRequest->load(['targetUser', 'role', 'company', 'requester']);
        $recipients = $this->companyAccessOwners($company)
            ->push($target)
            ->unique('id');
        Notification::send($recipients, new PrivilegedAccessNotification(
            'requested',
            $accessRequest->role->name,
            $company->legal_name,
            $target->name,
            $data['reason'],
        ));

        return $accessRequest;
    }

    public function approve(
        Company $company,
        AccessRequest $accessRequest,
        User $actor,
        ?string $note,
        Request $httpRequest,
    ): UserRoleAssignment {
        $assignment = DB::transaction(function () use ($company, $accessRequest, $actor, $note, $httpRequest) {
            $accessRequest = AccessRequest::query()->lockForUpdate()->findOrFail($accessRequest->id);
            $this->assertRequestCompany($accessRequest, $company);
            $this->assertCanDecide($accessRequest, $actor);

            if ($accessRequest->requested_valid_until->isPast()) {
                $accessRequest->update([
                    'status' => 'cancelled',
                    'decided_at' => now(),
                    'decision_note' => 'Expired before approval.',
                ]);
                $this->audit->record(
                    'identity.privileged_access_expired',
                    $actor,
                    $accessRequest,
                    request: $httpRequest,
                );

                return null;
            }

            $accessRequest->loadMissing(['targetUser', 'role']);
            if (! $accessRequest->role->is_privileged) {
                throw new AccessGovernanceException(
                    'The requested role is no longer classified as privileged.',
                    'ACCESS_ROLE_CLASSIFICATION_CHANGED',
                    Response::HTTP_CONFLICT,
                );
            }
            $this->assertRoleScope(
                $accessRequest->role,
                $accessRequest->department_id,
                $accessRequest->location_id,
            );
            $this->assertActiveTargetScope(
                $accessRequest->targetUser,
                $company,
                $accessRequest->department_id,
                $accessRequest->location_id,
            );
            if (! $accessRequest->targetUser->mfaMethods()->where('status', 'active')->exists()) {
                throw new AccessGovernanceException(
                    'The target user must enroll MFA before privileged access can be approved.',
                    'ACCESS_TARGET_MFA_REQUIRED',
                    Response::HTTP_CONFLICT,
                );
            }

            $duplicate = $this->scopeQuery(
                UserRoleAssignment::query()
                    ->active()
                    ->where('user_id', $accessRequest->target_user_id)
                    ->where('role_id', $accessRequest->role_id)
                    ->where('company_id', $company->id),
                $accessRequest->department_id,
                $accessRequest->location_id,
            )->exists();

            if ($duplicate) {
                throw new AccessGovernanceException(
                    'The target already has an equivalent active assignment.',
                    'ACCESS_ASSIGNMENT_EXISTS',
                    Response::HTTP_CONFLICT,
                );
            }

            $accessRequest->update([
                'status' => 'approved',
                'decided_by' => $actor->id,
                'decided_at' => now(),
                'decision_note' => $note,
            ]);
            $assignment = UserRoleAssignment::query()->create([
                'user_id' => $accessRequest->target_user_id,
                'role_id' => $accessRequest->role_id,
                'company_id' => $accessRequest->company_id,
                'department_id' => $accessRequest->department_id,
                'location_id' => $accessRequest->location_id,
                'access_request_id' => $accessRequest->id,
                'valid_from' => now(),
                'valid_until' => $accessRequest->requested_valid_until,
                'assigned_by' => $actor->id,
            ]);

            $this->audit->record(
                'identity.privileged_access_approved',
                $actor,
                $assignment,
                ['access_request_id' => $accessRequest->id, 'company_id' => $company->id],
                $httpRequest,
            );

            return $assignment;
        });

        if (! $assignment) {
            throw new AccessGovernanceException(
                'The access request expired before approval.',
                'ACCESS_REQUEST_EXPIRED',
                Response::HTTP_CONFLICT,
            );
        }

        $this->notifyDecision($accessRequest->fresh(), $company, 'approved', $note);

        return $assignment;
    }

    public function reject(
        Company $company,
        AccessRequest $accessRequest,
        User $actor,
        string $note,
        Request $httpRequest,
    ): AccessRequest {
        $accessRequest = DB::transaction(function () use ($company, $accessRequest, $actor, $note, $httpRequest) {
            $accessRequest = AccessRequest::query()->lockForUpdate()->findOrFail($accessRequest->id);
            $this->assertRequestCompany($accessRequest, $company);
            $this->assertCanDecide($accessRequest, $actor);
            $accessRequest->update([
                'status' => 'rejected',
                'decided_by' => $actor->id,
                'decided_at' => now(),
                'decision_note' => $note,
            ]);
            $this->audit->record(
                'identity.privileged_access_rejected',
                $actor,
                $accessRequest,
                ['company_id' => $company->id, 'note' => $note],
                $httpRequest,
            );

            return $accessRequest;
        });

        $this->notifyDecision($accessRequest, $company, 'rejected', $note);

        return $accessRequest;
    }

    public function revoke(
        Company $company,
        UserRoleAssignment $assignment,
        User $actor,
        string $reason,
        Request $httpRequest,
    ): UserRoleAssignment {
        $assignment = DB::transaction(function () use ($company, $assignment, $actor, $reason, $httpRequest) {
            $assignment = UserRoleAssignment::query()->lockForUpdate()->findOrFail($assignment->id);

            if ($assignment->company_id !== $company->id) {
                abort(Response::HTTP_NOT_FOUND);
            }
            if ($assignment->user_id === $actor->id) {
                throw new AccessGovernanceException(
                    'You cannot revoke your own privileged assignment.',
                    'ACCESS_SELF_REVOCATION_DENIED',
                );
            }
            if ($assignment->revoked_at || $assignment->valid_until?->isPast()) {
                throw new AccessGovernanceException(
                    'The assignment is not active.',
                    'ACCESS_ASSIGNMENT_NOT_ACTIVE',
                    Response::HTTP_CONFLICT,
                );
            }

            $assignment->update([
                'revoked_at' => now(),
                'revoked_by' => $actor->id,
                'revocation_reason' => $reason,
            ]);
            $this->mobileTokens->revokeAllForUser($assignment->user, 'privileged_access_revoked');
            $assignment->user->tokens()->delete();
            $this->audit->record(
                'identity.privileged_access_revoked',
                $actor,
                $assignment,
                ['company_id' => $company->id, 'reason' => $reason],
                $httpRequest,
            );

            return $assignment;
        });

        $assignment->loadMissing(['user', 'role']);
        $assignment->user->notify(new PrivilegedAccessNotification(
            'revoked',
            $assignment->role->name,
            $company->legal_name,
            $assignment->user->name,
            $reason,
        ));

        return $assignment;
    }

    private function assertCanDecide(AccessRequest $accessRequest, User $actor): void
    {
        if ($accessRequest->status !== 'pending') {
            throw new AccessGovernanceException(
                'Only a pending access request can be decided.',
                'ACCESS_REQUEST_NOT_PENDING',
                Response::HTTP_CONFLICT,
            );
        }
        if ($accessRequest->requested_by === $actor->id || $accessRequest->target_user_id === $actor->id) {
            throw new AccessGovernanceException(
                'Requester, target user, and approver must be different people.',
                'ACCESS_SELF_APPROVAL_DENIED',
            );
        }
    }

    private function assertRequestCompany(AccessRequest $accessRequest, Company $company): void
    {
        if ($accessRequest->company_id !== $company->id) {
            abort(Response::HTTP_NOT_FOUND);
        }
    }

    private function assertActiveTargetScope(
        User $target,
        Company $company,
        ?string $departmentId,
        ?string $locationId,
    ): void {
        $activeCompany = $target->companyMemberships()
            ->where('company_id', $company->id)
            ->where('employment_status', 'active')
            ->where('valid_from', '<=', today())
            ->where(fn (Builder $query) => $query
                ->whereNull('valid_until')
                ->orWhere('valid_until', '>=', today()))
            ->exists();

        $activeDepartment = ! $departmentId || $target->departmentMemberships()
            ->where('company_id', $company->id)
            ->where('department_id', $departmentId)
            ->where('valid_from', '<=', today())
            ->where(fn (Builder $query) => $query
                ->whereNull('valid_until')
                ->orWhere('valid_until', '>=', today()))
            ->exists();

        $activeLocation = ! $locationId || $target->locationMemberships()
            ->where('company_id', $company->id)
            ->where('location_id', $locationId)
            ->where('valid_from', '<=', today())
            ->where(fn (Builder $query) => $query
                ->whereNull('valid_until')
                ->orWhere('valid_until', '>=', today()))
            ->exists();

        if (! $activeCompany || ! $activeDepartment || ! $activeLocation) {
            throw new AccessGovernanceException(
                'The target user does not have active membership for the requested scope.',
                'ACCESS_TARGET_SCOPE_INACTIVE',
            );
        }
    }

    private function assertRoleScope(Role $role, ?string $departmentId, ?string $locationId): void
    {
        $scopeIsValid = match ($role->assignment_scope) {
            'company' => ! $departmentId && ! $locationId,
            'department' => (bool) $departmentId && ! $locationId,
            'location' => (bool) $locationId,
            default => false,
        };

        if (! $scopeIsValid) {
            throw new AccessGovernanceException(
                'The requested organization scope is not valid for this role.',
                'ACCESS_ROLE_SCOPE_INVALID',
            );
        }
    }

    private function scopeQuery(Builder $query, ?string $departmentId, ?string $locationId): Builder
    {
        return $query
            ->where('department_id', $departmentId)
            ->where('location_id', $locationId);
    }

    private function companyAccessOwners(Company $company)
    {
        return User::query()
            ->where('status', 'active')
            ->whereHas('companyMemberships', fn (Builder $query) => $query
                ->where('company_id', $company->id)
                ->where('employment_status', 'active'))
            ->whereHas('roleAssignments', fn (Builder $query) => $query
                ->active()
                ->where('company_id', $company->id)
                ->whereHas('role', fn (Builder $query) => $query
                    ->where('code', 'management-access-owner')))
            ->get();
    }

    private function notifyDecision(
        AccessRequest $accessRequest,
        Company $company,
        string $event,
        ?string $note,
    ): void {
        $accessRequest->loadMissing(['requester', 'targetUser', 'role']);
        Notification::send(
            collect([$accessRequest->requester, $accessRequest->targetUser])->unique('id'),
            new PrivilegedAccessNotification(
                $event,
                $accessRequest->role->name,
                $company->legal_name,
                $accessRequest->targetUser->name,
                $note,
            ),
        );
    }
}
