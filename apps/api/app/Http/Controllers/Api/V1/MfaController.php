<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\ConfirmPasswordRequest;
use App\Http\Requests\ConfirmTotpRequest;
use App\Http\Requests\MfaChallengeRequest;
use App\Models\PersonalAccessToken;
use App\Modules\Identity\Application\MfaRequirementResolver;
use App\Modules\Identity\Application\MfaService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class MfaController extends Controller
{
    public function __construct(
        private readonly MfaService $mfa,
        private readonly MfaRequirementResolver $requirement,
    ) {}

    public function status(Request $request): JsonResponse
    {
        $user = $request->user();
        $method = $user->mfaMethods()->where('type', 'totp')->first();
        $token = $user->currentAccessToken();

        return response()->json([
            'required' => $this->requirement->required($user),
            'enabled' => $method?->status === 'active',
            'status' => $method?->status ?? 'not_configured',
            'confirmed_at' => $method?->confirmed_at?->toIso8601String(),
            'unused_recovery_codes' => $user->mfaRecoveryCodes()->whereNull('used_at')->count(),
            'current_token_verified_at' => $token instanceof PersonalAccessToken
                ? $token->mfa_verified_at?->toIso8601String()
                : null,
        ]);
    }

    public function enroll(ConfirmPasswordRequest $request): JsonResponse
    {
        $enrollment = $this->mfa->enroll(
            $request->user(),
            $request->validated('password'),
            $request,
        );

        return response()->json([
            ...$enrollment,
            'status' => 'pending',
        ]);
    }

    public function confirm(ConfirmTotpRequest $request): JsonResponse
    {
        $codes = $this->mfa->confirm(
            $request->user(),
            $request->validated('code'),
            $request,
        );

        return response()->json([
            'status' => 'active',
            'recovery_codes' => $codes,
        ]);
    }

    public function challenge(MfaChallengeRequest $request): JsonResponse
    {
        $method = $this->mfa->challenge(
            $request->user(),
            $request->validated('credential'),
            $request,
        );

        return response()->json([
            'status' => 'verified',
            'method' => $method,
            'step_up_expires_at' => now()
                ->addMinutes((int) config('identity.step_up_lifetime_minutes'))
                ->toIso8601String(),
        ]);
    }

    public function regenerateRecoveryCodes(Request $request): JsonResponse
    {
        return response()->json([
            'recovery_codes' => $this->mfa->regenerateRecoveryCodes($request->user(), $request),
        ]);
    }

    public function disable(ConfirmPasswordRequest $request): JsonResponse
    {
        $this->mfa->disable(
            $request->user(),
            $request->validated('password'),
            $request,
        );

        return response()->json(['status' => 'disabled']);
    }
}
