<?php

namespace Tests\Feature;

use App\Models\ChecklistTemplate;
use App\Models\Company;
use App\Models\FileAsset;
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

class VehicleTripApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_driver_checks_out_with_complete_checklist_and_checks_in_with_monotonic_odometer(): void
    {
        [$company, $location, $driver] = $this->actor(['fleet.trip.view', 'fleet.trip.operate']);
        $template = $this->template($company);
        $vehicle = $this->vehicle($company, $location, $driver);
        $evidence = $this->evidence($company, $driver);
        Sanctum::actingAs($driver);

        $answers = $this->answers($template);
        $answers[0]['evidence_file_ids'] = [$evidence->id];

        $created = $this->postJson($this->base($company, $location).'/fleet/trips/checkout', [
            'vehicle_id' => $vehicle->id,
            'purpose' => 'Delivery retail route A',
            'destination' => 'Tangerang',
            'start_odometer' => 1010,
            'answers' => $answers,
        ])->assertCreated()
            ->assertJsonPath('data.status', 'active')
            ->assertJsonPath('data.driver.id', $driver->id)
            ->assertJsonCount(6, 'data.checklist.answers')
            ->assertJsonPath('data.checklist.answers.0.evidence_files.0.id', $evidence->id)
            ->assertJsonMissingPath('data.checklist.answers.0.evidence_files.0.object_key');
        $tripId = $created->json('data.id');

        $this->assertDatabaseHas('vehicles', [
            'id' => $vehicle->id,
            'operational_status' => 'in_use',
            'current_odometer' => 1010,
        ]);
        $this->assertDatabaseHas('audit_logs', ['event' => 'fleet.vehicle_checked_out', 'subject_id' => $tripId]);
        $this->assertDatabaseHas('files', [
            'id' => $evidence->id,
            'attached_type' => 'checklist_answer',
        ]);

        $this->postJson($this->base($company, $location)."/fleet/trips/{$tripId}/check-in", [
            'end_odometer' => 1075,
            'note' => 'Vehicle returned without incident.',
        ])->assertOk()
            ->assertJsonPath('data.status', 'completed')
            ->assertJsonPath('data.end_odometer', 1075);

        $this->assertDatabaseHas('vehicles', [
            'id' => $vehicle->id,
            'operational_status' => 'available',
            'current_odometer' => 1075,
        ]);
        $this->assertDatabaseHas('vehicle_trips', [
            'id' => $tripId,
            'active_vehicle_key' => null,
            'active_driver_key' => null,
        ]);
        $this->assertDatabaseHas('audit_logs', ['event' => 'fleet.vehicle_checked_in', 'subject_id' => $tripId]);
    }

    public function test_checkout_rejects_incomplete_or_critical_checklist_and_odometer_regression_atomically(): void
    {
        [$company, $location, $driver] = $this->actor(['fleet.trip.view', 'fleet.trip.operate']);
        $template = $this->template($company);
        $vehicle = $this->vehicle($company, $location, $driver);
        Sanctum::actingAs($driver);
        $url = $this->base($company, $location).'/fleet/trips/checkout';
        $payload = [
            'vehicle_id' => $vehicle->id,
            'purpose' => 'Delivery',
            'start_odometer' => 1000,
            'answers' => $this->answers($template),
        ];

        $missing = $payload;
        array_pop($missing['answers']);
        $this->postJson($url, $missing)
            ->assertUnprocessable()
            ->assertJsonPath('code', 'CHECKLIST_REQUIRED_ANSWER_MISSING');

        $failed = $payload;
        $failed['answers'][1]['result'] = 'fail';
        $this->postJson($url, $failed)
            ->assertConflict()
            ->assertJsonPath('code', 'CHECKLIST_CRITICAL_ITEM_FAILED');

        $regressed = $payload;
        $regressed['start_odometer'] = 999;
        $this->postJson($url, $regressed)
            ->assertConflict()
            ->assertJsonPath('code', 'VEHICLE_ODOMETER_REGRESSION');

        $unscanned = $this->evidence($company, $driver, 'quarantined');
        $withUnscannedEvidence = $payload;
        $withUnscannedEvidence['answers'][0]['evidence_file_ids'] = [$unscanned->id];
        $this->postJson($url, $withUnscannedEvidence)
            ->assertConflict()
            ->assertJsonPath('code', 'CHECKLIST_EVIDENCE_NOT_READY');

        $wrongPurpose = $this->evidence($company, $driver);
        $wrongPurpose->update(['purpose' => 'work_order_attachment']);
        $withWrongPurpose = $payload;
        $withWrongPurpose['answers'][0]['evidence_file_ids'] = [$wrongPurpose->id];
        $this->postJson($url, $withWrongPurpose)
            ->assertUnprocessable()
            ->assertJsonPath('code', 'CHECKLIST_EVIDENCE_INVALID');

        $duplicate = $this->evidence($company, $driver);
        $withDuplicateEvidence = $payload;
        $withDuplicateEvidence['answers'][0]['evidence_file_ids'] = [$duplicate->id];
        $withDuplicateEvidence['answers'][1]['evidence_file_ids'] = [$duplicate->id];
        $this->postJson($url, $withDuplicateEvidence)
            ->assertUnprocessable()
            ->assertJsonPath('code', 'VALIDATION_FAILED');

        $this->assertDatabaseCount('vehicle_trips', 0);
        $this->assertDatabaseHas('vehicles', ['id' => $vehicle->id, 'operational_status' => 'available', 'current_odometer' => 1000]);
        $this->assertDatabaseHas('files', ['id' => $unscanned->id, 'attached_id' => null]);
    }

    public function test_active_trip_guards_driver_and_vehicle_and_manager_can_cancel(): void
    {
        [$company, $location, $driver] = $this->actor([
            'fleet.trip.view', 'fleet.trip.operate', 'fleet.trip.manage', 'fleet.vehicle.manage',
        ]);
        $template = $this->template($company);
        $first = $this->vehicle($company, $location, $driver, 'FLT-001', 'B 1234 XYZ');
        $second = $this->vehicle($company, $location, $driver, 'FLT-002', 'B 5678 XYZ');
        Sanctum::actingAs($driver);
        $url = $this->base($company, $location).'/fleet/trips/checkout';
        $payload = [
            'vehicle_id' => $first->id,
            'purpose' => 'Delivery',
            'start_odometer' => 1000,
            'answers' => $this->answers($template),
        ];
        $tripId = $this->postJson($url, $payload)->assertCreated()->json('data.id');

        $this->postJson($this->base($company, $location)."/fleet/vehicles/{$first->id}/status", [
            'status' => 'blocked',
            'reason' => 'Attempted manual override during trip.',
        ])->assertConflict()->assertJsonPath('code', 'VEHICLE_ACTIVE_TRIP');
        $this->postJson($url, [...$payload, 'vehicle_id' => $second->id])
            ->assertConflict()
            ->assertJsonPath('code', 'DRIVER_ACTIVE_TRIP_CONFLICT');
        $this->postJson($this->base($company, $location)."/fleet/trips/{$tripId}/cancel", [
            'reason' => 'Route assignment changed before departure.',
        ])->assertOk()->assertJsonPath('data.status', 'cancelled');

        $this->assertDatabaseHas('vehicles', ['id' => $first->id, 'operational_status' => 'available']);
        $this->postJson($url, [...$payload, 'vehicle_id' => $second->id])->assertCreated();
    }

    public function test_non_manager_cannot_read_or_check_in_another_drivers_trip(): void
    {
        [$company, $location, $driver] = $this->actor(['fleet.trip.view', 'fleet.trip.operate']);
        $template = $this->template($company);
        $vehicle = $this->vehicle($company, $location, $driver);
        Sanctum::actingAs($driver);
        $tripId = $this->postJson($this->base($company, $location).'/fleet/trips/checkout', [
            'vehicle_id' => $vehicle->id,
            'purpose' => 'Delivery',
            'start_odometer' => 1000,
            'answers' => $this->answers($template),
        ])->assertCreated()->json('data.id');

        $otherDriver = $this->secondDriver($company, $location);
        Sanctum::actingAs($otherDriver);
        $tripUrl = $this->base($company, $location)."/fleet/trips/{$tripId}";
        $this->getJson($tripUrl)->assertNotFound();
        $this->postJson($tripUrl.'/check-in', ['end_odometer' => 1010])->assertNotFound();
        $this->getJson($this->base($company, $location).'/fleet/trips')
            ->assertOk()
            ->assertJsonPath('total', 0);
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
            'user_id' => $user->id, 'company_id' => $company->id, 'employment_status' => 'active',
            'is_primary' => true, 'valid_from' => today(),
        ]);
        UserLocationMembership::query()->create([
            'user_id' => $user->id, 'company_id' => $company->id, 'location_id' => $location->id,
            'valid_from' => today(),
        ]);
        $role = Role::query()->create([
            'code' => 'trip-role', 'name' => 'Trip Role', 'assignment_scope' => 'location',
        ]);
        foreach ($permissions as $code) {
            $parts = explode('.', $code);
            $permission = Permission::query()->create([
                'code' => $code, 'module' => $parts[0], 'resource' => $parts[1], 'action' => $parts[2],
            ]);
            $role->permissions()->attach($permission);
        }
        UserRoleAssignment::query()->create([
            'user_id' => $user->id, 'role_id' => $role->id, 'company_id' => $company->id,
            'location_id' => $location->id, 'valid_from' => now(), 'assigned_by' => $user->id,
        ]);

        return [$company, $location, $user];
    }

    private function template(Company $company): ChecklistTemplate
    {
        $template = ChecklistTemplate::query()->create([
            'company_id' => $company->id,
            'code' => 'VEHICLE_PRE_DEPARTURE',
            'name' => 'Pre-departure Vehicle Safety',
            'version' => 1,
            'status' => 'active',
        ]);
        foreach ([
            ['BODY', false], ['FRONT_LIGHTS', true], ['REAR_LIGHTS', true], ['TIRES', true],
            ['SPARE_TIRE', false], ['WINDSHIELD', true],
        ] as $index => [$code, $critical]) {
            $template->items()->create([
                'line_number' => $index + 1,
                'code' => $code,
                'label' => str_replace('_', ' ', $code),
                'is_required' => true,
                'is_critical' => $critical,
            ]);
        }

        return $template->load('items');
    }

    private function secondDriver(Company $company, Location $location): User
    {
        $user = User::factory()->create();
        UserCompanyMembership::query()->create([
            'user_id' => $user->id, 'company_id' => $company->id, 'employment_status' => 'active',
            'is_primary' => false, 'valid_from' => today(),
        ]);
        UserLocationMembership::query()->create([
            'user_id' => $user->id, 'company_id' => $company->id, 'location_id' => $location->id,
            'valid_from' => today(),
        ]);
        UserRoleAssignment::query()->create([
            'user_id' => $user->id,
            'role_id' => Role::query()->where('code', 'trip-role')->value('id'),
            'company_id' => $company->id,
            'location_id' => $location->id,
            'valid_from' => now(),
            'assigned_by' => $user->id,
        ]);

        return $user;
    }

    private function answers(ChecklistTemplate $template): array
    {
        return $template->items->map(fn ($item): array => [
            'item_id' => $item->id,
            'result' => 'pass',
            'note' => null,
        ])->all();
    }

    private function evidence(Company $company, User $creator, string $status = 'ready'): FileAsset
    {
        $checksum = hash('sha256', 'checklist evidence');

        return FileAsset::query()->create([
            'company_id' => $company->id,
            'created_by' => $creator->id,
            'purpose' => 'checklist_evidence',
            'original_name' => 'vehicle-front.jpg',
            'disk' => 'local',
            'object_key' => "companies/{$company->id}/files/".str()->ulid(),
            'declared_mime_type' => 'image/jpeg',
            'detected_mime_type' => 'image/jpeg',
            'expected_size' => 18,
            'actual_size' => 18,
            'expected_checksum_sha256' => $checksum,
            'actual_checksum_sha256' => $checksum,
            'status' => $status,
            'scan_status' => $status === 'ready' ? 'clean' : 'pending',
            'pending_expires_at' => now()->addDay(),
            'uploaded_at' => now(),
            'finalized_at' => $status === 'ready' ? now() : null,
        ]);
    }

    private function vehicle(
        Company $company,
        Location $location,
        User $creator,
        string $code = 'FLT-001',
        string $plate = 'B 1234 XYZ',
    ): Vehicle {
        $type = VehicleType::query()->firstOrCreate(
            ['company_id' => $company->id, 'code' => 'CDE'],
            ['name' => 'CDE'],
        );

        return Vehicle::query()->create([
            'company_id' => $company->id, 'location_id' => $location->id, 'vehicle_type_id' => $type->id,
            'code' => $code, 'plate_number' => $plate, 'brand' => 'Mitsubishi', 'model' => 'Canter',
            'ownership_type' => 'owned', 'current_odometer' => 1000, 'operational_status' => 'available',
            'created_by' => $creator->id,
        ]);
    }

    private function base(Company $company, Location $location): string
    {
        return "/api/v1/companies/{$company->id}/locations/{$location->id}";
    }
}
