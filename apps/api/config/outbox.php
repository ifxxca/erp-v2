<?php

use App\Modules\Notifications\Application\NotificationRequestedHandler;

return [
    'max_payload_bytes' => (int) env('OUTBOX_MAX_PAYLOAD_BYTES', 65536),
    'batch_size' => (int) env('OUTBOX_BATCH_SIZE', 100),
    'processing_timeout_minutes' => (int) env('OUTBOX_PROCESSING_TIMEOUT_MINUTES', 5),
    'max_attempts' => (int) env('OUTBOX_MAX_ATTEMPTS', 5),
    'delivery_max_attempts' => (int) env('NOTIFICATION_DELIVERY_MAX_ATTEMPTS', 5),
    'backoff_seconds' => [10, 30, 120, 300, 900],
    'handlers' => [
        'notification.requested' => NotificationRequestedHandler::class,
    ],
];
