<?php

namespace App\Modules\Identity\Application;

use RuntimeException;

class AccessGovernanceException extends RuntimeException
{
    public function __construct(
        string $message,
        public readonly string $errorCode,
        public readonly int $httpStatus = 422,
    ) {
        parent::__construct($message);
    }
}
