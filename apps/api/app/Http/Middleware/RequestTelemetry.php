<?php

namespace App\Http\Middleware;

use App\Models\Company;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Symfony\Component\HttpFoundation\Response;
use Throwable;

class RequestTelemetry
{
    public function handle(Request $request, Closure $next): Response
    {
        $started = hrtime(true);
        try {
            $response = $next($request);
            $this->write($request, $response->getStatusCode(), $started);

            return $response;
        } catch (Throwable $exception) {
            $this->write($request, 500, $started, $exception);

            throw $exception;
        }
    }

    private function write(Request $request, int $status, int $started, ?Throwable $exception = null): void
    {
        $duration = round((hrtime(true) - $started) / 1_000_000, 3);
        $company = $request->route('company');
        $context = array_filter([
            'request_id' => $request->attributes->get('request_id'),
            'method' => $request->method(),
            'route' => $request->route()?->uri() ?? $request->path(),
            'status' => $status,
            'duration_ms' => $duration,
            'user_id' => $request->user()?->id,
            'company_id' => $company instanceof Company ? $company->id : (is_string($company) ? $company : null),
            'exception_class' => $exception ? $exception::class : null,
        ], fn ($value) => $value !== null && $value !== '');

        if ($status >= 500) {
            Log::error('HTTP request completed.', $context);
        } elseif ($status >= 400) {
            Log::warning('HTTP request completed.', $context);
        } elseif ($request->routeIs('health.*', 'metrics')) {
            Log::debug('HTTP request completed.', $context);
        } elseif ($duration >= (int) config('observability.slow_request_milliseconds')) {
            Log::warning('HTTP request completed.', $context);
        } else {
            Log::info('HTTP request completed.', $context);
        }
    }
}
