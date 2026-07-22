<?php

namespace App\Modules\Identity\Application;

use App\Models\PersonalAccessToken;
use App\Models\User;
use App\Models\UserMfaMethod;
use App\Models\UserMfaRecoveryCode;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use PragmaRX\Google2FA\Google2FA;
use Symfony\Component\HttpFoundation\Response;

class MfaService
{
    public function __construct(
        private readonly Google2FA $totp,
        private readonly AuditLogger $audit,
        private readonly MfaRequirementResolver $requirement,
        private readonly MobileTokenService $mobileTokens,
    ) {}

    /** @return array{secret: string, otpauth_url: string} */
    public function enroll(User $user, string $password, Request $request): array
    {
        if (! Hash::check($password, $user->password)) {
            throw new MfaException('Password confirmation failed.', 'PASSWORD_CONFIRMATION_FAILED');
        }

        if ($user->mfaMethods()->where('type', 'totp')->where('status', 'active')->exists()) {
            throw new MfaException(
                'TOTP is already enabled for this identity.',
                'MFA_ALREADY_ENABLED',
                Response::HTTP_CONFLICT,
            );
        }

        $secret = $this->totp->generateSecretKey();
        DB::transaction(function () use ($user, $secret, $request): void {
            $method = UserMfaMethod::query()->updateOrCreate(
                ['user_id' => $user->id, 'type' => 'totp'],
                [
                    'secret' => $secret,
                    'status' => 'pending',
                    'last_used_timestep' => null,
                    'confirmed_at' => null,
                    'disabled_at' => null,
                ],
            );
            $user->mfaRecoveryCodes()->delete();
            $this->audit->record(
                'identity.mfa_enrollment_started',
                $user,
                $method,
                request: $request,
            );
        });

        return [
            'secret' => $secret,
            'otpauth_url' => $this->totp->getQRCodeUrl(
                (string) config('app.name'),
                $user->email,
                $secret,
            ),
        ];
    }

    /** @return list<string> */
    public function confirm(User $user, string $code, Request $request): array
    {
        $this->assertSupportedToken($user);

        return DB::transaction(function () use ($user, $code, $request): array {
            $method = UserMfaMethod::query()
                ->where('user_id', $user->id)
                ->where('type', 'totp')
                ->where('status', 'pending')
                ->lockForUpdate()
                ->first();

            if (! $method || ! $method->secret) {
                throw new MfaException('A pending TOTP enrollment was not found.', 'MFA_ENROLLMENT_NOT_PENDING');
            }

            $timestep = $this->totp->verifyKeyNewer(
                $method->secret,
                $code,
                $method->last_used_timestep ?? 0,
                (int) config('identity.totp_window'),
            );
            if ($timestep === false) {
                throw new MfaException('The authentication code is invalid or already used.', 'MFA_CODE_INVALID');
            }

            $method->update([
                'status' => 'active',
                'last_used_timestep' => $timestep,
                'confirmed_at' => now(),
            ]);
            $recoveryCodes = $this->replaceRecoveryCodes($user);
            $this->markCurrentTokenVerified($user);
            $this->audit->record(
                'identity.mfa_enabled',
                $user,
                $method,
                ['recovery_code_count' => count($recoveryCodes)],
                $request,
            );

            return $recoveryCodes;
        });
    }

    public function challenge(User $user, string $credential, Request $request): string
    {
        $this->assertSupportedToken($user);

        $verificationMethod = DB::transaction(function () use ($user, $credential): ?string {
            $method = UserMfaMethod::query()
                ->where('user_id', $user->id)
                ->where('type', 'totp')
                ->where('status', 'active')
                ->lockForUpdate()
                ->first();

            if (! $method || ! $method->secret) {
                throw new MfaException('TOTP is not enabled for this identity.', 'MFA_NOT_ENABLED');
            }

            if (preg_match('/^\d{6}$/', $credential) === 1) {
                $timestep = $this->totp->verifyKeyNewer(
                    $method->secret,
                    $credential,
                    $method->last_used_timestep ?? 0,
                    (int) config('identity.totp_window'),
                );

                if ($timestep !== false) {
                    $method->update(['last_used_timestep' => $timestep]);

                    return 'totp';
                }
            } else {
                $normalized = $this->normalizeRecoveryCode($credential);
                $recoveryCodes = UserMfaRecoveryCode::query()
                    ->where('user_id', $user->id)
                    ->whereNull('used_at')
                    ->lockForUpdate()
                    ->get();

                foreach ($recoveryCodes as $recoveryCode) {
                    if (Hash::check($normalized, $recoveryCode->code_hash)) {
                        $recoveryCode->update(['used_at' => now()]);

                        return 'recovery_code';
                    }
                }
            }

            return null;
        });

        if (! $verificationMethod) {
            $this->audit->record('identity.mfa_challenge_failed', $user, request: $request);
            throw new MfaException('The authentication code is invalid or already used.', 'MFA_CODE_INVALID');
        }

        $this->markCurrentTokenVerified($user);
        $this->audit->record(
            'identity.mfa_challenge_succeeded',
            $user,
            metadata: ['method' => $verificationMethod],
            request: $request,
        );

        return $verificationMethod;
    }

