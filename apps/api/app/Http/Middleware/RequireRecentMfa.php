<?php

namespace App\Http\Middleware;

use App\Models\PersonalAccessToken;
use Closure;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RequireRecentMfa
{
    public function handle(Request $request, Closure $next): Response
    {
        $token = $request->user()?->currentAccessToken();
        $verifiedAt = $token instanceof PersonalAccessToken ? $token->mfa_verified_at : null;
        $lifetime = (int) config('identity.step_up_lifetime_minutes');

        if (! $verifiedAt || $verifiedAt->lt(now()->subMinutes($lifetime))) {
            return new JsonResponse([
                'message' => 'Recent multi-factor authentication is required.',
                'code' => 'MFA_STEP_UP_REQUIRED',
            ], Response::HTTP_FORBIDDEN);
        }

        return $next($request);
    }
}
