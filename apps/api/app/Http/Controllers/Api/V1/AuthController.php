<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Models\User;
use App\Modules\Identity\Application\AuditLogger;
use App\Modules\Identity\Application\MfaRequirementResolver;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Symfony\Component\HttpFoundation\Response;

class AuthController extends Controller
{
    public function __construct(
        private readonly AuditLogger $audit,
        private readonly MfaRequirementResolver $mfaRequirement,
    ) {}

    public function login(LoginRequest $request): JsonResponse
    {
        $credentials = $request->safe()->only(['email', 'password']);
        $user = User::query()->where('email', mb_strtolower($credentials['email']))->first();

        $hasActiveMembership = $user?->companyMemberships()
            ->where('employment_status', 'active')
            ->where('valid_from', '<=', today())
            ->where(fn (Builder $query) => $query
                ->whereNull('valid_until')
                ->orWhere('valid_until', '>=', today()))
            ->exists() ?? false;

        if (! $user || ! Hash::check($credentials['password'], $user->password)
            || $user->status !== 'active' || ! $hasActiveMembership) {
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
        $lifetime = (int) config("identity.token_lifetime_minutes.{$surface}");
        $expiresAt = now()->addMinutes($lifetime);
        $token = $user->createToken(
            $request->string('device_name')->toString(),
            ["surface:{$surface}"],
            $expiresAt,
        );

        $user->forceFill(['last_login_at' => now()])->save();
        $this->audit->record(
            'identity.login_succeeded',
            $user,
            $user,
            ['surface' => $surface, 'token_id' => $token->accessToken->id],
            $request,
        );

        return response()->json([
            'token_type' => 'Bearer',
            'access_token' => $token->plainTextToken,
            'expires_at' => $expiresAt->toIso8601String(),
            'mfa_required' => $this->mfaRequirement->required($user),
        ]);
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

        if ($token && method_exists($token, 'delete')) {
            $token->delete();
        }

        return response()->json(null, Response::HTTP_NO_CONTENT);
    }
}
