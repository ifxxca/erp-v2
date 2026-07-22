<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\RequestPasswordResetRequest;
use App\Http\Requests\ResetPasswordRequest;
use App\Models\User;
use App\Modules\Identity\Application\AuditLogger;
use App\Modules\Identity\Application\MobileTokenService;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Auth\Passwords\PasswordBroker;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Password as PasswordFacade;
use Symfony\Component\HttpFoundation\Response;

class PasswordRecoveryController extends Controller
{
    public function __construct(
        private readonly AuditLogger $audit,
        private readonly MobileTokenService $mobileTokens,
    ) {}

    public function request(RequestPasswordResetRequest $request): JsonResponse
    {
        $email = $request->validated('email');
        PasswordFacade::sendResetLink(['email' => $email, 'status' => 'active']);
        $this->audit->record(
            'identity.password_reset_requested',
            metadata: ['email_fingerprint' => hash('sha256', $email)],
            request: $request,
        );

        return response()->json([
            'message' => 'If the account is eligible, password reset instructions will be sent.',
        ], Response::HTTP_ACCEPTED);
    }

    public function reset(ResetPasswordRequest $request): JsonResponse
    {
        $credentials = [
            ...$request->safe()->only(['email', 'token', 'password', 'password_confirmation']),
            'status' => 'active',
        ];

        $status = PasswordFacade::reset(
            $credentials,
            function (User $user, string $password) use ($request): void {
                $user->forceFill(['password' => $password])->save();
                $this->mobileTokens->revokeAllForUser($user, 'password_reset');
                $user->tokens()->delete();
                $this->audit->record('identity.password_reset_completed', $user, $user, request: $request);
                event(new PasswordReset($user));
            },
        );

        if ($status !== PasswordBroker::PASSWORD_RESET) {
            $this->audit->record(
                'identity.password_reset_failed',
                metadata: ['email_fingerprint' => hash('sha256', $credentials['email'])],
                request: $request,
            );

            return response()->json([
                'message' => 'The password reset token is invalid or expired.',
                'code' => 'PASSWORD_RESET_INVALID',
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        return response()->json(['status' => 'password_reset']);
    }
}
