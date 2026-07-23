<?php

namespace App\Modules\Observability\Application;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Throwable;

class ReadinessChecker
{
    /** @return array{ready:bool,checks:array<string,array{status:string,latency_ms:float}>} */
    public function snapshot(): array
    {
        $checks = [
            'database' => $this->probe('database', fn () => DB::select('select 1')),
            'cache' => $this->probe('cache', function (): void {
                $key = 'health:'.Str::ulid();
                Cache::put($key, 'ready', 10);
                if (Cache::get($key) !== 'ready') {
                    throw new \RuntimeException('Cache round trip failed.');
                }
                Cache::forget($key);
            }),
            'queue' => $this->probe('queue', fn () => $this->checkQueue()),
        ];
        if (config('observability.check_storage')) {
            $checks['object_storage'] = $this->probe(
                'object_storage',
                fn () => Storage::disk(config('files.disk'))->exists('__readiness_probe__'),
            );
        }

        return [
            'ready' => collect($checks)->every(fn (array $check) => $check['status'] === 'up'),
            'checks' => $checks,
        ];
    }

    /** @return array{status:string,latency_ms:float} */
    private function probe(string $name, callable $probe): array
    {
        $started = hrtime(true);
        try {
            $probe();

            return ['status' => 'up', 'latency_ms' => $this->elapsed($started)];
        } catch (Throwable $exception) {
            Log::error('Readiness dependency check failed.', [
                'check' => $name,
                'exception_class' => $exception::class,
            ]);

            return ['status' => 'down', 'latency_ms' => $this->elapsed($started)];
        }
    }

    private function checkQueue(): void
    {
        $connection = config('queue.default');
        $driver = config("queue.connections.{$connection}.driver");
        if ($driver === 'sync') {
            return;
        }
        if ($driver === 'database') {
            DB::table(config("queue.connections.{$connection}.table", 'jobs'))->limit(1)->count();

            return;
        }
        if ($driver === 'redis') {
            $redisConnection = config("queue.connections.{$connection}.connection", 'default');
            Redis::connection($redisConnection)->command('ping');

            return;
        }

        throw new \RuntimeException('The queue driver has no readiness probe.');
    }

    private function elapsed(int $started): float
    {
        return round((hrtime(true) - $started) / 1_000_000, 3);
    }
}
