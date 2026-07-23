<?php

namespace App\Modules\Observability\Application;

use RuntimeException;

class DeadLetterRedriveException extends RuntimeException
{
    public function __construct(string $message, public readonly string $errorCode)
    {
        parent::__construct($message);
    }
}
