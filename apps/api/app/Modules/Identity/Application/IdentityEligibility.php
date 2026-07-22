<?php

namespace App\Modules\Identity\Application;

use App\Models\User;
use Illuminate\Database\Eloquent\Builder;

class IdentityEligibility
{
    public function isActiveEmployee(?User $user): bool
    {
        return $user?->status === 'active'
            && $this->hasActiveEmployment($user);
    }

    public function hasActiveEmployment(User $user): bool
    {
        return $user->companyMemberships()
            ->where('employment_status', 'active')
            ->where('valid_from', '<=', today())
            ->where(fn (Builder $query) => $query
                ->whereNull('valid_until')
                ->orWhere('valid_until', '>=', today()))
            ->exists();
    }
}
