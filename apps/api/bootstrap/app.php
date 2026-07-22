<?php

use App\Http\Middleware\EnsureActiveIdentity;
use App\Http\Middleware\EnsureMfaAuthenticated;
use App\Http\Middleware\RequireRecentMfa;
use App\Http\Middleware\RequireScopedPermission;
use App\Modules\Identity\Application\AccessGovernanceException;
use App\Modules\Identity\Application\MfaException;
use App\Modules\Identity\Application\RefreshTokenException;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->alias([
            'identity.active' => EnsureActiveIdentity::class,
            'mfa.authenticated' => EnsureMfaAuthenticated::class,
            'mfa.recent' => RequireRecentMfa::class,
            'permission.scoped' => RequireScopedPermission::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->render(fn (AccessGovernanceException $exception) => response()->json([
            'message' => $exception->getMessage(),
            'code' => $exception->errorCode,
        ], $exception->httpStatus));
        $exceptions->render(fn (MfaException $exception) => response()->json([
            'message' => $exception->getMessage(),
            'code' => $exception->errorCode,
        ], $exception->httpStatus));
        $exceptions->render(fn (RefreshTokenException $exception) => response()->json([
            'message' => $exception->getMessage(),
            'code' => $exception->errorCode,
        ], $exception->httpStatus));
    })->create();
