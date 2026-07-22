<?php

namespace Tests\Feature;

use App\Models\Company;
use App\Models\MobileRefreshToken;
use App\Models\MobileRefreshTokenFamily;
use App\Models\PersonalAccessToken;
use App\Models\User;
use App\Models\UserCompanyMembership;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class MobileRefreshTokenApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_mobile_login_issues_hashed_device_bound_refresh_token_only_for_mobile(): void
    {
        $user = $this->activeEmployee();

        $mobile = $this->login($user, 'mobile', 'Pixel Test')->assertOk();
        $plainRefreshToken = $mobile->json('refresh_token');
        $mobile->assertJsonStructure([
            'token_type',
            'access_token',
            'expires_at',
            'refresh_token',
            'refresh_expires_at',
            'mfa_required',
        ]);

        $storedRefreshToken = MobileRefreshToken::query()->sole();
        $family = MobileRefreshTokenFamily::query()->sole();
        $accessToken = PersonalAccessToken::query()->sole();
        $this->assertSame(hash('sha256', $plainRefreshToken), $storedRefreshToken->token_hash);
        $this->assertNotSame($plainRefreshToken, $storedRefreshToken->token_hash);
        $this->assertSame('Pixel Test', $family->device_name);
        $this->assertSame($family->id, $accessToken->refresh_token_family_id);
        $this->assertLessThanOrEqual(
            30 * 24 * 60 * 60,
            now()->diffInSeconds($family->absolute_expires_at, absolute: true),
        );

        $this->login($user, 'erp_web', 'ERP Browser')
            ->assertOk()
            ->assertJsonMissingPath('refresh_token')
            ->assertJsonMissingPath('refresh_expires_at');
        $this->assertDatabaseCount('mobile_refresh_token_families', 1);
    }

    public function test_refresh_rotates_token_without_extending_absolute_expiry_and_replaces_access_token(): void
    {
        $user = $this->activeEmployee();
        $login = $this->login($user);
        $oldAccessToken = $login->json('access_token');
        $oldRefreshToken = $login->json('refresh_token');
        $absoluteExpiry = $login->json('refresh_expires_at');
        $oldStoredToken = MobileRefreshToken::query()->sole();
        $oldAccessTokenId = PersonalAccessToken::query()->sole()->id;

        $rotated = $this->postJson('/api/v1/auth/mobile/refresh', [
            'refresh_token' => $oldRefreshToken,
        ])->assertOk();

        $newRefreshToken = $rotated->json('refresh_token');
        $newAccessToken = $rotated->json('access_token');
        $this->assertNotSame($oldRefreshToken, $newRefreshToken);
        $this->assertNotSame($oldAccessToken, $newAccessToken);
        $this->assertSame($absoluteExpiry, $rotated->json('refresh_expires_at'));
        $this->assertNotNull($oldStoredToken->fresh()->consumed_at);
        $this->assertDatabaseMissing('personal_access_tokens', ['id' => $oldAccessTokenId]);
        $this->assertDatabaseCount('personal_access_tokens', 1);
        $this->assertDatabaseHas('mobile_refresh_tokens', [
            'parent_id' => $oldStoredToken->id,
            'token_hash' => hash('sha256', $newRefreshToken),
        ]);

        $this->withToken($oldAccessToken)->getJson('/api/v1/me')->assertUnauthorized();
        $this->withToken($newAccessToken)->getJson('/api/v1/me')->assertOk();
        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.mobile_refresh_rotated']);
    }

    public function test_reusing_consumed_refresh_token_revokes_its_family_but_not_another_device(): void
    {
        $user = $this->activeEmployee();
        $firstDevice = $this->login($user, deviceName: 'Phone A');
        $firstOldRefresh = $firstDevice->json('refresh_token');
        $firstFamily = MobileRefreshTokenFamily::query()->sole();
        $firstRotated = $this->postJson('/api/v1/auth/mobile/refresh', [
            'refresh_token' => $firstOldRefresh,
        ])->assertOk();

        $secondDevice = $this->login($user, deviceName: 'Phone B');
        $secondFamily = MobileRefreshTokenFamily::query()->where('device_name', 'Phone B')->sole();

        $this->postJson('/api/v1/auth/mobile/refresh', [
            'refresh_token' => $firstOldRefresh,
        ])->assertUnauthorized()->assertExactJson([
            'message' => 'The refresh token is invalid or expired.',
            'code' => 'REFRESH_TOKEN_INVALID',
        ]);

        $this->assertSame('refresh_token_reuse', $firstFamily->fresh()->revocation_reason);
        $this->assertNotNull($firstFamily->fresh()->revoked_at);
        $this->assertNull($secondFamily->fresh()->revoked_at);
        $this->withToken($firstRotated->json('access_token'))->getJson('/api/v1/me')->assertUnauthorized();
        $this->postJson('/api/v1/auth/mobile/refresh', [
            'refresh_token' => $secondDevice->json('refresh_token'),
        ])->assertOk();
        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.mobile_refresh_reuse_detected']);
    }

    public function test_expired_or_ineligible_family_cannot_mint_access_token(): void
    {
        $user = $this->activeEmployee();
        $expiredLogin = $this->login($user, deviceName: 'Expired Phone');
        $expiredFamily = MobileRefreshTokenFamily::query()->sole();
        $expiredFamily->forceFill(['absolute_expires_at' => now()->subSecond()])->save();

        $this->postJson('/api/v1/auth/mobile/refresh', [
            'refresh_token' => $expiredLogin->json('refresh_token'),
        ])->assertUnauthorized()->assertJsonPath('code', 'REFRESH_TOKEN_INVALID');
        $this->assertSame('expired_or_revoked', $expiredFamily->fresh()->revocation_reason);

        $disabledLogin = $this->login($user, deviceName: 'Disabled Phone');
        $disabledFamily = MobileRefreshTokenFamily::query()->where('device_name', 'Disabled Phone')->sole();
        $user->update(['status' => 'disabled']);

        $this->postJson('/api/v1/auth/mobile/refresh', [
            'refresh_token' => $disabledLogin->json('refresh_token'),
        ])->assertUnauthorized()->assertJsonPath('code', 'REFRESH_TOKEN_INVALID');
        $this->assertSame('identity_ineligible', $disabledFamily->fresh()->revocation_reason);
    }

    public function test_revoking_mobile_session_also_revokes_refresh_family(): void
    {
        $user = $this->activeEmployee();
        $login = $this->login($user);
        $accessToken = PersonalAccessToken::query()->sole();
        $family = MobileRefreshTokenFamily::query()->sole();

        $this->withToken($login->json('access_token'))
            ->deleteJson("/api/v1/auth/sessions/{$accessToken->id}")
            ->assertOk()
            ->assertJsonPath('current', true);

        $this->assertSame('session_revoked', $family->fresh()->revocation_reason);
        $this->postJson('/api/v1/auth/mobile/refresh', [
            'refresh_token' => $login->json('refresh_token'),
        ])->assertUnauthorized()->assertJsonPath('code', 'REFRESH_TOKEN_INVALID');
    }

    public function test_mobile_logout_revokes_refresh_family(): void
    {
        $user = $this->activeEmployee();
        $login = $this->login($user);
        $family = MobileRefreshTokenFamily::query()->sole();

        $this->withToken($login->json('access_token'))
            ->postJson('/api/v1/auth/logout')
            ->assertNoContent();

        $this->assertSame('logout', $family->fresh()->revocation_reason);
        $this->assertDatabaseCount('personal_access_tokens', 0);
        $this->postJson('/api/v1/auth/mobile/refresh', [
            'refresh_token' => $login->json('refresh_token'),
        ])->assertUnauthorized()->assertJsonPath('code', 'REFRESH_TOKEN_INVALID');
    }

    public function test_mfa_assurance_is_bound_to_family_and_carried_to_rotated_access_token(): void
    {
        $user = $this->activeEmployee();
        $login = $this->login($user);
        $verifiedAt = now()->subMinutes(5);
        $family = MobileRefreshTokenFamily::query()->sole();
        $family->forceFill(['mfa_verified_at' => $verifiedAt])->save();

        $rotated = $this->postJson('/api/v1/auth/mobile/refresh', [
            'refresh_token' => $login->json('refresh_token'),
        ])->assertOk();

        $newAccessToken = PersonalAccessToken::query()->sole();
        $this->assertTrue($newAccessToken->mfa_verified_at->equalTo($family->fresh()->mfa_verified_at));
        $this->assertSame($family->id, $newAccessToken->refresh_token_family_id);
        $this->withToken($rotated->json('access_token'))->getJson('/api/v1/auth/sessions')->assertOk();
    }

    private function activeEmployee(): User
    {
        $user = User::factory()->create();
        $company = Company::query()->create([
            'code' => 'RKS',
            'legal_name' => 'PT Rajawali Karya Sentosa',
        ]);
        UserCompanyMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'employment_status' => 'active',
            'is_primary' => true,
            'valid_from' => today(),
        ]);

        return $user;
    }

    private function login(
        User $user,
        string $surface = 'mobile',
        string $deviceName = 'Test Phone',
    ) {
        return $this->postJson('/api/v1/auth/login', [
            'email' => $user->email,
            'password' => 'password',
            'surface' => $surface,
            'device_name' => $deviceName,
        ]);
    }
}
