<?php

return [
    'idempotency' => [
        'processing_timeout_minutes' => (int) env('IDEMPOTENCY_PROCESSING_TIMEOUT_MINUTES', 5),
        'retention_hours' => (int) env('IDEMPOTENCY_RETENTION_HOURS', 24),
        'max_response_bytes' => (int) env('IDEMPOTENCY_MAX_RESPONSE_BYTES', 1048576),
    ],
];
