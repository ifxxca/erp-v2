<?php

return [
    'metrics_token' => env('OBSERVABILITY_METRICS_TOKEN'),
    'slow_request_milliseconds' => (int) env('OBSERVABILITY_SLOW_REQUEST_MILLISECONDS', 1000),
    'check_storage' => filter_var(env('OBSERVABILITY_CHECK_STORAGE', true), FILTER_VALIDATE_BOOL),
    'thresholds' => [
        'outbox_pending_count' => (int) env('OBSERVABILITY_OUTBOX_PENDING_COUNT', 100),
        'outbox_oldest_seconds' => (int) env('OBSERVABILITY_OUTBOX_OLDEST_SECONDS', 300),
        'outbox_dead_letter_count' => (int) env('OBSERVABILITY_OUTBOX_DEAD_LETTER_COUNT', 1),
        'delivery_pending_count' => (int) env('OBSERVABILITY_DELIVERY_PENDING_COUNT', 100),
        'delivery_oldest_seconds' => (int) env('OBSERVABILITY_DELIVERY_OLDEST_SECONDS', 300),
        'delivery_dead_letter_count' => (int) env('OBSERVABILITY_DELIVERY_DEAD_LETTER_COUNT', 1),
        'failed_jobs_count' => (int) env('OBSERVABILITY_FAILED_JOBS_COUNT', 1),
    ],
];
