<?php

return [
    'invitation_lifetime_hours' => (int) env('IDENTITY_INVITATION_LIFETIME_HOURS', 72),
    'step_up_lifetime_minutes' => (int) env('IDENTITY_STEP_UP_LIFETIME_MINUTES', 15),
    'totp_window' => (int) env('IDENTITY_TOTP_WINDOW', 1),
    'recovery_code_count' => (int) env('IDENTITY_RECOVERY_CODE_COUNT', 8),
    'privileged_assignment_max_days' => (int) env('IDENTITY_PRIVILEGED_ASSIGNMENT_MAX_DAYS', 90),

    'token_lifetime_minutes' => [
        'erp_web' => (int) env('IDENTITY_ERP_TOKEN_LIFETIME_MINUTES', 720),
        'ops_web' => (int) env('IDENTITY_OPS_TOKEN_LIFETIME_MINUTES', 1440),
        'mobile' => (int) env('IDENTITY_MOBILE_TOKEN_LIFETIME_MINUTES', 15),
    ],

    'token_idle_timeout_minutes' => [
        'erp_web' => (int) env('IDENTITY_ERP_IDLE_TIMEOUT_MINUTES', 30),
        'ops_web' => (int) env('IDENTITY_OPS_IDLE_TIMEOUT_MINUTES', 120),
        'mobile' => (int) env('IDENTITY_MOBILE_IDLE_TIMEOUT_MINUTES', 15),
        'unknown' => (int) env('IDENTITY_DEFAULT_IDLE_TIMEOUT_MINUTES', 30),
    ],
];
