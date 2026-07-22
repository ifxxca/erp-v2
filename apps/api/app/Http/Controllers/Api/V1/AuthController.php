<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Models\User;
use App\Modules\Identity\Application\AuditLogger;
use App\Modules\Identity\Application\IdentityEligibility;
use App\Modules\Identity\Application\MfaRequirementResolver;
use App\Modules\Identity\Application\MobileTokenService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Symfony\Component\HttpFoundation\Response;

class AuthController extends Controller
{
    public function __construct(
        private readonly AuditLogger $audit,
        private readonly MfaRequirementResolver $mfaRequirement,
        private readonly IdentityEligibility $eligibility,
        private readonly MobileTokenService $mobileTokens,
    ) {}

    public function login(LoginRequest $request): JsonResponse
    {
        $credentials = $request->safe()->only(['email', 'password']);
        $user = User::query()->where('email', mb_strtolower($credentials['email']))->first();

        if (! $user || ! Hash::check($credentials['password'], $user->password)
            || ! $this->eligibility->isActiveEmployee($user)) {
            $this->audit->record(
                'identity.login_failed',
                metadata: ['email_fingerprint' => hash('sha256', mb_strtolower($credentials['email']))],
                request: $request,
            );

            return response()->json([
                'message' => 'Email or password is invalid.',
                'code' => 'INVALID_CREDENTIALS',
            ], Response::HTTP_UNAUTHORIZED);
        }

        $surface = $request->string('surface')->toString();
        $deviceName = $request->string('device_name')->toString();
        if ($surface === 'mobile') {
            $mobilePair = $this->mobileTokens->issue($user, $deviceName);
            $tokenId = $mobilePair['token_id'];
            $familyId = $mobilePair['family_id'];
            $response = [
                'token_type' => 'Bearer',
                'access_token' => $mobilePair['access_token'],
                'expires_at' => $mobilePair['expires_at'],
                'refresh_token' => $mobilePair['refresh_token'],
                'refresh_expires_at' => $mobilePair['refresh_expires_at'],
                'mfa_required' => $mobilePair['mfa_required'],
            ];
        } else {
            $expiresAt = now()->addMinutes((int) config("identity.token_lifetime_minutes.{$surface}"));
            $token = $user->createToken($deviceName, ["surface:{$surface}"], $expiresAt);
            $tokenId = $token->accessToken->id;
            $familyId = null;
            $response = [
                'token_type' => 'Bearer',
                'access_token' => $token->plainTextToken,
                'expires_at' => $expiresAt->toIso8601String(),
                'mfa_required' => $this->mfaRequirement->required($user),
            ];
        }

        $user->forceFill(['last_login_at' => now()])->save();
        $this->audit->record(
            'identity.login_succeeded',
            $user,
            $user,
            ['surface' => $surface, 'token_id' => $tokenId, 'refresh_token_family_id' => $familyId],
            $request,
        );

        return response()->json($response);
    }

    public function logout(Request $request): JsonResponse
    {
        $user = $request->user();
        $token = $user->currentAccessToken();

        $this->audit->record(
            'identity.logout',
            $user,
            $user,
            ['token_id' => $token?->id],
            $request,
        );

        if ($token?->refreshTokenFamily) {
            $this->mobileTokens->revokeFamily($token->refreshTokenFamily, 'logout');
        } elseif ($token && method_exists($token, 'delete')) {
            $token->delete();
        }

        return response()->json(null, Response::HTTP_NO_CONTENT);
    }
}
