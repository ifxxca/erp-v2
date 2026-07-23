<?php

namespace Database\Seeders;

use App\Models\ChecklistSubmission;
use App\Models\ChecklistTemplate;
use App\Models\Company;
use App\Models\Department;
use App\Models\Location;
use App\Models\MaintenanceWorkOrder;
use App\Models\Role;
use App\Models\User;
use App\Models\UserCompanyMembership;
use App\Models\UserDepartmentMembership;
use App\Models\UserLocationMembership;
use App\Models\UserMfaMethod;
use App\Models\UserRoleAssignment;
use App\Models\Vehicle;
use App\Models\VehicleTrip;
use App\Models\VehicleType;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use InvalidArgumentException;
use LogicException;

class DemoSeeder extends Seeder
{
    private const ADMIN_EMAIL = 'erp.admin@demo.rajawali.test';

    private const MANAGER_EMAIL = 'ops.manager@demo.rajawali.test';

    private const DRIVER_EMAIL = 'mobile.driver@demo.rajawali.test';

    private const ACTIVE_TRIP_PURPOSE = '[DEMO] Pengiriman retail Jakarta Barat';

    private const COMPLETED_TRIP_PURPOSE = '[DEMO] Pengiriman retail Tangerang';

    public function run(): void
    {
        if (! in_array((string) config('app.env'), ['local', 'testing'], true)) {
            throw new LogicException('DemoSeeder may only run in local or testing environments.');
        }

        $password = (string) config('demo.password');
        $totpSecret = (string) config('demo.totp_secret');
        if (mb_strlen($password) < 12) {
            throw new InvalidArgumentException('DEMO_SEED_PASSWORD must contain at least 12 characters.');
        }
        if (preg_match('/^[A-Z2-7]{32}$/', $totpSecret) !== 1) {
            throw new InvalidArgumentException('DEMO_SEED_TOTP_SECRET must be a 32-character Base32 secret.');
        }

        $this->call(FoundationSeeder::class);

        DB::transaction(function () use ($password, $totpSecret): void {
            $company = Company::query()->where('code', 'RKS')->firstOrFail();
            $location = Location::query()
                ->where('company_id', $company->id)
                ->where('code', 'KRESEK')
                ->firstOrFail();

            $admin = $this->user(
                self::ADMIN_EMAIL,
                'Demo ERP Administrator',
                'DEMO-ERP-001',
                $password,
                $company,
                $location,
                Department::query()->where('company_id', $company->id)->where('code', 'IT')->firstOrFail(),
            );
            $manager = $this->user(
                self::MANAGER_EMAIL,
                'Demo Fleet Manager',
                'DEMO-OPS-001',
                $password,
                $company,
                $location,
                Department::query()->where('company_id', $company->id)->where('code', 'OPERATION_EXCELLENCE')->firstOrFail(),
            );
            $driver = $this->user(
                self::DRIVER_EMAIL,
                'Demo Mobile Driver',
                'DEMO-MOB-001',
                $password,
                $company,
                $location,
                Department::query()->where('company_id', $company->id)->where('code', 'DELIVERY')->firstOrFail(),
            );

            $this->assignRole($admin, 'platform-admin', $admin);
            $this->assignRole($manager, 'fleet-manager', $admin, $company, $location);
            $this->assignRole($manager, 'maintenance-officer', $admin, $company, $location);
            $this->assignRole($driver, 'ops-driver', $admin, $company, $location);

            UserMfaMethod::query()->updateOrCreate(
                ['user_id' => $admin->id, 'type' => 'totp'],
                [
                    'secret' => $totpSecret,
                    'status' => 'active',
                    'last_used_timestep' => null,
                    'confirmed_at' => now(),
                    'disabled_at' => null,
                ],
            );
            $admin->mfaRecoveryCodes()->delete();

            $this->resetSessions($admin);
            $this->resetSessions($manager);
            $this->resetSessions($driver);
            $this->fleetData($company, $location, $manager, $driver);
        });
    }

