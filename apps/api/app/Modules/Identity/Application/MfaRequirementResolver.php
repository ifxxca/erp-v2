<?php

namespace App\Modules\Identity\Application;

use App\Models\User;
use Illuminate\Database\Eloquent\Builder;

class MfaRequirementResolver
{
    public function required(User $user): bool
    {
        return $user->mfaMethods()->where('status', 'active')->exists()
            || $this->requiredByPrivilegedAssignment($user);
    }

    public function requiredByPrivilegedAssignment(User $user): bool
    {
        return $user->roleAssignments()
            ->active()
            ->whereHas('role', fn (Builder $query) => $query->where('is_privileged', true))
            ->exists();
    }
}
