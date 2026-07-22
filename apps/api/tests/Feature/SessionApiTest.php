<?php

namespace Tests\Feature;

use App\Models\PersonalAccessToken;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class SessionApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_session_list_contains_only_the_authenticated_users_devices(): void
    {
        $user = User::factory()->create();
        $otherUser = User::factory()->create();
        $erpToken = $user->createToken('ERP Browser', ['surface:erp_web'], now()->addHours(12));
        $user->createToken('Operations Tablet', ['surface:ops_web'], now()->addHours(24));
        $otherUser->createToken('Other User Device');

        $response = $this->withToken($erpToken->plainTextToken)
            ->getJson('/api/v1/auth/sessions')
            ->assertOk()
            ->assertJsonCount(2, 'data');

        $this->assertSame(
            ['ERP Browser', 'Operations Tablet'],
            collect($response->json('data'))->pluck('device_name')->sort()->values()->all(),
        );
        $current = collect($response->json('data'))->firstWhere('current', true);
        $this->assertSame('ERP Browser', $current['device_name']);
        $this->assertSame('erp_web', $current['surface']);
    }

    public function test_user_can_revoke_another_own_session_but_not_another_users_token(): void
    {
        $user = User::factory()->create();
        $otherUser = User::factory()->create();
        $current = $user->createToken('Current Browser');
        $otherDevice = $user->createToken('Old Browser');
        $foreignToken = $otherUser->createToken('Foreign Browser');

        $this->withToken($current->plainTextToken)
            ->deleteJson("/api/v1/auth/sessions/{$otherDevice->accessToken->id}")
            ->assertOk()
            ->assertJsonPath('current', false);

        $this->assertDatabaseHas('personal_access_tokens', ['id' => $current->accessToken->id]);
        $this->assertDatabaseMissing('personal_access_tokens', ['id' => $otherDevice->accessToken->id]);
        $this->withToken($current->plainTextToken)
            ->deleteJson("/api/v1/auth/sessions/{$foreignToken->accessToken->id}")
            ->assertNotFound();
        $this->assertDatabaseHas('personal_access_tokens', ['id' => $foreignToken->accessToken->id]);
        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.session_revoked']);
    }

    public function test_revoke_all_requires_password_and_can_keep_current_session(): void
    {
        $user = User::factory()->create();
        $current = $user->createToken('Current Browser');
        $user->createToken('Old Browser');
        $user->createToken('Old Tablet');

        $this->withToken($current->plainTextToken)
            ->postJson('/api/v1/auth/sessions/revoke-all', [
                'password' => 'wrong-password',
                'keep_current' => true,
            ])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'PASSWORD_CONFIRMATION_FAILED');
        $this->assertDatabaseCount('personal_access_tokens', 3);

        $this->withToken($current->plainTextToken)
            ->postJson('/api/v1/auth/sessions/revoke-all', [
                'password' => 'password',
                'keep_current' => true,
            ])
            ->assertOk()
            ->assertJsonPath('revoked_count', 2)
            ->assertJsonPath('kept_current', true);

        $this->assertDatabaseCount('personal_access_tokens', 1);
        $this->assertDatabaseHas('personal_access_tokens', ['id' => $current->accessToken->id]);
        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.sessions_revoked']);
    }

    public function test_idle_timeout_is_enforced_per_surface_before_last_used_is_updated(): void
    {
        $user = User::factory()->create();
        $erpToken = $user->createToken('ERP Browser', ['surface:erp_web'], now()->addHours(12));
        $erpToken->accessToken->forceFill(['last_used_at' => now()->subMinutes(31)])->save();
        $storedErpToken = PersonalAccessToken::query()->findOrFail($erpToken->accessToken->id);
        $this->assertSame('erp_web', $storedErpToken->surface());
        $this->assertTrue($storedErpToken->last_used_at->lt(now()->subMinutes(30)));
        $this->assertIsCallable(Sanctum::$accessTokenAuthenticationCallback);
        $this->assertFalse((Sanctum::$accessTokenAuthenticationCallback)($storedErpToken, true));

        $this->withToken($erpToken->plainTextToken)
            ->getJson('/api/v1/me')
            ->assertUnauthorized();
        $this->assertTrue(
            PersonalAccessToken::query()->findOrFail($erpToken->accessToken->id)
                ->last_used_at->lt(now()->subMinutes(30)),
        );

        $opsToken = $user->createToken('Operations Tablet', ['surface:ops_web'], now()->addHours(24));
        $opsToken->accessToken->forceFill(['last_used_at' => now()->subMinutes(31)])->save();
        $this->app['auth']->forgetGuards();

        $this->withToken($opsToken->plainTextToken)
            ->getJson('/api/v1/me')
            ->assertOk();
        $this->assertTrue(
            PersonalAccessToken::query()->findOrFail($opsToken->accessToken->id)
                ->last_used_at->gte(now()->subSecond()),
        );
    }

    public function test_expired_absolute_lifetime_token_is_rejected(): void
    {
        $user = User::factory()->create();
        $token = $user->createToken('Expired Device', ['surface:erp_web'], now()->subMinute());

        $this->withToken($token->plainTextToken)
            ->getJson('/api/v1/me')
            ->assertUnauthorized();
    }
}
