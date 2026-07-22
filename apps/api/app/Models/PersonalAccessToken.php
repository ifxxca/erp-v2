<?php

namespace App\Models;

use Laravel\Sanctum\PersonalAccessToken as SanctumPersonalAccessToken;

class PersonalAccessToken extends SanctumPersonalAccessToken
{
    protected function casts(): array
    {
        return [
            ...parent::casts(),
            'mfa_verified_at' => 'immutable_datetime',
        ];
    }
}
