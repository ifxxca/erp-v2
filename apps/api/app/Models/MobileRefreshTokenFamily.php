<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class MobileRefreshTokenFamily extends Model
{
    use HasUlids;

    protected $fillable = [
        'user_id',
        'device_name',
        'mfa_verified_at',
        'absolute_expires_at',
        'last_rotated_at',
        'revoked_at',
        'revocation_reason',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function refreshTokens(): HasMany
    {
        return $this->hasMany(MobileRefreshToken::class, 'family_id');
    }

    public function accessTokens(): HasMany
    {
        return $this->hasMany(PersonalAccessToken::class, 'refresh_token_family_id');
    }

    protected function casts(): array
    {
        return [
            'mfa_verified_at' => 'immutable_datetime',
            'absolute_expires_at' => 'immutable_datetime',
            'last_rotated_at' => 'immutable_datetime',
            'revoked_at' => 'immutable_datetime',
        ];
    }
}
