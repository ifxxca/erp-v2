<?php

namespace App\Modules\Files\Application;

use RuntimeException;

class FileWorkflowException extends RuntimeException
{
    public function __construct(
        string $message,
        public readonly string $errorCode,
        public readonly int $httpStatus,
    ) {
        parent::__construct($message);
    }
}
