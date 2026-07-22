<?php

namespace App\Modules\Identity\Application;

use App\Models\User;
use Illuminate\Database\Eloquent\Builder;

class EffectivePermissionResolver
{
    public function allowsGlobal(User $user, string $permissionCode): bool
    {
        if ($user->status !== 'active') {
            return false;
        }

        return $user->roleAssignments()
            ->active()
            ->whereNull('company_id')
            ->whereNull('department_id')
            ->whereNull('location_id')
            ->whereHas('role.permissions', fn (Builder $query) => $query->where('code', $permissionCode))
            ->exists();
    }

    public function allows(
        User $user,
        string $permissionCode,
        string $companyId,
        ?string $departmentId = null,
        ?string $locationId = null,
    ): bool {
        if ($user->status !== 'active') {
            return false;
        }

        if ($this->allowsGlobal($user, $permissionCode)) {
            return true;
        }

        $hasActiveCompanyMembership = $user->companyMemberships()
            ->where('company_id', $companyId)
            ->where('employment_status', 'active')
            ->where('valid_from', '<=', today())
            ->where(fn (Builder $query) => $query
                ->whereNull('valid_until')
                ->orWhere('valid_until', '>=', today()))
            ->exists();

        if (! $hasActiveCompanyMembership) {
            return false;
        }

        if ($departmentId && ! $user->departmentMemberships()
            ->where('company_id', $companyId)
            ->where('department_id', $departmentId)
            ->where('valid_from', '<=', today())
            ->where(fn (Builder $query) => $query
                ->whereNull('valid_until')
                ->orWhere('valid_until', '>=', today()))
            ->exists()) {
            return false;
        }

        if ($locationId && ! $user->locationMemberships()
            ->where('company_id', $companyId)
            ->where('location_id', $locationId)
            ->where('valid_from', '<=', today())
            ->where(fn (Builder $query) => $query
                ->whereNull('valid_until')
                ->orWhere('valid_until', '>=', today()))
            ->exists()) {
            return false;
        }

        return $user->roleAssignments()
            ->active()
            ->where(fn (Builder $query) => $query
                ->whereNull('company_id')
                ->orWhere('company_id', $companyId))
            ->where(fn (Builder $query) => $query
                ->whereNull('department_id')
                ->when($departmentId, fn (Builder $query) => $query->orWhere('department_id', $departmentId)))
            ->where(fn (Builder $query) => $query
                ->whereNull('location_id')
                ->when($locationId, fn (Builder $query) => $query->orWhere('location_id', $locationId)))
            ->whereHas('role.permissions', fn (Builder $query) => $query->where('code', $permissionCode))
            ->exists();
    }
}
