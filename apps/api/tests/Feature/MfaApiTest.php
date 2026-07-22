<?php

namespace Tests\Feature;

use App\Models\Company;
use App\Models\PersonalAccessToken;
use App\Models\Role;
use App\Models\User;
use App\Models\UserCompanyMembership;
use App\Models\UserMfaMethod;
use App\Models\UserRoleAssignment;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use PragmaRX\Google2FA\Google2FA;
use Tests\TestCase;

class MfaApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_enrollment_requires_password_and_stores_secret_encrypted(): void
    {
        $user = $this->activeUser();
        $token = $this->tokenFor($user);

        $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/totp/enroll', ['password' => 'wrong-password'])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'PASSWORD_CONFIRMATION_FAILED');

        $response = $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/totp/enroll', ['password' => 'password'])
            ->assertOk()
            ->assertJsonPath('status', 'pending')
            ->assertJsonStructure(['secret', 'otpauth_url']);

        $secret = $response->json('secret');
        $this->assertSame(32, strlen($secret));
        $this->assertStringStartsWith('otpauth://totp/', $response->json('otpauth_url'));
        $this->assertNotSame(
            $secret,
            DB::table('user_mfa_methods')->where('user_id', $user->id)->value('secret'),
        );
        $this->assertSame($secret, UserMfaMethod::query()->where('user_id', $user->id)->sole()->secret);
    }

    public function test_confirmation_enables_mfa_returns_recovery_codes_once_and_verifies_current_token(): void
    {
        $user = $this->activeUser();
        $token = $this->tokenFor($user);
        $secret = $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/totp/enroll', ['password' => 'password'])
            ->json('secret');
        $code = app(Google2FA::class)->getCurrentOtp($secret);

        $response = $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/totp/confirm', ['code' => $code])
            ->assertOk()
            ->assertJsonPath('status', 'active');

        $recoveryCodes = $response->json('recovery_codes');
        $this->assertCount(8, $recoveryCodes);
        $this->assertDatabaseHas('user_mfa_methods', ['user_id' => $user->id, 'status' => 'active']);
        $this->assertDatabaseCount('user_mfa_recovery_codes', 8);
        $this->assertNotNull(PersonalAccessToken::findToken($token)->mfa_verified_at);
        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.mfa_enabled']);
    }

    public function test_totp_code_cannot_be_replayed_after_confirmation(): void
    {
        $user = $this->activeUser();
        $token = $this->tokenFor($user);
        $secret = $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/totp/enroll', ['password' => 'password'])
            ->json('secret');
        $code = app(Google2FA::class)->getCurrentOtp($secret);
        $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/totp/confirm', ['code' => $code])
            ->assertOk();

        $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/challenge', ['credential' => $code])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'MFA_CODE_INVALID');

        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.mfa_challenge_failed']);
    }

    public function test_successful_totp_challenge_unlocks_only_the_current_token(): void
    {
        $user = $this->activeUser();
        $secret = app(Google2FA::class)->generateSecretKey();
        UserMfaMethod::query()->create([
            'user_id' => $user->id,
            'type' => 'totp',
            'secret' => $secret,
            'status' => 'active',
            'confirmed_at' => now(),
        ]);
        $tokenA = $this->tokenFor($user);
        $tokenB = $this->tokenFor($user);

        $this->withToken($tokenA)
            ->getJson('/api/v1/me')
            ->assertForbidden()
            ->assertJsonPath('code', 'MFA_CHALLENGE_REQUIRED');
        $this->withToken($tokenA)
            ->postJson('/api/v1/auth/mfa/challenge', [
                'credential' => app(Google2FA::class)->getCurrentOtp($secret),
            ])
            ->assertOk()
            ->assertJsonPath('method', 'totp');
        $this->withToken($tokenA)->getJson('/api/v1/me')->assertOk();
        $this->app['auth']->forgetGuards();
        $this->withToken($tokenB)
            ->getJson('/api/v1/me')
            ->assertForbidden()
            ->assertJsonPath('code', 'MFA_CHALLENGE_REQUIRED');
    }

    public function test_recovery_code_is_single_use(): void
    {
        $user = $this->activeUser();
        $token = $this->tokenFor($user);
        $secret = $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/totp/enroll', ['password' => 'password'])
            ->json('secret');
        $recoveryCode = $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/totp/confirm', [
                'code' => app(Google2FA::class)->getCurrentOtp($secret),
            ])->json('recovery_codes.0');

        $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/challenge', ['credential' => $recoveryCode])
            ->assertOk()
            ->assertJsonPath('method', 'recovery_code');
        $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/challenge', ['credential' => $recoveryCode])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'MFA_CODE_INVALID');

        $this->assertDatabaseCount('user_mfa_recovery_codes', 8);
        $this->assertSame(7, $user->mfaRecoveryCodes()->whereNull('used_at')->count());
    }

    public function test_regenerating_recovery_codes_invalidates_the_previous_set(): void
    {
        $user = $this->activeUser();
        $token = $this->tokenFor($user);
        $secret = $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/totp/enroll', ['password' => 'password'])
            ->json('secret');
        $oldCode = $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/totp/confirm', [
                'code' => app(Google2FA::class)->getCurrentOtp($secret),
            ])->json('recovery_codes.0');

        $response = $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/recovery-codes/regenerate')
            ->assertOk();

        $this->assertCount(8, $response->json('recovery_codes'));
        $this->assertNotContains($oldCode, $response->json('recovery_codes'));
        $this->assertDatabaseCount('user_mfa_recovery_codes', 8);
        $this->withToken($token)
            ->postJson('/api/v1/auth/mfa/challenge', ['credential' => $oldCode])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'MFA_CODE_INVALID');
    }

    public function test_mfa_cannot_be_disabled_while_privileged_assignment_is_active(): void
    {
        $user = $this->activeUser();
        $company = $user->companyMemberships()->firstOrFail()->company;
        $role = Role::query()->create([
            'code' => 'privileged-test',
            'name' => 'Privileged Test',
            'is_privileged' => true,
        ]);
        UserRoleAssignment::query()->create([
            'user_id' => $user->id,
            'role_id' => $role->id,
            'company_id' => $company->id,
            'valid_from' => now(),
            'assigned_by' => $user->id,
        ]);
        UserMfaMethod::query()->create([
            'user_id' => $user->id,
            'type' => 'totp',
            'secret' => app(Google2FA::class)->generateSecretKey(),
            'status' => 'active',
            'confirmed_at' => now(),
        ]);

        $this->withToken($this->tokenFor($user, mfaVerified: true))
            ->deleteJson('/api/v1/auth/mfa/totp', ['password' => 'password'])
            ->assertConflict()
            ->assertJsonPath('code', 'MFA_REQUIRED_BY_PRIVILEGED_ACCESS');

        $this->assertDatabaseHas('user_mfa_methods', ['user_id' => $user->id, 'status' => 'active']);
    }

    public function test_disabling_optional_mfa_revokes_all_tokens_and_removes_recovery_codes(): void
    {
        $user = $this->activeUser();
        UserMfaMethod::query()->create([
            'user_id' => $user->id,
            'type' => 'totp',
            'secret' => app(Google2FA::class)->generateSecretKey(),
            'status' => 'active',
            'confirmed_at' => now(),
        ]);
        $token = $this->tokenFor($user, mfaVerified: true);
        $user->mfaRecoveryCodes()->create(['code_hash' => password_hash('RECOVERY', PASSWORD_BCRYPT)]);

        $this->withToken($token)
            ->deleteJson('/api/v1/auth/mfa/totp', ['password' => 'password'])
            ->assertOk()
            ->assertExactJson(['status' => 'disabled']);

        $this->assertDatabaseHas('user_mfa_methods', ['user_id' => $user->id, 'status' => 'disabled']);
        $this->assertDatabaseCount('user_mfa_recovery_codes', 0);
        $this->assertDatabaseCount('personal_access_tokens', 0);
        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.mfa_disabled']);
    }

    private function activeUser(): User
    {
        $user = User::factory()->create();
        $company = Company::query()->create([
            'code' => 'RKS',
            'legal_name' => 'Company RKS',
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

    private function tokenFor(User $user, bool $mfaVerified = false): string
    {
        $plainTextToken = $user->createToken('Test Device')->plainTextToken;
        if ($mfaVerified) {
            PersonalAccessToken::findToken($plainTextToken)
                ->forceFill(['mfa_verified_at' => now()])
                ->save();
        }
        $this->app['auth']->forgetGuards();

        return $plainTextToken;
    }
}