    /** @return list<string> */
    public function regenerateRecoveryCodes(User $user, Request $request): array
    {
        if (! $user->mfaMethods()->where('status', 'active')->exists()) {
            throw new MfaException('TOTP is not enabled for this identity.', 'MFA_NOT_ENABLED');
        }

        $codes = DB::transaction(function () use ($user, $request): array {
            $codes = $this->replaceRecoveryCodes($user);
            $this->audit->record(
                'identity.mfa_recovery_codes_regenerated',
                $user,
                metadata: ['recovery_code_count' => count($codes)],
                request: $request,
            );

            return $codes;
        });

        return $codes;
    }

    public function disable(User $user, string $password, Request $request): void
    {
        if (! Hash::check($password, $user->password)) {
            throw new MfaException('Password confirmation failed.', 'PASSWORD_CONFIRMATION_FAILED');
        }
        if ($this->requirement->requiredByPrivilegedAssignment($user)) {
            throw new MfaException(
                'MFA cannot be disabled while privileged assignments are active.',
                'MFA_REQUIRED_BY_PRIVILEGED_ACCESS',
                Response::HTTP_CONFLICT,
            );
        }

        DB::transaction(function () use ($user, $request): void {
            $method = UserMfaMethod::query()
                ->where('user_id', $user->id)
                ->where('status', 'active')
                ->lockForUpdate()
                ->first();

            if (! $method) {
                throw new MfaException('TOTP is not enabled for this identity.', 'MFA_NOT_ENABLED');
            }

            $method->update([
                'secret' => null,
                'status' => 'disabled',
                'last_used_timestep' => null,
                'disabled_at' => now(),
            ]);
            $user->mfaRecoveryCodes()->delete();
            $this->mobileTokens->revokeAllForUser($user, 'mfa_disabled');
            $user->tokens()->delete();
            $this->audit->record('identity.mfa_disabled', $user, $method, request: $request);
        });
    }

    /** @return list<string> */
    private function replaceRecoveryCodes(User $user): array
    {
        $user->mfaRecoveryCodes()->delete();
        $codes = [];

        for ($index = 0; $index < (int) config('identity.recovery_code_count'); $index++) {
            $raw = Str::upper(Str::random(20));
            $formatted = implode('-', str_split($raw, 5));
            UserMfaRecoveryCode::query()->create([
                'user_id' => $user->id,
                'code_hash' => Hash::make($raw),
            ]);
            $codes[] = $formatted;
        }

        return $codes;
    }

    private function normalizeRecoveryCode(string $code): string
    {
        return Str::upper(str_replace(['-', ' '], '', trim($code)));
    }

    private function markCurrentTokenVerified(User $user): void
    {
        $token = $this->assertSupportedToken($user);
        $verifiedAt = now();
        $token->forceFill(['mfa_verified_at' => $verifiedAt])->save();
        $token->refreshTokenFamily?->update(['mfa_verified_at' => $verifiedAt]);
    }

    private function assertSupportedToken(User $user): PersonalAccessToken
    {
        $token = $user->currentAccessToken();

        if (! $token instanceof PersonalAccessToken) {
            throw new MfaException(
                'This authentication context cannot establish MFA assurance.',
                'MFA_TOKEN_CONTEXT_UNSUPPORTED',
            );
        }

        return $token;
    }
}
