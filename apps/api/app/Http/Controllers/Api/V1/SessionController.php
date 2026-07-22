<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\RevokeAllSessionsRequest;
use App\Models\PersonalAccessToken;
use App\Modules\Identity\Application\AuditLogger;
use App\Modules\Identity\Application\MfaException;
use App\Modules\Identity\Application\MobileTokenService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class SessionController extends Controller
{
    public function __construct(
        private readonly AuditLogger $audit,
        private readonly MobileTokenService $mobileTokens,
    ) {}

    public function index(Request $request): JsonResponse
    {
        $currentTokenId = $request->user()->currentAccessToken()?->id;
        $sessions = $request->user()->tokens()
            ->latest()
            ->get()
            ->map(fn (PersonalAccessToken $token) => [
                'id' => (string) $token->id,
                'device_name' => $token->name,
                'surface' => $token->surface(),
                'created_at' => $token->created_at->toIso8601String(),
                'last_used_at' => $token->last_used_at?->toIso8601String(),
                'expires_at' => $token->expires_at?->toIso8601String(),
                'mfa_verified_at' => $token->mfa_verified_at?->toIso8601String(),
                'current' => $token->id === $currentTokenId,
            ]);

        return response()->json(['data' => $sessions]);
    }

    public function revoke(Request $request, string $tokenId): JsonResponse
    {
        $token = $request->user()->tokens()->whereKey($tokenId)->firstOrFail();
        $current = $token->id === $request->user()->currentAccessToken()?->id;
        $family = $token->refreshTokenFamily;
        $this->audit->record(
            'identity.session_revoked',
            $request->user(),
            $token,
            ['surface' => $token->surface(), 'current' => $current],
            $request,
        );
        if ($family) {
            $this->mobileTokens->revokeFamily($family, 'session_revoked');
        } else {
            $token->delete();
        }

        return response()->json(['status' => 'revoked', 'current' => $current]);
    }

    public function revokeAll(RevokeAllSessionsRequest $request): JsonResponse
    {
        $user = $request->user();
        if (! Hash::check($request->validated('password'), $user->password)) {
            throw new MfaException('Password confirmation failed.', 'PASSWORD_CONFIRMATION_FAILED');
        }

        $keepCurrent = (bool) ($request->validated('keep_current') ?? false);
        $currentFamilyId = $keepCurrent
            ? $user->currentAccessToken()?->refresh_token_family_id
            : null;
        $query = $user->tokens();
        if ($keepCurrent && $currentId = $user->currentAccessToken()?->id) {
            $query->whereKeyNot($currentId);
        }
        $revokedCount = $query->count();
        $revokedFamilyCount = $this->mobileTokens->revokeAllForUser(
            $user,
            'sessions_revoked',
            $currentFamilyId,
        );
        $query->delete();
        $this->audit->record(
            'identity.sessions_revoked',
            $user,
            $user,
            [
                'revoked_count' => $revokedCount,
                'revoked_refresh_family_count' => $revokedFamilyCount,
                'kept_current' => $keepCurrent,
            ],
            $request,
        );

        return response()->json([
            'status' => 'revoked',
            'revoked_count' => $revokedCount,
            'kept_current' => $keepCurrent,
        ]);
    }
}
