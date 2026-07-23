<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Symfony\Component\HttpFoundation\Response;

class RequestCorrelation
{
    public function handle(Request $request, Closure $next): Response
    {
        $requestId = self::requestId($request);
        Log::withContext(['request_id' => $requestId]);

        try {
            return self::decorate($next($request), $request);
        } finally {
            Log::withoutContext(['request_id']);
        }
    }

    public static function requestId(Request $request): string
    {
        $existing = $request->attributes->get('request_id');
        if (is_string($existing) && $existing !== '') {
            return $existing;
        }

        $candidate = $request->header('X-Request-ID');
        $requestId = is_string($candidate)
            && preg_match('/^[A-Za-z0-9][A-Za-z0-9._:-]{7,127}$/', $candidate) === 1
                ? $candidate
                : (string) Str::ulid();

        $request->attributes->set('request_id', $requestId);
        $request->headers->set('X-Request-ID', $requestId);

        return $requestId;
    }

    public static function decorate(Response $response, Request $request): Response
    {
        $requestId = self::requestId($request);
        $response->headers->set('X-Request-ID', $requestId);

        if (! $response instanceof JsonResponse || $response->getStatusCode() < 400) {
            return $response;
        }

        $data = $response->getData(true);
        if (! is_array($data)) {
            $data = [];
        }

        $controlledOperationalResponse = request()->routeIs('health.ready', 'metrics');
        if ($response->getStatusCode() >= 500 && ! $controlledOperationalResponse) {
            $data = [
                'message' => 'An unexpected server error occurred.',
                'code' => 'INTERNAL_ERROR',
            ];
        } else {
            $data['message'] ??= Response::$statusTexts[$response->getStatusCode()] ?? 'Request failed.';
            $data['code'] ??= self::defaultErrorCode($response->getStatusCode());
        }

        $data['request_id'] = $requestId;
        $response->setData($data);

        return $response;
    }

    private static function defaultErrorCode(int $status): string
    {
        return match ($status) {
            Response::HTTP_UNAUTHORIZED => 'UNAUTHENTICATED',
            Response::HTTP_FORBIDDEN => 'FORBIDDEN',
            Response::HTTP_NOT_FOUND => 'RESOURCE_NOT_FOUND',
            Response::HTTP_METHOD_NOT_ALLOWED => 'METHOD_NOT_ALLOWED',
            Response::HTTP_CONFLICT => 'CONFLICT',
            Response::HTTP_UNPROCESSABLE_ENTITY => 'VALIDATION_FAILED',
            Response::HTTP_TOO_MANY_REQUESTS => 'RATE_LIMITED',
            default => 'HTTP_ERROR',
        };
    }
}
