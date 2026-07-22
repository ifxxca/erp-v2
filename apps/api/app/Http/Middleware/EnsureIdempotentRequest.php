<?php

namespace App\Http\Middleware;

use App\Models\IdempotencyKey;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Symfony\Component\HttpFoundation\Response;
use Throwable;

class EnsureIdempotentRequest
{
    public function handle(Request $request, Closure $next): Response
    {
        $key = $request->header('Idempotency-Key');
        if (! is_string($key) || $key === '' || in_array($request->getMethod(), ['GET', 'HEAD', 'OPTIONS'], true)) {
            return $next($request);
        }

        if (preg_match('/^[A-Za-z0-9][A-Za-z0-9._:-]{15,127}$/', $key) !== 1) {
            return $this->error(
                'Idempotency-Key must contain 16-128 URL-safe characters.',
                'IDEMPOTENCY_KEY_INVALID',
                Response::HTTP_UNPROCESSABLE_ENTITY,
            );
        }

        $user = $request->user();
        if (! $user) {
            return $this->error('Authentication is required.', 'UNAUTHENTICATED', Response::HTTP_UNAUTHORIZED);
        }

        $keyHash = hash('sha256', $key);
        $fingerprint = $this->fingerprint($request);
        $result = $this->acquire($request, $user->getAuthIdentifier(), $keyHash, $fingerprint);

        if ($result instanceof Response) {
            return $result;
        }

        try {
            $response = $next($request);
        } catch (Throwable $exception) {
            $result->delete();
            throw $exception;
        }

        $body = $response->getContent();
        if ($response->getStatusCode() >= 400
            || ! is_string($body)
            || strlen($body) > (int) config('platform.idempotency.max_response_bytes')) {
            $result->delete();

            return $response;
        }

        $headers = collect(['Content-Type', 'Location'])
            ->filter(fn (string $header) => $response->headers->has($header))
            ->mapWithKeys(fn (string $header) => [$header => $response->headers->get($header)])
            ->all();

        $result->forceFill([
            'status' => 'completed',
            'response_status' => $response->getStatusCode(),
            'response_headers' => $headers,
            'response_body' => $body,
            'completed_at' => now(),
            'expires_at' => now()->addHours((int) config('platform.idempotency.retention_hours')),
        ])->save();
        $response->headers->set('Idempotency-Replayed', 'false');

        return $response;
    }

    private function acquire(Request $request, string|int $userId, string $keyHash, string $fingerprint): IdempotencyKey|Response
    {
        return DB::transaction(function () use ($request, $userId, $keyHash, $fingerprint): IdempotencyKey|Response {
            $now = now();
            $values = [
                'id' => (string) Str::ulid(),
                'user_id' => $userId,
                'key_hash' => $keyHash,
                'request_method' => $request->getMethod(),
                'request_path' => $request->getPathInfo(),
                'request_fingerprint' => $fingerprint,
                'status' => 'processing',
                'expires_at' => $now->copy()->addMinutes((int) config('platform.idempotency.processing_timeout_minutes')),
                'created_at' => $now,
                'updated_at' => $now,
            ];
            $inserted = DB::table('idempotency_keys')->insertOrIgnore($values) === 1;
            $record = IdempotencyKey::query()
                ->where('user_id', $userId)
                ->where('key_hash', $keyHash)
                ->lockForUpdate()
                ->firstOrFail();

            if ($inserted) {
                return $record;
            }

            if ($record->expires_at->isPast()) {
                $record->delete();

                return IdempotencyKey::query()->create(collect($values)->except(['id', 'created_at', 'updated_at'])->all());
            }

            if ($record->request_method !== $request->getMethod()
                || $record->request_path !== $request->getPathInfo()
                || $record->request_fingerprint !== $fingerprint) {
                return $this->error(
                    'Idempotency-Key was already used for a different request.',
                    'IDEMPOTENCY_KEY_REUSED',
                    Response::HTTP_CONFLICT,
                );
            }

            if ($record->status === 'completed') {
                $response = response(
                    $record->response_body ?? '',
                    $record->response_status ?? Response::HTTP_OK,
                    $record->response_headers ?? [],
                );
                $response->headers->set('Idempotency-Replayed', 'true');

                return $response;
            }

            return $this->error(
                'An equivalent request is still processing.',
                'IDEMPOTENCY_REQUEST_IN_PROGRESS',
                Response::HTTP_CONFLICT,
                ['Retry-After' => '1'],
            );
        });
    }

    private function fingerprint(Request $request): string
    {
        $body = $request->isJson()
            ? $this->normalize($request->json()->all())
            : $request->getContent();
        $payload = [
            'method' => $request->getMethod(),
            'path' => $request->getPathInfo(),
            'query' => $this->normalize($request->query()),
            'body' => $body,
        ];

        return hash('sha256', json_encode($payload, JSON_THROW_ON_ERROR | JSON_UNESCAPED_SLASHES));
    }

    private function normalize(mixed $value): mixed
    {
        if (! is_array($value)) {
            return $value;
        }
        if (array_is_list($value)) {
            return array_map(fn (mixed $item) => $this->normalize($item), $value);
        }

        ksort($value);

        return array_map(fn (mixed $item) => $this->normalize($item), $value);
    }

    /** @param array<string, string> $headers */
    private function error(string $message, string $code, int $status, array $headers = []): Response
    {
        return response()->json(['message' => $message, 'code' => $code], $status, $headers);
    }
}
