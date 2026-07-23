<?php

use App\Http\Middleware\EnsureActiveIdentity;
use App\Http\Middleware\EnsureIdempotentRequest;
use App\Http\Middleware\EnsureMetricsToken;
use App\Http\Middleware\EnsureMfaAuthenticated;
use App\Http\Middleware\RequestCorrelation;
use App\Http\Middleware\RequestTelemetry;
use App\Http\Middleware\RequireGlobalPermission;
use App\Http\Middleware\RequireRecentMfa;
use App\Http\Middleware\RequireScopedPermission;
use App\Modules\Files\Application\FileWorkflowException;
use App\Modules\FleetMaintenance\Application\FleetMaintenanceException;
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
        $middleware->api(prepend: [RequestCorrelation::class, RequestTelemetry::class]);
        $middleware->alias([
            'identity.active' => EnsureActiveIdentity::class,
            'idempotent' => EnsureIdempotentRequest::class,
            'mfa.authenticated' => EnsureMfaAuthenticated::class,
            'mfa.recent' => RequireRecentMfa::class,
            'metrics.auth' => EnsureMetricsToken::class,
            'permission.scoped' => RequireScopedPermission::class,
            'permission.global' => RequireGlobalPermission::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->shouldRenderJsonWhen(fn ($request) => $request->is('api/*') || $request->expectsJson());
        $exceptions->render(fn (AccessGovernanceException $exception) => response()->json([
            'message' => $exception->getMessage(),
            'code' => $exception->errorCode,
        ], $exception->httpStatus));
        $exceptions->render(fn (FileWorkflowException $exception) => response()->json([
            'message' => $exception->getMessage(),
            'code' => $exception->errorCode,
        ], $exception->httpStatus));
        $exceptions->render(fn (FleetMaintenanceException $exception) => response()->json([
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
        $exceptions->respond(function ($response) {
            if (! request()->is('api/*')) {
                return $response;
            }

            return RequestCorrelation::decorate($response, request());
        });
    })->create();
