<?php

namespace App\Modules\Documents\Application;

use RuntimeException;

class DocumentNumberingException extends RuntimeException
{
    public function __construct(string $message, public readonly string $errorCode)
    {
        parent::__construct($message);
    }
}
