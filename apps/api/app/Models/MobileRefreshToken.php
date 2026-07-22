<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MobileRefreshToken extends Model
{
    use HasUlids;

    protected $fillable = [
        'family_id',
        'parent_id',
        'token_hash',
        'consumed_at',
        'expires_at',
    ];

    public function family(): BelongsTo
    {
        return $this->belongsTo(MobileRefreshTokenFamily::class, 'family_id');
    }

    public function parent(): BelongsTo
    {
        return $this->belongsTo(self::class, 'parent_id');
    }

    protected function casts(): array
    {
        return [
            'consumed_at' => 'immutable_datetime',
            'expires_at' => 'immutable_datetime',
        ];
    }
}
