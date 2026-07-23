<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class NotificationDelivery extends Model
{
    use HasUlids;

    protected $fillable = [
        'notification_id',
        'channel',
        'status',
        'attempts',
        'available_at',
        'claimed_at',
        'delivered_at',
        'dead_lettered_at',
        'provider_message_id',
        'last_error_code',
        'last_error_message',
    ];

    protected function casts(): array
    {
        return [
            'attempts' => 'integer',
            'available_at' => 'immutable_datetime',
            'claimed_at' => 'immutable_datetime',
            'delivered_at' => 'immutable_datetime',
            'dead_lettered_at' => 'immutable_datetime',
        ];
    }

    public function notification(): BelongsTo
    {
        return $this->belongsTo(PlatformNotification::class, 'notification_id');
    }

    public function attemptsHistory(): HasMany
    {
        return $this->hasMany(NotificationDeliveryAttempt::class);
    }
}
