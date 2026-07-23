<?php

namespace App\Modules\Outbox\Application;

use RuntimeException;

class OutboxWriterException extends RuntimeException
{
    public function __construct(string $message, public readonly string $errorCode)
    {
        parent::__construct($message);
    }
}
