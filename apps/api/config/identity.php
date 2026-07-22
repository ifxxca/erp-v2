<?php

return [
    'invitation_lifetime_hours' => (int) env('IDENTITY_INVITATION_LIFETIME_HOURS', 72),

    'token_lifetime_minutes' => [
        'erp_web' => (int) env('IDENTITY_ERP_TOKEN_LIFETIME_MINUTES', 720),
        'ops_web' => (int) env('IDENTITY_OPS_TOKEN_LIFETIME_MINUTES', 1440),
        'mobile' => (int) env('IDENTITY_MOBILE_TOKEN_LIFETIME_MINUTES', 15),
    ],
];
