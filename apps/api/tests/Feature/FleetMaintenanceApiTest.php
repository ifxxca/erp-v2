<?php

namespace Tests\Feature;

use App\Models\Company;
use App\Models\DocumentSequenceRule;
use App\Models\Location;
use App\Models\Permission;
use App\Models\Role;
use App\Models\User;
use App\Models\UserCompanyMembership;
use App\Models\UserLocationMembership;
use App\Models\UserRoleAssignment;
use App\Models\Vehicle;
use App\Models\VehicleType;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class FleetMaintenanceApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_location_scoped_actor_can_register_and_list_vehicle_with_audited_initial_status(): void
    {
        [$company, $location, $actor] = $this->actor(['fleet.vehicle.view', 'fleet.vehicle.manage']);
        Sanctum::actingAs($actor);
        $typeId = $this->postJson($this->base($company, $location).'/fleet/vehicle-types', [
            'code' => 'CDE',
            'name' => 'Colt Diesel Engkel',
        ])->assertCreated()->json('data.id');

        $created = $this->postJson($this->base($company, $location).'/fleet/vehicles', [
            'vehicle_type_id' => $typeId,
            'code' => 'RKS-FLT-001',
            'plate_number' => 'b 1234 xyz',
            'brand' => 'Mitsubishi',
            'model' => 'Canter',
            'model_year' => 2024,
            'ownership_type' => 'owned',
            'current_odometer' => 12500,
        ])->assertCreated()
            ->assertJsonPath('data.plate_number', 'B 1234 XYZ')
            ->assertJsonPath('data.operational_status', 'available');

        $vehicleId = $created->json('data.id');
        $this->getJson($this->base($company, $location).'/fleet/vehicles')
            ->assertOk()
            ->assertJsonPath('total', 1)
            ->assertJsonPath('data.0.id', $vehicleId);
        $this->assertDatabaseHas('vehicle_status_histories', [
            'vehicle_id' => $vehicleId,
            'from_status' => null,
            'to_status' => 'available',
        ]);
        $this->assertDatabaseHas('audit_logs', ['event' => 'fleet.vehicle_created', 'subject_id' => $vehicleId]);
        $this->assertDatabaseHas('audit_logs', ['event' => 'fleet.vehicle_type_created', 'subject_id' => $typeId]);
    }

    public function test_work_order_lifecycle_allocates_number_and_synchronizes_vehicle_status(): void
    {
        [$company, $location, $actor] = $this->actor([
            'fleet.vehicle.view', 'maintenance.work-order.view', 'maintenance.work-order.manage',
        ]);
        $this->numberingRule($company, $location);
        $vehicle = $this->vehicle($company, $location, $actor);
        Sanctum::actingAs($actor);

        $created = $this->postJson($this->base($company, $location).'/maintenance/work-orders', [
            'vehicle_id' => $vehicle->id,
            'work_order_date' => '2026-07-23',
            'priority' => 'high',
            'problem_description' => 'Rem depan bergetar saat kendaraan berhenti.',
            'parts_cost' => 350000,
            'jobs' => [
                ['description' => 'Inspect front brake', 'labor_cost' => 150000],
                ['description' => 'Replace brake pad', 'labor_cost' => 100000],
            ],
        ])->assertCreated()
            ->assertJsonPath('data.status', 'draft')
            ->assertJsonPath('data.document_number', null)
            ->assertJsonPath('data.total_cost', '600000.00');
        $workOrderId = $created->json('data.id');
        $url = $this->base($company, $location)."/maintenance/work-orders/{$workOrderId}/transition";

        $this->postJson($url, ['status' => 'scheduled'])
            ->assertOk()
            ->assertJsonPath('data.status', 'scheduled')
            ->assertJsonPath('data.document_number', 'WO/RKS/KRESEK/2026/07/00001');
        $this->postJson($url, ['status' => 'in_progress'])
            ->assertOk()
            ->assertJsonPath('data.status', 'in_progress');
        $this->assertDatabaseHas('vehicles', ['id' => $vehicle->id, 'operational_status' => 'maintenance']);

        $this->postJson($url, ['status' => 'completed', 'note' => 'Road test passed and vehicle released.'])
            ->assertOk()
            ->assertJsonPath('data.status', 'completed')
            ->assertJsonPath('data.jobs.0.status', 'completed');
        $this->assertDatabaseHas('vehicles', ['id' => $vehicle->id, 'operational_status' => 'available']);
        $this->assertDatabaseCount('document_number_allocations', 1);
        $this->assertSame(2, Vehicle::query()->findOrFail($vehicle->id)->statusHistory()->count());
        $this->assertSame(3, \DB::table('audit_logs')->where('event', 'maintenance.work_order_status_changed')->count());
    }

    public function test_invalid_transitions_and_missing_numbering_policy_are_rejected_without_partial_state(): void
    {
        [$company, $location, $actor] = $this->actor(['maintenance.work-order.manage']);
        $vehicle = $this->vehicle($company, $location, $actor);
        Sanctum::actingAs($actor);
        $workOrderId = $this->postJson($this->base($company, $location).'/maintenance/work-orders', [
            'vehicle_id' => $vehicle->id,
            'work_order_date' => '2026-07-23',
            'priority' => 'normal',
            'problem_description' => 'Periodic inspection is required.',
            'jobs' => [['description' => 'Inspect vehicle', 'labor_cost' => 0]],
        ])->assertCreated()->json('data.id');
        $url = $this->base($company, $location)."/maintenance/work-orders/{$workOrderId}/transition";

        $this->postJson($url, ['status' => 'in_progress'])
            ->assertConflict()
            ->assertJsonPath('code', 'WORK_ORDER_TRANSITION_INVALID');
        $this->postJson($url, ['status' => 'scheduled'])
            ->assertConflict()
            ->assertJsonPath('code', 'DOCUMENT_SEQUENCE_RULE_NOT_FOUND');
        $this->assertDatabaseHas('maintenance_work_orders', [
            'id' => $workOrderId,
            'status' => 'draft',
            'document_number' => null,
        ]);
        $this->assertDatabaseCount('document_number_allocations', 0);
    }

    public function test_location_scope_and_cross_company_resources_do_not_leak(): void
    {
        [$company, $allowedLocation, $actor] = $this->actor(['fleet.vehicle.view']);
        $otherLocation = Location::query()->create([
            'company_id' => $company->id,
            'code' => 'OTHER',
            'name' => 'Other',
            'timezone' => 'Asia/Jakarta',
        ]);
        Sanctum::actingAs($actor);

        $this->getJson($this->base($company, $allowedLocation).'/fleet/vehicles')->assertOk();
        $this->getJson('/api/v1/operations/context')
            ->assertOk()
            ->assertJsonPath('data.0.location.id', $allowedLocation->id)
            ->assertJsonPath('data.0.capabilities.can_view_vehicles', true);
        $this->getJson($this->base($company, $otherLocation).'/fleet/vehicles')
            ->assertForbidden()
            ->assertJsonPath('code', 'PERMISSION_DENIED');

        $otherCompany = Company::query()->create(['code' => 'OTHER', 'legal_name' => 'Other Company']);
        $this->getJson($this->base($otherCompany, $allowedLocation).'/fleet/vehicles')
            ->assertForbidden()
            ->assertJsonPath('code', 'PERMISSION_DENIED');
    }

    /** @param array<int, string> $permissions */
    private function actor(array $permissions): array
    {
        $company = Company::query()->create(['code' => 'RKS', 'legal_name' => 'PT Rajawali Kreatif Sentosa']);
        $location = Location::query()->create([
            'company_id' => $company->id,
            'code' => 'KRESEK',
            'name' => 'Warehouse Kresek',
            'timezone' => 'Asia/Jakarta',
        ]);
        $user = User::factory()->create();
        UserCompanyMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'employment_status' => 'active',
            'is_primary' => true,
            'valid_from' => today(),
        ]);
        UserLocationMembership::query()->create([
            'user_id' => $user->id,
            'company_id' => $company->id,
            'location_id' => $location->id,
            'valid_from' => today(),
        ]);
        $role = Role::query()->create([
            'code' => 'fleet-role-'.Role::query()->count(),
            'name' => 'Fleet Role',
            'assignment_scope' => 'location',
        ]);
        foreach ($permissions as $code) {
            $parts = explode('.', $code);
            $permission = Permission::query()->create([
                'code' => $code,
                'module' => $parts[0],
                'resource' => $parts[1],
                'action' => $parts[2],
            ]);
            $role->permissions()->attach($permission);
        }
        UserRoleAssignment::query()->create([
            'user_id' => $user->id,
            'role_id' => $role->id,
            'company_id' => $company->id,
            'location_id' => $location->id,
            'valid_from' => now(),
            'assigned_by' => $user->id,
        ]);

        return [$company, $location, $user];
    }

    private function vehicle(Company $company, Location $location, User $creator): Vehicle
    {
        $type = VehicleType::query()->create(['company_id' => $company->id, 'code' => 'CDE', 'name' => 'CDE']);

        return Vehicle::query()->create([
            'company_id' => $company->id,
            'location_id' => $location->id,
            'vehicle_type_id' => $type->id,
            'code' => 'FLT-001',
            'plate_number' => 'B 1234 XYZ',
            'brand' => 'Mitsubishi',
            'model' => 'Canter',
            'ownership_type' => 'owned',
            'current_odometer' => 1000,
            'operational_status' => 'available',
            'created_by' => $creator->id,
        ]);
    }

    private function numberingRule(Company $company, Location $location): void
    {
        DocumentSequenceRule::query()->create([
            'company_id' => $company->id,
            'location_id' => $location->id,
            'document_type' => 'maintenance.work_order',
            'type_code' => 'WO',
            'version' => 1,
            'pattern' => '{TYPE}/{COMPANY}/{LOCATION}/{YYYY}/{MM}/{SEQ}',
            'period' => 'monthly',
            'padding' => 5,
            'timezone' => 'Asia/Jakarta',
            'effective_from' => '2020-01-01',
        ]);
    }

    private function base(Company $company, Location $location): string
    {
        return "/api/v1/companies/{$company->id}/locations/{$location->id}";
    }
}
