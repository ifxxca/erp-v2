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
        ];

        foreach ($expectedTables as $table) {
            $this->assertTrue(Schema::hasTable($table), "Missing table: {$table}");
        }
    }

    public function test_foundation_seeder_is_repeatable(): void
    {
        $this->seed(FoundationSeeder::class);
        $this->seed(FoundationSeeder::class);

        $this->assertSame(2, Company::query()->count());
        $this->assertSame(16, Department::query()->count());
        $this->assertSame(7, Role::query()->count());
        $this->assertSame(13, Permission::query()->count());
    }

    public function test_users_use_ulids_and_are_active_only_when_explicitly_created_active(): void
    {
        $user = User::factory()->create();

        $this->assertSame(26, strlen($user->id));
        $this->assertSame('active', $user->status);
    }
}
