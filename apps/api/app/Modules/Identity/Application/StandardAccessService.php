<?php

namespace App\Modules\Identity\Application;

use App\Models\Company;
use App\Models\Role;
use App\Models\User;
use App\Models\UserRoleAssignment;
use Carbon\CarbonImmutable;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\Relation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\Response;

class StandardAccessService
{
    public function __construct(private readonly AuditLogger $audit) {}

    /** @param array<string, mixed> $data */
    public function assign(
        Company $company,
        User $target,
        User $actor,
        array $data,
        Request $request,
    ): UserRoleAssignment {
        return DB::transaction(function () use ($company, $target, $actor, $data, $request): UserRoleAssignment {
            $target = User::query()->lockForUpdate()->findOrFail($target->id);
            $role = Role::query()->lockForUpdate()->findOrFail($data['role_id']);
            $validFrom = CarbonImmutable::parse($data['valid_from'])->startOfDay();
            $validUntil = isset($data['valid_until'])
                ? CarbonImmutable::parse($data['valid_until'])->endOfDay()
                : null;

            if ($actor->is($target)) {
                throw new AccessGovernanceException(
                    'You cannot assign standard access to yourself.',
                    'STANDARD_ACCESS_SELF_ASSIGNMENT_DENIED',
                );
            }
            if ($target->status !== 'active') {
                throw new AccessGovernanceException(
                    'Standard access can only be assigned to an active identity.',
                    'STANDARD_ACCESS_TARGET_INACTIVE',
                );
            }
            if ($role->is_privileged || $role->assignment_scope === 'global') {
                throw new AccessGovernanceException(
                    'Privileged or global roles must not use direct assignment.',
                    'STANDARD_ACCESS_ROLE_DENIED',
                );
            }

            $departmentId = $data['department_id'] ?? null;
            $locationId = $data['location_id'] ?? null;
            $this->assertRoleScope($role, $departmentId, $locationId);
            $this->assertTargetCoverage($target, $company, $departmentId, $locationId, $validFrom, $validUntil);

            $duplicate = UserRoleAssignment::query()
                ->where('user_id', $target->id)
                ->where('role_id', $role->id)
                ->where('company_id', $company->id)
                ->where('department_id', $departmentId)
                ->where('location_id', $locationId)
                ->whereNull('revoked_at')
                ->where(fn (Builder $query) => $query
                    ->whereNull('valid_until')
                    ->orWhere('valid_until', '>=', $validFrom))
                ->when($validUntil, fn (Builder $query) => $query->where('valid_from', '<=', $validUntil))
                ->exists();

            if ($duplicate) {
                throw new AccessGovernanceException(
                    'An equivalent assignment overlaps the requested validity period.',
                    'STANDARD_ACCESS_ASSIGNMENT_OVERLAP',
                    Response::HTTP_CONFLICT,
                );
            }

            $assignment = UserRoleAssignment::query()->create([
                'user_id' => $target->id,
                'role_id' => $role->id,
                'company_id' => $company->id,
                'department_id' => $departmentId,
                'location_id' => $locationId,
                'valid_from' => $validFrom,
                'valid_until' => $validUntil,
                'assigned_by' => $actor->id,
            ]);

            $this->audit->record('identity.standard_access_assigned', $actor, $assignment, [
                'reason' => $data['reason'],
                'target_user_id' => $target->id,
                'role_id' => $role->id,
                'company_id' => $company->id,
                'department_id' => $departmentId,
                'location_id' => $locationId,
                'valid_from' => $validFrom->toIso8601String(),
                'valid_until' => $validUntil?->toIso8601String(),
            ], $request);

            return $assignment->load($this->relations());
        });
    }

    public function revoke(
        Company $company,
        User $target,
        UserRoleAssignment $assignment,
        User $actor,
        string $reason,
        Request $request,
    ): UserRoleAssignment {
        return DB::transaction(function () use ($company, $target, $assignment, $actor, $reason, $request): UserRoleAssignment {
            $assignment = UserRoleAssignment::query()->lockForUpdate()->findOrFail($assignment->id);

            if ($assignment->company_id !== $company->id
                || $assignment->user_id !== $target->id
                || $assignment->access_request_id !== null) {
                abort(Response::HTTP_NOT_FOUND);
            }
            if ($actor->is($target)) {
                throw new AccessGovernanceException(
                    'You cannot revoke your own standard access.',
                    'STANDARD_ACCESS_SELF_REVOCATION_DENIED',
                );
            }
            if ($assignment->revoked_at || $assignment->valid_until?->isPast()) {
                throw new AccessGovernanceException(
                    'The standard assignment is no longer revocable.',
                    'STANDARD_ACCESS_ASSIGNMENT_NOT_CURRENT',
                    Response::HTTP_CONFLICT,
                );
            }

            $assignment->update([
                'revoked_at' => now(),
                'revoked_by' => $actor->id,
                'revocation_reason' => $reason,
            ]);
            $this->audit->record('identity.standard_access_revoked', $actor, $assignment, [
                'reason' => $reason,
                'target_user_id' => $target->id,
                'role_id' => $assignment->role_id,
                'company_id' => $company->id,
            ], $request);

            return $assignment->load($this->relations());
        });
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
                'STANDARD_ACCESS_ROLE_SCOPE_INVALID',
            );
        }
    }

    private function assertTargetCoverage(
        User $target,
        Company $company,
        ?string $departmentId,
        ?string $locationId,
        CarbonImmutable $validFrom,
        ?CarbonImmutable $validUntil,
    ): void {
        $companyCovered = $this->coversPeriod(
            $target->companyMemberships()
                ->where('company_id', $company->id)
                ->where('employment_status', 'active'),
            $validFrom,
            $validUntil,
        );
        $departmentCovered = ! $departmentId || $this->coversPeriod(
            $target->departmentMemberships()
                ->where('company_id', $company->id)
                ->where('department_id', $departmentId),
            $validFrom,
            $validUntil,
        );
        $locationCovered = ! $locationId || $this->coversPeriod(
            $target->locationMemberships()
                ->where('company_id', $company->id)
                ->where('location_id', $locationId),
            $validFrom,
            $validUntil,
        );

        if (! $companyCovered || ! $departmentCovered || ! $locationCovered) {
            throw new AccessGovernanceException(
                'Employment and organization memberships must cover the complete assignment period.',
                'STANDARD_ACCESS_TARGET_SCOPE_NOT_COVERED',
            );
        }
    }

    private function coversPeriod(Builder|Relation $query, CarbonImmutable $validFrom, ?CarbonImmutable $validUntil): bool
    {
        return $query
            ->whereDate('valid_from', '<=', $validFrom->toDateString())
            ->when(
                $validUntil,
                fn (Builder $query) => $query->where(fn (Builder $query) => $query
                    ->whereNull('valid_until')
                    ->orWhereDate('valid_until', '>=', $validUntil->toDateString())),
                fn (Builder $query) => $query->whereNull('valid_until'),
            )
            ->exists();
    }

    /** @return array<int, string> */
    private function relations(): array
    {
        return ['role:id,code,name,assignment_scope,is_privileged', 'department:id,code,name', 'location:id,code,name', 'assignedBy:id,name', 'revokedBy:id,name'];
    }
}
