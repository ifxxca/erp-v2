<?php

namespace Tests\Feature;

use App\Models\ChecklistAnswer;
use App\Models\Company;
use App\Models\Department;
use App\Models\MaintenanceWorkOrder;
use App\Models\Role;
use App\Models\User;
use App\Models\UserMfaMethod;
use App\Models\UserRoleAssignment;
use App\Models\Vehicle;
use App\Models\VehicleTrip;
use Database\Seeders\DemoSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use LogicException;
use PragmaRX\Google2FA\Google2FA;
use Tests\TestCase;

class DemoSeederTest extends TestCase
{
    use RefreshDatabase;

    protected function tearDown(): void
    {
        config(['app.env' => 'testing']);
        $this->app['auth']->forgetGuards();
        parent::tearDown();
    }

    public function test_demo_seeder_is_repeatable_and_builds_consistent_personas_and_fleet_data(): void
    {
        $this->seed(DemoSeeder::class);
        $this->seed(DemoSeeder::class);

        $this->assertSame(2, Company::query()->count());
        $this->assertSame(16, Department::query()->count());
        $this->assertSame(9, Role::query()->count());
        $this->assertSame(3, User::query()->count());
        $this->assertSame(4, UserRoleAssignment::query()->active()->count());
        $this->assertSame(3, Vehicle::query()->count());
        $this->assertSame(2, VehicleTrip::query()->count());
        $this->assertSame(12, ChecklistAnswer::query()->count());
        $this->assertSame(1, MaintenanceWorkOrder::query()->count());

        $admin = User::query()->where('email', 'erp.admin@demo.rajawali.test')->firstOrFail();
        $driver = User::query()->where('email', 'mobile.driver@demo.rajawali.test')->firstOrFail();
        $this->assertTrue(Hash::check((string) config('demo.password'), $admin->password));
        $this->assertSame(
            config('demo.totp_secret'),
            UserMfaMethod::query()->where('user_id', $admin->id)->value('secret'),
        );
        $this->assertDatabaseHas('vehicle_trips', [
            'driver_id' => $driver->id,
            'status' => 'active',
            'active_driver_key' => $driver->id,
        ]);
        $this->assertDatabaseHas('vehicles', [
            'code' => 'DEMO-TRUCK-01',
            'operational_status' => 'in_use',
        ]);
        $this->assertDatabaseHas('vehicles', [
            'code' => 'DEMO-TRUCK-02',
            'operational_status' => 'maintenance',
        ]);
    }

    public function test_demo_personas_can_login_to_their_surfaces_and_receive_expected_context(): void
    {
        $this->seed(DemoSeeder::class);
        $password = (string) config('demo.password');

        $adminLogin = $this->postJson('/api/v1/auth/login', [
            'email' => 'erp.admin@demo.rajawali.test',
            'password' => $password,
            'surface' => 'erp_web',
            'device_name' => 'Demo ERP Test',
        ])->assertOk()->assertJsonPath('mfa_required', true);
        $adminToken = $adminLogin->json('access_token');
        $this->withToken($adminToken)
            ->postJson('/api/v1/auth/mfa/challenge', [
                'credential' => app(Google2FA::class)->getCurrentOtp((string) config('demo.totp_secret')),
            ])
            ->assertOk();
        $this->withToken($adminToken)
            ->getJson('/api/v1/me')
            ->assertOk()
            ->assertJsonPath('email', 'erp.admin@demo.rajawali.test');
        $this->app['auth']->forgetGuards();

        $managerToken = $this->postJson('/api/v1/auth/login', [
            'email' => 'ops.manager@demo.rajawali.test',
            'password' => $password,
            'surface' => 'ops_web',
            'device_name' => 'Demo OPS Test',
        ])->assertOk()->assertJsonPath('mfa_required', false)->json('access_token');
        $this->app['auth']->forgetGuards();
        $this->withToken($managerToken)
            ->getJson('/api/v1/operations/context')
            ->assertOk()
            ->assertJsonPath('data.0.location.code', 'KRESEK')
            ->assertJsonPath('data.0.capabilities.can_manage_vehicles', true)
            ->assertJsonPath('data.0.capabilities.can_manage_work_orders', true)
            ->assertJsonPath('data.0.capabilities.can_manage_trips', true);
        $this->app['auth']->forgetGuards();

        $driverLogin = $this->postJson('/api/v1/auth/login', [
            'email' => 'mobile.driver@demo.rajawali.test',
            'password' => $password,
            'surface' => 'mobile',
            'device_name' => 'Demo Mobile Test',
        ])->assertOk()
            ->assertJsonPath('mfa_required', false)
            ->assertJsonStructure(['access_token', 'refresh_token', 'refresh_expires_at']);
        $driverToken = $driverLogin->json('access_token');
        $this->app['auth']->forgetGuards();
        $context = $this->withToken($driverToken)
            ->getJson('/api/v1/operations/context')
            ->assertOk()
            ->assertJsonPath('data.0.location.code', 'KRESEK')
            ->assertJsonPath('data.0.capabilities.can_operate_trips', true)
            ->assertJsonPath('data.0.capabilities.can_manage_trips', false);
        $companyId = $context->json('data.0.company.id');
        $locationId = $context->json('data.0.location.id');
        $this->withToken($driverToken)
            ->getJson("/api/v1/companies/{$companyId}/locations/{$locationId}/fleet/trips?status=active")
            ->assertOk()
            ->assertJsonCount(1, 'data')
            ->assertJsonPath('data.0.driver.email', 'mobile.driver@demo.rajawali.test');
    }

    public function test_demo_seeder_refuses_non_local_environments(): void
    {
        config(['app.env' => 'production']);

        $this->expectException(LogicException::class);
        $this->seed(DemoSeeder::class);
    }
}
