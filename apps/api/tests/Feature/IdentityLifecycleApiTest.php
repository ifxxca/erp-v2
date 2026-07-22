<?php

namespace Tests\Feature;

use App\Models\AuditLog;
use App\Models\Company;
use App\Models\Department;
use App\Models\Location;
use App\Models\Permission;
use App\Models\Role;
use App\Models\User;
use App\Models\UserCompanyMembership;
use App\Models\UserRoleAssignment;
use App\Modules\Identity\Application\MobileTokenService;
use App\Notifications\UserInvitationNotification;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Notification;
use Laravel\Sanctum\PersonalAccessToken;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class IdentityLifecycleApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_active_employee_can_login_with_surface_specific_expiring_token(): void
    {
        $user = User::factory()->create(['email' => 'employee@example.test']);
        $company = $this->createCompany('RKS');
        $this->createActiveMembership($user, $company);

        $response = $this->postJson('/api/v1/auth/login', [
            'email' => 'employee@example.test',
            'password' => 'password',
            'surface' => 'mobile',
            'device_name' => 'Test Phone',
        ]);

        $response->assertOk()
            ->assertJsonPath('token_type', 'Bearer')
            ->assertJsonStructure(['access_token', 'expires_at']);

        $token = PersonalAccessToken::query()->sole();
        $this->assertTrue($token->can('surface:mobile'));
        $this->assertLessThanOrEqual(15 * 60, now()->diffInSeconds($token->expires_at, absolute: true));
        $this->assertDatabaseHas('audit_logs', [
            'actor_user_id' => $user->id,
            'event' => 'identity.login_succeeded',
        ]);
    }

    public function test_login_uses_generic_failure_for_inactive_identity_and_records_audit(): void
    {
        User::factory()->create([
            'email' => 'disabled@example.test',
            'status' => 'disabled',
        ]);

        $this->postJson('/api/v1/auth/login', [
            'email' => 'disabled@example.test',
            'password' => 'password',
            'surface' => 'erp_web',
            'device_name' => 'Browser',
        ])->assertUnauthorized()
            ->assertExactJson([
                'message' => 'Email or password is invalid.',
                'code' => 'INVALID_CREDENTIALS',
            ]);

        $this->assertDatabaseHas('audit_logs', [
            'actor_user_id' => null,
            'event' => 'identity.login_failed',
        ]);
    }

    public function test_logout_revokes_the_presented_token(): void
    {
        $user = User::factory()->create();
        $token = $user->createToken('Browser')->plainTextToken;

        $this->withToken($token)
            ->postJson('/api/v1/auth/logout')
            ->assertNoContent();

        $this->assertDatabaseCount('personal_access_tokens', 0);
        $this->assertDatabaseHas('audit_logs', [
            'actor_user_id' => $user->id,
            'event' => 'identity.logout',
        ]);
    }

    public function test_existing_token_is_denied_after_identity_is_disabled(): void
    {
        $user = User::factory()->create(['status' => 'disabled']);
        Sanctum::actingAs($user);

        $this->getJson('/api/v1/me')
            ->assertForbidden()
            ->assertExactJson([
                'message' => 'Identity is not active.',
                'code' => 'IDENTITY_INACTIVE',
            ]);
    }

    public function test_authorized_admin_can_invite_and_invitation_is_single_use(): void
    {
        Notification::fake();
        $company = $this->createCompany('RKS');
        $department = Department::query()->create([
            'company_id' => $company->id,
            'code' => 'IT',
            'name' => 'IT',
        ]);
        $location = Location::query()->create([
            'company_id' => $company->id,
            'code' => 'HQ',
            'name' => 'Head Office',
        ]);
        $actor = User::factory()->create();
        $this->grantUserManagement($actor, $company);
        Sanctum::actingAs($actor);

        $response = $this->postJson('/api/v1/identity/users/invitations', [
            'name' => 'New Employee',
            'email' => 'New.Employee@Example.Test',
            'company_id' => $company->id,
            'employee_no' => 'EMP-100',
            'department_ids' => [$department->id],
            'primary_department_id' => $department->id,
            'location_ids' => [$location->id],
            'valid_from' => today()->toDateString(),
        ]);

        $response->assertCreated()
            ->assertJsonPath('status', 'invited')
            ->assertJsonMissingPath('token');

        $invitee = User::query()->where('email', 'new.employee@example.test')->firstOrFail();
        $plainToken = null;
        Notification::assertSentTo(
            $invitee,
            UserInvitationNotification::class,
            function (UserInvitationNotification $notification) use (&$plainToken): bool {
                $plainToken = $notification->token;

                return true;
            },
        );
        $this->assertNotNull($plainToken);
        $this->assertDatabaseMissing('user_invitations', ['token_hash' => $plainToken]);

        $password = 'A-secure-password-123';
        $this->postJson('/api/v1/auth/invitations/accept', [
            'token' => $plainToken,
            'password' => $password,
            'password_confirmation' => $password,
        ])->assertOk()->assertExactJson(['status' => 'active']);

        $this->assertDatabaseHas('users', ['id' => $invitee->id, 'status' => 'active']);
        $this->assertDatabaseHas('user_company_memberships', [
            'user_id' => $invitee->id,
            'employment_status' => 'active',
        ]);
        $this->assertDatabaseHas('user_location_memberships', [
            'user_id' => $invitee->id,
            'company_id' => $company->id,
            'location_id' => $location->id,
        ]);
        $this->postJson('/api/v1/auth/invitations/accept', [
            'token' => $plainToken,
            'password' => $password,
            'password_confirmation' => $password,
        ])->assertUnprocessable()->assertJsonPath('code', 'INVITATION_INVALID');
    }

    public function test_company_scoped_admin_cannot_invite_for_another_company(): void
    {
        $companyA = $this->createCompany('A');
        $companyB = $this->createCompany('B');
        $departmentB = Department::query()->create([
            'company_id' => $companyB->id,
            'code' => 'IT',
            'name' => 'IT',
        ]);
        $actor = User::factory()->create();
        $this->grantUserManagement($actor, $companyA);
        Sanctum::actingAs($actor);

        $this->postJson('/api/v1/identity/users/invitations', [
            'name' => 'Unauthorized Invitee',
            'email' => 'unauthorized@example.test',
            'company_id' => $companyB->id,
            'department_ids' => [$departmentB->id],
            'primary_department_id' => $departmentB->id,
            'valid_from' => today()->toDateString(),
        ])->assertForbidden()->assertJsonPath('code', 'PERMISSION_DENIED');

        $this->assertDatabaseMissing('users', ['email' => 'unauthorized@example.test']);
    }

    public function test_terminating_last_company_membership_disables_identity_and_revokes_tokens(): void
    {
        $company = $this->createCompany('RKS');
        $actor = User::factory()->create();
        $this->grantUserManagement($actor, $company);
        $target = User::factory()->create();
        $this->createActiveMembership($target, $company);
        $target->createToken('Target Browser');
        $mobile = $this->app->make(MobileTokenService::class)->issue($target, 'Target Phone');
        Sanctum::actingAs($actor);

        $this->postJson("/api/v1/identity/users/{$target->id}/companies/{$company->id}/terminate", [
            'reason' => 'Employment ended',
        ])->assertOk()->assertExactJson(['status' => 'terminated']);

        $this->assertDatabaseHas('users', ['id' => $target->id, 'status' => 'disabled']);
        $this->assertDatabaseHas('user_company_memberships', [
            'user_id' => $target->id,
            'company_id' => $company->id,
            'employment_status' => 'terminated',
        ]);
        $this->assertDatabaseMissing('personal_access_tokens', ['tokenable_id' => $target->id]);
        $this->assertDatabaseHas('mobile_refresh_token_families', [
            'id' => $mobile['family_id'],
            'revocation_reason' => 'company_membership_terminated',
        ]);
        $audit = AuditLog::query()->where('event', 'identity.company_membership_terminated')->sole();
        $this->assertSame('Employment ended', $audit->metadata['reason']);
        $this->assertTrue($audit->metadata['identity_disabled']);
    }

    private function createCompany(string $code): Company
    {
        return Company::query()->create([
            'code' => $code,
            'legal_name' => "Company {$code}",
        ]);
    }

    private function createActiveMembership(User $user, Company $company): UserCompanyMembership
    {
        return UserCompanyMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'employment_status' => 'active',
            'is_primary' => true,
            'valid_from' => today(),
        ]);
    }

    private function grantUserManagement(User $actor, Company $company): void
    {
        $this->createActiveMembership($actor, $company);
        $permission = Permission::query()->create([
            'code' => 'identity.user.manage',
            'module' => 'identity',
            'resource' => 'user',
            'action' => 'manage',
        ]);
        $role = Role::query()->create([
            'code' => 'security-admin',
            'name' => 'Security Administrator',
        ]);
        $role->permissions()->attach($permission);
        UserRoleAssignment::query()->create([
            'user_id' => $actor->id,
            'role_id' => $role->id,
            'company_id' => $company->id,
            'valid_from' => now(),
            'assigned_by' => $actor->id,
        ]);
    }
}
