<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class IdempotencyKey extends Model
{
    use HasUlids;

    protected $fillable = [
        'user_id',
        'key_hash',
        'request_method',
        'request_path',
        'request_fingerprint',
        'status',
        'response_status',
        'response_headers',
        'response_body',
        'completed_at',
        'expires_at',
    ];

    protected function casts(): array
    {
        return [
            'response_headers' => 'array',
            'completed_at' => 'immutable_datetime',
            'expires_at' => 'immutable_datetime',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
