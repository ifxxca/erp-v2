<?php

namespace App\Modules\Identity\Application;

use App\Models\MobileRefreshToken;
use App\Models\MobileRefreshTokenFamily;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class MobileTokenService
{
    public function __construct(
        private readonly AuditLogger $audit,
        private readonly IdentityEligibility $eligibility,
        private readonly MfaRequirementResolver $mfaRequirement,
    ) {}

    /** @return array{access_token: string, expires_at: string, refresh_token: string, refresh_expires_at: string, family_id: string, token_id: int, mfa_required: bool} */
    public function issue(User $user, string $deviceName): array
    {
        if (! $this->eligibility->isActiveEmployee($user)) {
            throw new RefreshTokenException;
        }

        return DB::transaction(function () use ($user, $deviceName): array {
            $absoluteExpiry = now()->addDays((int) config('identity.mobile_refresh_token_lifetime_days'));
            $family = MobileRefreshTokenFamily::query()->create([
                'user_id' => $user->id,
                'device_name' => $deviceName,
                'absolute_expires_at' => $absoluteExpiry,
            ]);

            return $this->issuePair($family, null);
        });
    }

    /** @return array{access_token: string, expires_at: string, refresh_token: string, refresh_expires_at: string, family_id: string, token_id: int, mfa_required: bool} */
    public function rotate(string $plainRefreshToken, Request $request): array
    {
        $result = DB::transaction(function () use ($plainRefreshToken, $request): array {
            $refreshToken = MobileRefreshToken::query()
                ->where('token_hash', hash('sha256', $plainRefreshToken))
                ->lockForUpdate()
                ->first();

            if (! $refreshToken) {
                $this->audit->record(
                    'identity.mobile_refresh_failed',
                    metadata: ['reason' => 'not_found'],
                    request: $request,
                );

                return ['error' => true];
            }

            $family = MobileRefreshTokenFamily::query()
                ->whereKey($refreshToken->family_id)
                ->lockForUpdate()
                ->firstOrFail();

            if ($refreshToken->consumed_at) {
                $this->revokeLockedFamily($family, 'refresh_token_reuse');
                $this->audit->record(
                    'identity.mobile_refresh_reuse_detected',
                    $family->user,
                    $family,
                    ['refresh_token_id' => $refreshToken->id],
                    $request,
                );

                return ['error' => true];
            }

            if ($family->revoked_at || $family->absolute_expires_at->isPast() || $refreshToken->expires_at->isPast()) {
                $this->revokeLockedFamily($family, 'expired_or_revoked');
                $this->audit->record(
                    'identity.mobile_refresh_failed',
                    $family->user,
                    $family,
                    ['reason' => 'expired_or_revoked'],
                    $request,
                );

                return ['error' => true];
            }

            $user = $family->user;
            if (! $this->eligibility->isActiveEmployee($user)) {
                $this->revokeLockedFamily($family, 'identity_ineligible');
                $this->audit->record(
                    'identity.mobile_refresh_failed',
                    $user,
                    $family,
                    ['reason' => 'identity_ineligible'],
                    $request,
                );

                return ['error' => true];
            }

            $refreshToken->update(['consumed_at' => now()]);
            $family->accessTokens()->delete();
            $pair = $this->issuePair($family, $refreshToken);
            $family->update(['last_rotated_at' => now()]);
            $this->audit->record(
                'identity.mobile_refresh_rotated',
                $user,
                $family,
                ['refresh_token_id' => $refreshToken->id, 'access_token_id' => $pair['token_id']],
                $request,
            );

            return $pair;
        });

        if (isset($result['error'])) {
            throw new RefreshTokenException;
        }

        return $result;
    }

    public function revokeFamily(MobileRefreshTokenFamily $family, string $reason): void
    {
        DB::transaction(function () use ($family, $reason): void {
            $lockedFamily = MobileRefreshTokenFamily::query()->lockForUpdate()->find($family->id);
            if ($lockedFamily) {
                $this->revokeLockedFamily($lockedFamily, $reason);
            }
        });
    }

    public function revokeAllForUser(User $user, string $reason, ?string $exceptFamilyId = null): int
    {
        return DB::transaction(function () use ($user, $reason, $exceptFamilyId): int {
            $families = MobileRefreshTokenFamily::query()
                ->where('user_id', $user->id)
                ->whereNull('revoked_at')
                ->when($exceptFamilyId, fn ($query) => $query->whereKeyNot($exceptFamilyId))
                ->lockForUpdate()
                ->get();

            foreach ($families as $family) {
                $this->revokeLockedFamily($family, $reason);
            }

            return $families->count();
        });
    }

    /** @return array{access_token: string, expires_at: string, refresh_token: string, refresh_expires_at: string, family_id: string, token_id: int, mfa_required: bool} */
    private function issuePair(MobileRefreshTokenFamily $family, ?MobileRefreshToken $parent): array
    {
        $user = $family->user;
        $accessExpiry = now()->addMinutes((int) config('identity.token_lifetime_minutes.mobile'));
        $accessToken = $user->createToken($family->device_name, ['surface:mobile'], $accessExpiry);
        $accessToken->accessToken->forceFill([
            'refresh_token_family_id' => $family->id,
            'mfa_verified_at' => $family->mfa_verified_at,
        ])->save();

        $plainRefreshToken = Str::random(80);
        MobileRefreshToken::query()->create([
            'family_id' => $family->id,
            'parent_id' => $parent?->id,
            'token_hash' => hash('sha256', $plainRefreshToken),
            'expires_at' => $family->absolute_expires_at,
        ]);

        return [
            'access_token' => $accessToken->plainTextToken,
            'expires_at' => $accessExpiry->toIso8601String(),
            'refresh_token' => $plainRefreshToken,
            'refresh_expires_at' => $family->absolute_expires_at->toIso8601String(),
            'family_id' => $family->id,
            'token_id' => $accessToken->accessToken->id,
            'mfa_required' => $this->mfaRequirement->required($user),
        ];
    }

    private function revokeLockedFamily(MobileRefreshTokenFamily $family, string $reason): void
    {
        if (! $family->revoked_at) {
            $family->update(['revoked_at' => now(), 'revocation_reason' => $reason]);
        }
        $family->accessTokens()->delete();
    }
}
