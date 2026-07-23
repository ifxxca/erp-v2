<?php

namespace Tests\Feature;

use App\Models\Company;
use App\Models\Department;
use App\Models\Permission;
use App\Models\Role;
use App\Models\User;
use Database\Seeders\FoundationSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;

class FoundationSchemaTest extends TestCase
{
    use RefreshDatabase;

    public function test_identity_foundation_schema_is_created(): void
    {
        $expectedTables = [
            'companies',
            'departments',
            'locations',
            'user_company_memberships',
            'user_department_memberships',
            'user_location_memberships',
            'roles',
            'permissions',
            'role_permissions',
            'access_requests',
            'user_role_assignments',
            'user_invitations',
            'audit_logs',
            'personal_access_tokens',
            'user_mfa_methods',
            'user_mfa_recovery_codes',
            'mobile_refresh_token_families',
            'mobile_refresh_tokens',
            'files',
            'document_sequence_rules',
            'document_sequences',
            'document_number_allocations',
            'outbox_messages',
            'outbox_attempts',
            'notifications',
            'notification_deliveries',
            'notification_delivery_attempts',
        ];

        foreach ($expectedTables as $table) {
            $this->assertTrue(Schema::hasTable($table), "Missing table: {$table}");
        }
        $this->assertTrue(Schema::hasColumn('roles', 'assignment_scope'));
        $this->assertTrue(Schema::hasColumn('outbox_messages', 'attempts_in_cycle'));
        $this->assertTrue(Schema::hasColumn('notification_deliveries', 'attempts_in_cycle'));
    }

    public function test_foundation_seeder_is_repeatable(): void
    {
        $this->seed(FoundationSeeder::class);
        $this->seed(FoundationSeeder::class);

        $this->assertSame(2, Company::query()->count());
        $this->assertSame(16, Department::query()->count());
        $this->assertSame(9, Role::query()->count());
        $this->assertSame(23, Permission::query()->count());
        $this->assertSame('global', Role::query()->where('code', 'platform-admin')->value('assignment_scope'));
        $this->assertSame('company', Role::query()->where('code', 'hr-administrator')->value('assignment_scope'));
    }

    public function test_users_use_ulids_and_are_active_only_when_explicitly_created_active(): void
    {
        $user = User::factory()->create();

        $this->assertSame(26, strlen($user->id));
        $this->assertSame('active', $user->status);
    }
}
