<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class OutboxMessage extends Model
{
    use HasUlids;

    protected $fillable = [
        'company_id',
        'event_type',
        'aggregate_type',
        'aggregate_id',
        'deduplication_key_hash',
        'payload_fingerprint',
        'payload',
        'headers',
        'request_id',
        'status',
        'attempts',
        'available_at',
        'claimed_at',
        'processed_at',
        'dead_lettered_at',
        'last_error_code',
        'last_error_message',
        'occurred_at',
    ];

    protected function casts(): array
    {
        return [
            'payload' => 'array',
            'headers' => 'array',
            'attempts' => 'integer',
            'available_at' => 'immutable_datetime',
            'claimed_at' => 'immutable_datetime',
            'processed_at' => 'immutable_datetime',
            'dead_lettered_at' => 'immutable_datetime',
            'occurred_at' => 'immutable_datetime',
        ];
    }

    public function company(): BelongsTo
    {
        return $this->belongsTo(Company::class);
    }

    public function attemptsHistory(): HasMany
    {
        return $this->hasMany(OutboxAttempt::class);
    }

    public function notifications(): HasMany
    {
        return $this->hasMany(PlatformNotification::class, 'source_outbox_id');
    }
}
