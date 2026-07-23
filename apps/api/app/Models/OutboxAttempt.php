<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class OutboxAttempt extends Model
{
    use HasUlids;

    protected $fillable = [
        'outbox_message_id',
        'attempt_no',
        'status',
        'worker_id',
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

    public function message(): BelongsTo
    {
        return $this->belongsTo(OutboxMessage::class, 'outbox_message_id');
    }
}
