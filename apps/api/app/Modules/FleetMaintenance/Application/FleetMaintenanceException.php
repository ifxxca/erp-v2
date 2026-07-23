<?php

namespace App\Modules\FleetMaintenance\Application;

use RuntimeException;

class FleetMaintenanceException extends RuntimeException
{
    public function __construct(
        string $message,
        public readonly string $errorCode,
        public readonly int $httpStatus = 422,
    ) {
        parent::__construct($message);
    }
}
