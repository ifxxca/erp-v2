<?php

namespace App\Providers;

use App\Models\PersonalAccessToken;
use App\Modules\Files\Application\FileScanner;
use App\Modules\Files\Infrastructure\ClamAvFileScanner;
use App\Modules\Files\Infrastructure\SkippedFileScanner;
use App\Modules\Notifications\Application\NotificationChannelSender;
use App\Modules\Notifications\Infrastructure\LaravelNotificationChannelSender;
use Illuminate\Support\ServiceProvider;
use Laravel\Sanctum\Sanctum;
use LogicException;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(FileScanner::class, fn () => match (config('files.scan_driver')) {
            'clamav' => new ClamAvFileScanner,
            'skipped' => new SkippedFileScanner,
            default => throw new LogicException('FILES_SCAN_DRIVER must be clamav or skipped.'),
        });
        $this->app->bind(NotificationChannelSender::class, LaravelNotificationChannelSender::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        if ($this->app->environment('production')
            && (config('files.scan_driver') !== 'clamav' || config('files.allow_unscanned'))) {
            throw new LogicException('Production requires ClamAV and forbids unscanned files.');
        }

        Sanctum::usePersonalAccessTokenModel(PersonalAccessToken::class);
        Sanctum::authenticateAccessTokensUsing(function (PersonalAccessToken $token, bool $isValid): bool {
            if (! $isValid) {
                return false;
            }

            $lastActivity = $token->last_used_at ?? $token->created_at;
            $idleMinutes = (int) config(
                'identity.token_idle_timeout_minutes.'.$token->surface(),
                config('identity.token_idle_timeout_minutes.unknown'),
            );

            return $lastActivity->gt(now()->subMinutes($idleMinutes));
        });
    }
}
