<?php

return [
    'disk' => env('FILESYSTEM_DISK', 'local'),
    'max_bytes' => (int) env('FILES_MAX_BYTES', 20 * 1024 * 1024),
    'pending_lifetime_hours' => (int) env('FILES_PENDING_LIFETIME_HOURS', 24),
    'scan_driver' => env('FILES_SCAN_DRIVER', 'clamav'),
    'allow_unscanned' => filter_var(env('FILES_ALLOW_UNSCANNED', false), FILTER_VALIDATE_BOOL),
    'clamav' => [
        'host' => env('CLAMAV_HOST', '127.0.0.1'),
        'port' => (int) env('CLAMAV_PORT', 3310),
        'timeout_seconds' => (int) env('CLAMAV_TIMEOUT_SECONDS', 30),
    ],
    'purposes' => [
        'checklist_evidence',
        'vehicle_document',
        'work_order_attachment',
    ],
    'mime_signatures' => [
        'application/pdf' => ['255044462d'],
        'image/jpeg' => ['ffd8ff'],
        'image/png' => ['89504e470d0a1a0a'],
        'image/webp' => ['52494646'],
    ],
];
