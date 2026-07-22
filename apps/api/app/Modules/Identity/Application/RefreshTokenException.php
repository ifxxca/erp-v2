<?php

namespace App\Modules\Identity\Application;

use RuntimeException;
use Symfony\Component\HttpFoundation\Response;

class RefreshTokenException extends RuntimeException
{
    public function __construct(
        string $message = 'The refresh token is invalid or expired.',
        public readonly string $errorCode = 'REFRESH_TOKEN_INVALID',
        public readonly int $httpStatus = Response::HTTP_UNAUTHORIZED,
    ) {
        parent::__construct($message);
    }
}
