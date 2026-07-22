<?php

namespace App\Http\Middleware;

use App\Models\PersonalAccessToken;
use App\Modules\Identity\Application\MfaRequirementResolver;
use Closure;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureMfaAuthenticated
{
    public function __construct(private readonly MfaRequirementResolver $requirement) {}

    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();
        $token = $user?->currentAccessToken();

        if ($user && $this->requirement->required($user)
            && (! $token instanceof PersonalAccessToken || ! $token->mfa_verified_at)) {
            return new JsonResponse([
                'message' => 'Multi-factor authentication challenge is required.',
                'code' => 'MFA_CHALLENGE_REQUIRED',
            ], Response::HTTP_FORBIDDEN);
        }

        return $next($request);
    }
}
