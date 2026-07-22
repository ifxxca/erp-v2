<?php

namespace App\Providers;

use App\Models\PersonalAccessToken;
use Illuminate\Support\ServiceProvider;
use Laravel\Sanctum\Sanctum;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
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
