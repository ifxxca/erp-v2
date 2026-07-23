<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class NotificationDeliveryAttempt extends Model
{
    use HasUlids;

    protected $fillable = [
        'notification_delivery_id',
        'attempt_no',
        'status',
        'started_at',
        'finished_at',
        'error_code',
        'error_message',
    ];

    protected function casts(): array
    {
        return [
            'attempt_no' => 'integer',
            'started_at' => 'immutable_datetime',
            'finished_at' => 'immutable_datetime',
        ];
    }

    public function delivery(): BelongsTo
    {
        return $this->belongsTo(NotificationDelivery::class, 'notification_delivery_id');
    }
}
