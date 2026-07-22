<?php

namespace App\Models;

use Laravel\Sanctum\PersonalAccessToken as SanctumPersonalAccessToken;

class PersonalAccessToken extends SanctumPersonalAccessToken
{
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
