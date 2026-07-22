<?php

namespace Tests\Feature;

use App\Models\Company;
use App\Models\User;
use App\Models\UserCompanyMembership;
use App\Notifications\PasswordResetNotification;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Notification;
use Tests\TestCase;

class PasswordRecoveryApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_forgot_password_response_does_not_reveal_if_email_exists(): void
    {
        Notification::fake();
        $user = $this->activeEmployee('employee@example.test');
        $expected = [
            'message' => 'If the account is eligible, password reset instructions will be sent.',
        ];

        $this->postJson('/api/v1/auth/password/forgot', ['email' => 'Employee@Example.Test'])
            ->assertAccepted()
            ->assertExactJson($expected);
        $this->postJson('/api/v1/auth/password/forgot', ['email' => 'missing@example.test'])
            ->assertAccepted()
            ->assertExactJson($expected);

        Notification::assertSentTo($user, PasswordResetNotification::class);
        Notification::assertCount(1);
        $this->assertDatabaseCount('password_reset_tokens', 1);
    }

    public function test_reset_token_is_hashed_single_use_and_success_revokes_every_session(): void
    {
        Notification::fake();
        $user = $this->activeEmployee('employee@example.test');
        $user->createToken('ERP Browser');
        $user->createToken('Operations Tablet');
        $plainToken = null;

        $this->postJson('/api/v1/auth/password/forgot', ['email' => $user->email])->assertAccepted();
        Notification::assertSentTo(
            $user,
            PasswordResetNotification::class,
            function (PasswordResetNotification $notification) use (&$plainToken): bool {
                $plainToken = $notification->token;

                return true;
            },
        );
        $this->assertNotNull($plainToken);
        $this->assertNotSame(
            $plainToken,
            DB::table('password_reset_tokens')->where('email', $user->email)->value('token'),
        );

        $password = 'A-new-secure-password-123';
        $payload = [
            'email' => $user->email,
            'token' => $plainToken,
            'password' => $password,
            'password_confirmation' => $password,
        ];
        $this->postJson('/api/v1/auth/password/reset', $payload)
            ->assertOk()
            ->assertExactJson(['status' => 'password_reset']);

        $this->assertTrue(Hash::check($password, $user->fresh()->password));
        $this->assertDatabaseCount('personal_access_tokens', 0);
        $this->assertDatabaseCount('password_reset_tokens', 0);
        $this->assertDatabaseHas('audit_logs', ['event' => 'identity.password_reset_completed']);

        $this->postJson('/api/v1/auth/password/reset', $payload)
            ->assertUnprocessable()
            ->assertJsonPath('code', 'PASSWORD_RESET_INVALID');
    }

    public function test_disabled_identity_does_not_receive_reset_notification(): void
    {
        Notification::fake();
        $user = User::factory()->create([
            'email' => 'disabled@example.test',
            'status' => 'disabled',
        ]);

        $this->postJson('/api/v1/auth/password/forgot', ['email' => $user->email])
            ->assertAccepted();

        Notification::assertNothingSent();
        $this->assertDatabaseCount('password_reset_tokens', 0);
    }

    private function activeEmployee(string $email): User
    {
        $user = User::factory()->create(['email' => $email]);
        $company = Company::query()->create(['code' => 'RKS', 'legal_name' => 'Company RKS']);
        UserCompanyMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'employment_status' => 'active',
            'is_primary' => true,
            'valid_from' => today(),
        ]);

        return $user;
    }
}