    private function user(
        string $email,
        string $name,
        string $employeeNumber,
        string $password,
        Company $company,
        Location $location,
        Department $department,
    ): User {
        $user = User::query()->updateOrCreate(
            ['email' => $email],
            [
                'name' => $name,
                'password' => $password,
                'status' => 'active',
            ],
        );
        $user->forceFill(['email_verified_at' => now()])->save();
        UserCompanyMembership::query()->updateOrCreate(
            ['user_id' => $user->id, 'company_id' => $company->id],
            [
                'employee_no' => $employeeNumber,
                'employment_status' => 'active',
                'is_primary' => true,
                'valid_from' => '2020-01-01',
                'valid_until' => null,
            ],
        );
        UserDepartmentMembership::query()->updateOrCreate(
            ['user_id' => $user->id, 'company_id' => $company->id, 'department_id' => $department->id],
            ['is_primary' => true, 'valid_from' => '2020-01-01', 'valid_until' => null],
        );
        UserLocationMembership::query()->updateOrCreate(
            [
                'user_id' => $user->id,
                'company_id' => $company->id,
                'location_id' => $location->id,
                'valid_from' => '2020-01-01',
            ],
            ['valid_until' => null],
        );

        return $user;
    }

    private function assignRole(
        User $user,
        string $roleCode,
        User $assigner,
        ?Company $company = null,
        ?Location $location = null,
    ): void {
        $role = Role::query()->where('code', $roleCode)->firstOrFail();
        UserRoleAssignment::query()->updateOrCreate(
            [
                'user_id' => $user->id,
                'role_id' => $role->id,
                'company_id' => $company?->id,
                'department_id' => null,
                'location_id' => $location?->id,
            ],
            [
                'access_request_id' => null,
                'valid_from' => '2020-01-01 00:00:00',
                'valid_until' => null,
                'assigned_by' => $assigner->id,
                'revoked_at' => null,
                'revoked_by' => null,
                'revocation_reason' => null,
            ],
        );
    }

    private function resetSessions(User $user): void
    {
        $user->tokens()->delete();
        $user->mobileRefreshTokenFamilies()->delete();
    }

    private function fleetData(Company $company, Location $location, User $manager, User $driver): void
    {
        $truckType = VehicleType::query()->updateOrCreate(
            ['company_id' => $company->id, 'code' => 'DEMO-LIGHT-TRUCK'],
            ['name' => 'Demo Light Truck', 'status' => 'active'],
        );
        $vanType = VehicleType::query()->updateOrCreate(
            ['company_id' => $company->id, 'code' => 'DEMO-VAN'],
            ['name' => 'Demo Delivery Van', 'status' => 'active'],
        );

        $activeVehicle = $this->vehicle(
            $company,
            $location,
            $truckType,
            $manager,
            'DEMO-TRUCK-01',
            'B 9001 RKS',
            'Mitsubishi',
            'Canter FE 74',
            2023,
            12500,
            'in_use',
        );
        $availableVehicle = $this->vehicle(
            $company,
            $location,
            $vanType,
            $manager,
            'DEMO-VAN-01',
            'B 9002 RKS',
            'Toyota',
            'HiAce Premio',
            2024,
            8400,
            'available',
        );
        $maintenanceVehicle = $this->vehicle(
            $company,
            $location,
            $truckType,
            $manager,
            'DEMO-TRUCK-02',
            'B 9003 RKS',
            'Isuzu',
            'NMR 71',
            2022,
            44100,
            'maintenance',
        );

        VehicleTrip::query()
            ->where('status', 'active')
            ->where(fn ($query) => $query
                ->where('driver_id', $driver->id)
                ->orWhere('vehicle_id', $activeVehicle->id))
            ->update([
                'status' => 'cancelled',
                'cancelled_at' => now(),
                'cancel_reason' => '[DEMO] Reset by DemoSeeder.',
                'active_vehicle_key' => null,
                'active_driver_key' => null,
            ]);

        $template = ChecklistTemplate::query()
            ->with('items')
            ->where('company_id', $company->id)
            ->where('code', 'VEHICLE_PRE_DEPARTURE')
            ->where('status', 'active')
            ->orderByDesc('version')
            ->firstOrFail();
        $activeTrip = VehicleTrip::query()->updateOrCreate(
            [
                'company_id' => $company->id,
                'driver_id' => $driver->id,
                'purpose' => self::ACTIVE_TRIP_PURPOSE,
            ],
            [
                'location_id' => $location->id,
                'vehicle_id' => $activeVehicle->id,
                'status' => 'active',
                'destination' => 'Jakarta Barat',
                'start_odometer' => 12500,
                'end_odometer' => null,
                'departed_at' => now()->subHour(),
                'arrived_at' => null,
                'cancelled_at' => null,
                'completion_note' => null,
                'cancel_reason' => null,
                'active_vehicle_key' => $activeVehicle->id,
                'active_driver_key' => $driver->id,
            ],
        );
        $completedTrip = VehicleTrip::query()->updateOrCreate(
            [
                'company_id' => $company->id,
                'driver_id' => $driver->id,
                'purpose' => self::COMPLETED_TRIP_PURPOSE,
            ],
            [
                'location_id' => $location->id,
                'vehicle_id' => $availableVehicle->id,
                'status' => 'completed',
                'destination' => 'Tangerang',
                'start_odometer' => 8300,
                'end_odometer' => 8400,
                'departed_at' => now()->subDays(2)->setTime(8, 0),
                'arrived_at' => now()->subDays(2)->setTime(12, 30),
                'cancelled_at' => null,
                'completion_note' => 'Pengiriman selesai tanpa kendala.',
                'cancel_reason' => null,
                'active_vehicle_key' => null,
                'active_driver_key' => null,
            ],
        );
        $this->checklist($activeTrip, $template, $driver, 'Semua pemeriksaan aman sebelum berangkat.');
        $this->checklist($completedTrip, $template, $driver, 'Pemeriksaan historis demo.');

        $workOrder = MaintenanceWorkOrder::query()->updateOrCreate(
            [
                'company_id' => $company->id,
                'vehicle_id' => $maintenanceVehicle->id,
                'problem_description' => '[DEMO] Rem bergetar dan perlu inspeksi berkala.',
            ],
            [
                'location_id' => $location->id,
                'document_number' => 'DEMO-WO-001',
                'work_order_date' => today(),
                'priority' => 'high',
                'status' => 'in_progress',
                'completion_note' => null,
                'labor_cost' => 350000,
                'parts_cost' => 650000,
                'total_cost' => 1000000,
                'created_by' => $manager->id,
                'completed_by' => null,
                'scheduled_at' => now()->subDay(),
                'started_at' => now()->subHours(3),
                'completed_at' => null,
                'cancelled_at' => null,
            ],
        );
        $workOrder->jobs()->updateOrCreate(
            ['line_number' => 1],
            [
                'description' => 'Inspeksi sistem rem depan dan belakang',
                'status' => 'in_progress',
                'labor_cost' => 200000,
                'note' => 'Periksa kampas, cakram, dan minyak rem.',
            ],
        );
        $workOrder->jobs()->updateOrCreate(
            ['line_number' => 2],
            [
                'description' => 'Penggantian komponen rem yang aus',
                'status' => 'pending',
                'labor_cost' => 150000,
                'note' => null,
            ],
        );
    }

