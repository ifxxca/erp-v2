<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Laravel\Sanctum\PersonalAccessToken as SanctumPersonalAccessToken;

class PersonalAccessToken extends SanctumPersonalAccessToken
{
    public function refreshTokenFamily(): BelongsTo
    {
        return $this->belongsTo(MobileRefreshTokenFamily::class, 'refresh_token_family_id');
    }

    public function surface(): string
    {
        foreach ($this->abilities ?? [] as $ability) {
            if (str_starts_with($ability, 'surface:')) {
                return substr($ability, strlen('surface:'));
            }
        }

        return 'unknown';
    }

    protected function casts(): array
    {
        return [
            ...parent::casts(),
            'mfa_verified_at' => 'immutable_datetime',
        ];
    }
}
