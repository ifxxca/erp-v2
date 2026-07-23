<?php

namespace App\Modules\FleetMaintenance\Application;

use App\Models\Company;
use App\Models\Location;
use App\Models\MaintenanceWorkOrder;
use App\Models\User;
use App\Models\Vehicle;
use App\Models\VehicleType;
use App\Modules\Documents\Application\DocumentNumberingException;
use App\Modules\Documents\Application\DocumentNumberService;
use App\Modules\Identity\Application\AuditLogger;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class FleetMaintenanceService
{
    private const VEHICLE_TRANSITIONS = [
        'available' => ['in_use', 'maintenance', 'blocked', 'inactive'],
        'in_use' => ['available', 'maintenance', 'blocked'],
        'maintenance' => ['available', 'blocked', 'inactive'],
        'blocked' => ['available', 'maintenance', 'inactive'],
        'inactive' => ['available'],
    ];

    private const WORK_ORDER_TRANSITIONS = [
        'draft' => ['scheduled', 'cancelled'],
        'scheduled' => ['in_progress', 'cancelled'],
        'in_progress' => ['completed', 'cancelled'],
        'completed' => [],
        'cancelled' => [],
    ];

    public function __construct(
        private readonly AuditLogger $audit,
        private readonly DocumentNumberService $numbers,
    ) {}

    /** @param array{code: string, name: string} $attributes */
    public function createVehicleType(
        Company $company,
        User $actor,
        array $attributes,
        Request $request,
    ): VehicleType {
        return DB::transaction(function () use ($company, $actor, $attributes, $request): VehicleType {
            $type = VehicleType::query()->create([
                ...$attributes,
                'company_id' => $company->id,
                'status' => 'active',
            ]);
            $this->audit->record('fleet.vehicle_type_created', $actor, $type, [
                'company_id' => $company->id,
                'code' => $type->code,
            ], $request);

            return $type;
        });
    }

    /** @param array<string, mixed> $attributes */
    public function createVehicle(
        Company $company,
        Location $location,
        User $actor,
        array $attributes,
        Request $request,
    ): Vehicle {
        return DB::transaction(function () use ($company, $location, $actor, $attributes, $request): Vehicle {
            $vehicle = Vehicle::query()->create([
                ...$attributes,
                'company_id' => $company->id,
                'location_id' => $location->id,
                'operational_status' => 'available',
                'created_by' => $actor->id,
            ]);
            $vehicle->statusHistory()->create([
                'from_status' => null,
                'to_status' => 'available',
                'reason' => 'Vehicle registered.',
                'changed_by' => $actor->id,
                'changed_at' => now(),
            ]);
            $this->audit->record('fleet.vehicle_created', $actor, $vehicle, [
                'company_id' => $company->id,
                'location_id' => $location->id,
                'plate_number' => $vehicle->plate_number,
            ], $request);

            return $vehicle->load('type');
        });
    }

    public function changeVehicleStatus(
        Vehicle $vehicle,
        string $targetStatus,
        string $reason,
        User $actor,
        Request $request,
    ): Vehicle {
        return DB::transaction(function () use ($vehicle, $targetStatus, $reason, $actor, $request): Vehicle {
            $locked = Vehicle::query()->lockForUpdate()->findOrFail($vehicle->id);
            $from = $locked->operational_status;
            if (! in_array($targetStatus, self::VEHICLE_TRANSITIONS[$from] ?? [], true)) {
                throw new FleetMaintenanceException(
                    "Vehicle cannot transition from {$from} to {$targetStatus}.",
                    'VEHICLE_STATUS_TRANSITION_INVALID',
                    409,
                );
            }
            if ($targetStatus === 'available' && $locked->workOrders()->where('status', 'in_progress')->exists()) {
                throw new FleetMaintenanceException(
                    'Vehicle has an in-progress maintenance work order.',
                    'VEHICLE_MAINTENANCE_IN_PROGRESS',
                    409,
                );
            }

            $locked->update(['operational_status' => $targetStatus, 'status_reason' => $reason]);
            $locked->statusHistory()->create([
                'from_status' => $from,
                'to_status' => $targetStatus,
                'reason' => $reason,
                'changed_by' => $actor->id,
                'changed_at' => now(),
            ]);
            $this->audit->record('fleet.vehicle_status_changed', $actor, $locked, [
                'from_status' => $from,
                'to_status' => $targetStatus,
                'reason' => $reason,
            ], $request);

            return $locked->load('type');
        });
    }

    /** @param array<string, mixed> $attributes */
    public function createWorkOrder(
        Company $company,
        Location $location,
        User $actor,
        array $attributes,
        Request $request,
    ): MaintenanceWorkOrder {
        return DB::transaction(function () use ($company, $location, $actor, $attributes, $request): MaintenanceWorkOrder {
            $jobs = $attributes['jobs'];
            unset($attributes['jobs']);
            $laborCost = collect($jobs)->sum(fn (array $job): float => (float) ($job['labor_cost'] ?? 0));
            $workOrder = MaintenanceWorkOrder::query()->create([
                ...$attributes,
                'company_id' => $company->id,
                'location_id' => $location->id,
                'status' => 'draft',
                'labor_cost' => $laborCost,
                'total_cost' => $laborCost + (float) ($attributes['parts_cost'] ?? 0),
                'created_by' => $actor->id,
            ]);
            foreach ($jobs as $index => $job) {
                $workOrder->jobs()->create([...$job, 'line_number' => $index + 1, 'status' => 'pending']);
            }
            $this->audit->record('maintenance.work_order_created', $actor, $workOrder, [
                'company_id' => $company->id,
                'location_id' => $location->id,
                'vehicle_id' => $workOrder->vehicle_id,
                'job_count' => count($jobs),
            ], $request);

            return $workOrder->load(['vehicle.type', 'jobs']);
        });
    }

    public function transitionWorkOrder(
        MaintenanceWorkOrder $workOrder,
        string $targetStatus,
        ?string $note,
        User $actor,
        Request $request,
    ): MaintenanceWorkOrder {
        try {
            return DB::transaction(function () use ($workOrder, $targetStatus, $note, $actor, $request): MaintenanceWorkOrder {
                $locked = MaintenanceWorkOrder::query()->lockForUpdate()->findOrFail($workOrder->id);
                $vehicle = Vehicle::query()->lockForUpdate()->findOrFail($locked->vehicle_id);
                $from = $locked->status;
                if (! in_array($targetStatus, self::WORK_ORDER_TRANSITIONS[$from] ?? [], true)) {
                    throw new FleetMaintenanceException(
                        "Work order cannot transition from {$from} to {$targetStatus}.",
                        'WORK_ORDER_TRANSITION_INVALID',
                        409,
                    );
                }

                $changes = ['status' => $targetStatus];
                if ($targetStatus === 'scheduled') {
                    $allocation = $this->numbers->allocate(
                        $locked->company,
                        'maintenance.work_order',
                        'maintenance.work_order',
                        $locked->id,
                        $locked->work_order_date,
                        $locked->location,
                        $actor,
                        $request,
                    );
                    $changes += ['document_number' => $allocation->document_number, 'scheduled_at' => now()];
                } elseif ($targetStatus === 'in_progress') {
                    if (in_array($vehicle->operational_status, ['in_use', 'inactive'], true)) {
                        throw new FleetMaintenanceException(
                            'Vehicle is not available to enter maintenance.',
                            'VEHICLE_NOT_READY_FOR_MAINTENANCE',
                            409,
                        );
                    }
                    if (MaintenanceWorkOrder::query()->where('vehicle_id', $vehicle->id)
                        ->where('status', 'in_progress')->whereKeyNot($locked->id)->exists()) {
                        throw new FleetMaintenanceException(
                            'Another work order is already in progress for this vehicle.',
                            'WORK_ORDER_VEHICLE_CONFLICT',
                            409,
                        );
                    }
                    $changes['started_at'] = now();
                    $locked->jobs()->update(['status' => 'in_progress']);
                    $this->setVehicleStatus($vehicle, 'maintenance', "Work order {$locked->document_number} started.", $actor);
                } elseif ($targetStatus === 'completed') {
                    $changes += ['completion_note' => $note, 'completed_at' => now(), 'completed_by' => $actor->id];
                    $locked->jobs()->update(['status' => 'completed']);
                    $this->setVehicleStatus($vehicle, 'available', "Work order {$locked->document_number} completed.", $actor);
                } elseif ($targetStatus === 'cancelled') {
                    $changes += ['completion_note' => $note, 'cancelled_at' => now()];
                    $locked->jobs()->update(['status' => 'cancelled']);
                    if ($from === 'in_progress' && $vehicle->operational_status === 'maintenance') {
                        $this->setVehicleStatus($vehicle, 'available', "Work order {$locked->document_number} cancelled.", $actor);
                    }
                }

                $locked->update($changes);
                $this->audit->record('maintenance.work_order_status_changed', $actor, $locked, [
                    'from_status' => $from,
                    'to_status' => $targetStatus,
                    'note' => $note,
                ], $request);

                return $locked->load(['vehicle.type', 'jobs']);
            });
        } catch (DocumentNumberingException $exception) {
            throw new FleetMaintenanceException(
                'Official work-order numbering has not been configured for this company and date.',
                $exception->errorCode,
                409,
            );
        }
    }

    private function setVehicleStatus(Vehicle $vehicle, string $target, string $reason, User $actor): void
    {
        $from = $vehicle->operational_status;
        if ($from === $target) {
            return;
        }
        $vehicle->update(['operational_status' => $target, 'status_reason' => $reason]);
        $vehicle->statusHistory()->create([
            'from_status' => $from,
            'to_status' => $target,
            'reason' => $reason,
            'changed_by' => $actor->id,
            'changed_at' => now(),
        ]);
    }
}