    private function vehicle(
        Company $company,
        Location $location,
        VehicleType $type,
        User $creator,
        string $code,
        string $plateNumber,
        string $brand,
        string $model,
        int $modelYear,
        int $odometer,
        string $status,
    ): Vehicle {
        $vehicle = Vehicle::query()->updateOrCreate(
            ['company_id' => $company->id, 'code' => $code],
            [
                'location_id' => $location->id,
                'vehicle_type_id' => $type->id,
                'plate_number' => $plateNumber,
                'brand' => $brand,
                'model' => $model,
                'model_year' => $modelYear,
                'ownership_type' => 'owned',
                'provider_name' => null,
                'current_odometer' => $odometer,
                'operational_status' => $status,
                'status_reason' => '[DEMO] State managed by DemoSeeder.',
                'legacy_source_id' => null,
                'created_by' => $creator->id,
            ],
        );
        $vehicle->statusHistory()->updateOrCreate(
            ['reason' => '[DEMO] State managed by DemoSeeder.'],
            [
                'from_status' => null,
                'to_status' => $status,
                'changed_by' => $creator->id,
                'changed_at' => now(),
            ],
        );

        return $vehicle;
    }

    private function checklist(
        VehicleTrip $trip,
        ChecklistTemplate $template,
        User $driver,
        string $note,
    ): void {
        $submission = ChecklistSubmission::query()->updateOrCreate(
            ['vehicle_trip_id' => $trip->id],
            [
                'checklist_template_id' => $template->id,
                'submitted_by' => $driver->id,
                'submitted_at' => $trip->departed_at,
            ],
        );
        foreach ($template->items as $item) {
            $submission->answers()->updateOrCreate(
                ['checklist_template_item_id' => $item->id],
                [
                    'result' => 'pass',
                    'note' => $item->line_number === 1 ? $note : null,
                ],
            );
        }
    }
}
