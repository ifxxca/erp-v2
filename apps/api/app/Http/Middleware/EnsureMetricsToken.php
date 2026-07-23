<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureMetricsToken
{
    public function handle(Request $request, Closure $next): Response
    {
        $configured = config('observability.metrics_token');
        if (! is_string($configured) || strlen($configured) < 32) {
            return new JsonResponse([
                'message' => 'Metrics endpoint is not configured.',
                'code' => 'METRICS_NOT_CONFIGURED',
            ], Response::HTTP_SERVICE_UNAVAILABLE);
        }
        $provided = $request->bearerToken();
        if (! is_string($provided) || ! hash_equals($configured, $provided)) {
            return new JsonResponse([
                'message' => 'Valid metrics credentials are required.',
                'code' => 'METRICS_UNAUTHENTICATED',
            ], Response::HTTP_UNAUTHORIZED, ['WWW-Authenticate' => 'Bearer']);
        }

        return $next($request);
    }
}
