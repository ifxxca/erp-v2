<?php

namespace App\Modules\FleetMaintenance\Application;

use App\Models\ChecklistTemplate;
use App\Models\Company;
use App\Models\Location;
use App\Models\User;
use App\Models\Vehicle;
use App\Models\VehicleTrip;
use App\Modules\Identity\Application\AuditLogger;
use App\Modules\Identity\Application\EffectivePermissionResolver;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class VehicleTripService
{
    public function __construct(
        private readonly AuditLogger $audit,
        private readonly EffectivePermissionResolver $permissions,
    ) {}

    /** @param array<string, mixed> $attributes */
    public function checkout(
        Company $company,
        Location $location,
        User $actor,
        array $attributes,
        Request $request,
    ): VehicleTrip {
        try {
            return DB::transaction(function () use ($company, $location, $actor, $attributes, $request): VehicleTrip {
                $vehicle = Vehicle::query()->lockForUpdate()->findOrFail($attributes['vehicle_id']);
                if ($vehicle->company_id !== $company->id || $vehicle->location_id !== $location->id) {
                    abort(404);
                }
                if ($vehicle->operational_status !== 'available') {
                    throw new FleetMaintenanceException(
                        'Vehicle is not available for checkout.',
                        'VEHICLE_NOT_AVAILABLE',
                        409,
                    );
                }
                if ((int) $attributes['start_odometer'] < $vehicle->current_odometer) {
                    throw new FleetMaintenanceException(
                        'Checkout odometer cannot be lower than the current vehicle odometer.',
                        'VEHICLE_ODOMETER_REGRESSION',
                        409,
                    );
                }
                if (VehicleTrip::query()->where('driver_id', $actor->id)->where('status', 'active')->exists()) {
                    throw new FleetMaintenanceException(
                        'Driver already has an active vehicle trip.',
                        'DRIVER_ACTIVE_TRIP_CONFLICT',
                        409,
                    );
                }

                $template = ChecklistTemplate::query()
                    ->with('items')
                    ->where('company_id', $company->id)
                    ->where('code', 'VEHICLE_PRE_DEPARTURE')
                    ->where('status', 'active')
                    ->orderByDesc('version')
                    ->first();
                if (! $template) {
                    throw new FleetMaintenanceException(
                        'No active pre-departure checklist is configured for this company.',
                        'CHECKLIST_TEMPLATE_NOT_CONFIGURED',
                        409,
                    );
                }

                $answers = collect($attributes['answers'])->keyBy('item_id');
                $requiredIds = $template->items->where('is_required', true)->modelKeys();
                if (collect($requiredIds)->diff($answers->keys())->isNotEmpty()) {
                    throw new FleetMaintenanceException(
                        'Every required checklist item must be answered.',
                        'CHECKLIST_REQUIRED_ANSWER_MISSING',
                    );
                }
                if ($answers->keys()->diff($template->items->modelKeys())->isNotEmpty()) {
                    throw new FleetMaintenanceException(
                        'Checklist contains an item outside the active template.',
                        'CHECKLIST_ITEM_INVALID',
                    );
                }
                $criticalFailure = $template->items->where('is_critical', true)->first(
                    fn ($item): bool => ($answers->get($item->id)['result'] ?? null) !== 'pass',
                );
                if ($criticalFailure) {
                    throw new FleetMaintenanceException(
                        "Critical checklist item '{$criticalFailure->label}' must pass before checkout.",
                        'CHECKLIST_CRITICAL_ITEM_FAILED',
                        409,
                    );
                }

                $departedAt = isset($attributes['departed_at']) ? Carbon::parse($attributes['departed_at']) : now();
                $trip = VehicleTrip::query()->create([
                    'company_id' => $company->id,
                    'location_id' => $location->id,
                    'vehicle_id' => $vehicle->id,
                    'driver_id' => $actor->id,
                    'status' => 'active',
                    'purpose' => $attributes['purpose'],
                    'destination' => $attributes['destination'] ?? null,
                    'start_odometer' => $attributes['start_odometer'],
                    'departed_at' => $departedAt,
                    'active_vehicle_key' => $vehicle->id,
                    'active_driver_key' => $actor->id,
                ]);
                $submission = $trip->checklist()->create([
                    'checklist_template_id' => $template->id,
                    'submitted_by' => $actor->id,
                    'submitted_at' => $departedAt,
                ]);
                foreach ($template->items as $item) {
                    if ($answer = $answers->get($item->id)) {
                        $submission->answers()->create([
                            'checklist_template_item_id' => $item->id,
                            'result' => $answer['result'],
                            'note' => $answer['note'] ?? null,
                        ]);
                    }
                }

                $this->setVehicleStatus($vehicle, 'in_use', "Checked out for trip {$trip->id}.", $actor);
                $vehicle->update(['current_odometer' => $attributes['start_odometer']]);
                $this->audit->record('fleet.vehicle_checked_out', $actor, $trip, [
                    'company_id' => $company->id,
                    'location_id' => $location->id,
                    'vehicle_id' => $vehicle->id,
                    'start_odometer' => (int) $attributes['start_odometer'],
                    'checklist_template_id' => $template->id,
                ], $request);

                return $this->load($trip);
            });
        } catch (QueryException $exception) {
            if (in_array($exception->getCode(), ['23000', '23505'], true)) {
                throw new FleetMaintenanceException(
                    'Vehicle or driver already has an active trip.',
                    'ACTIVE_TRIP_CONFLICT',
                    409,
                );
            }
            throw $exception;
        }
    }

    /** @param array<string, mixed> $attributes */
    public function checkIn(VehicleTrip $trip, User $actor, array $attributes, Request $request): VehicleTrip
    {
        return DB::transaction(function () use ($trip, $actor, $attributes, $request): VehicleTrip {
            $locked = VehicleTrip::query()->lockForUpdate()->findOrFail($trip->id);
            $vehicle = Vehicle::query()->lockForUpdate()->findOrFail($locked->vehicle_id);
            $this->assertMayOperate($locked, $actor);
            if ($locked->status !== 'active') {
                throw new FleetMaintenanceException('Only an active trip can be checked in.', 'VEHICLE_TRIP_NOT_ACTIVE', 409);
            }
            if ((int) $attributes['end_odometer'] < $locked->start_odometer
                || (int) $attributes['end_odometer'] < $vehicle->current_odometer) {
                throw new FleetMaintenanceException(
                    'Check-in odometer cannot be lower than the trip or vehicle odometer.',
                    'VEHICLE_ODOMETER_REGRESSION',
                    409,
                );
            }
            $arrivedAt = isset($attributes['arrived_at']) ? Carbon::parse($attributes['arrived_at']) : now();
            if ($arrivedAt->lt($locked->departed_at)) {
                throw new FleetMaintenanceException(
                    'Check-in time cannot be earlier than checkout time.',
                    'VEHICLE_TRIP_TIME_INVALID',
                );
            }

            $locked->update([
                'status' => 'completed',
                'end_odometer' => $attributes['end_odometer'],
                'arrived_at' => $arrivedAt,
                'completion_note' => $attributes['note'] ?? null,
                'active_vehicle_key' => null,
                'active_driver_key' => null,
            ]);
            $vehicle->update(['current_odometer' => $attributes['end_odometer']]);
            $this->setVehicleStatus($vehicle, 'available', "Trip {$locked->id} checked in.", $actor);
            $this->audit->record('fleet.vehicle_checked_in', $actor, $locked, [
                'vehicle_id' => $vehicle->id,
                'start_odometer' => $locked->start_odometer,
                'end_odometer' => (int) $attributes['end_odometer'],
            ], $request);

            return $this->load($locked);
        });
    }

    public function cancel(VehicleTrip $trip, User $actor, string $reason, Request $request): VehicleTrip
    {
        return DB::transaction(function () use ($trip, $actor, $reason, $request): VehicleTrip {
            $locked = VehicleTrip::query()->lockForUpdate()->findOrFail($trip->id);
            $vehicle = Vehicle::query()->lockForUpdate()->findOrFail($locked->vehicle_id);
            if ($locked->status !== 'active') {
                throw new FleetMaintenanceException('Only an active trip can be cancelled.', 'VEHICLE_TRIP_NOT_ACTIVE', 409);
            }
            $locked->update([
                'status' => 'cancelled',
                'cancelled_at' => now(),
                'cancel_reason' => $reason,
                'active_vehicle_key' => null,
                'active_driver_key' => null,
            ]);
            $this->setVehicleStatus($vehicle, 'available', "Trip {$locked->id} cancelled: {$reason}", $actor);
            $this->audit->record('fleet.vehicle_trip_cancelled', $actor, $locked, [
                'vehicle_id' => $vehicle->id,
                'reason' => $reason,
            ], $request);

            return $this->load($locked);
        });
    }

    private function assertMayOperate(VehicleTrip $trip, User $actor): void
    {
        if ($trip->driver_id === $actor->id || $this->permissions->allows(
            $actor,
            'fleet.trip.manage',
            $trip->company_id,
            locationId: $trip->location_id,
        )) {
            return;
        }

        throw new FleetMaintenanceException('Only the assigned driver may check in this trip.', 'VEHICLE_TRIP_DRIVER_MISMATCH', 403);
    }

    private function setVehicleStatus(Vehicle $vehicle, string $target, string $reason, User $actor): void
    {
        $from = $vehicle->operational_status;
        $vehicle->update(['operational_status' => $target, 'status_reason' => $reason]);
        $vehicle->statusHistory()->create([
            'from_status' => $from,
            'to_status' => $target,
            'reason' => $reason,
            'changed_by' => $actor->id,
            'changed_at' => now(),
        ]);
    }

    private function load(VehicleTrip $trip): VehicleTrip
    {
        return $trip->load([
            'vehicle.type:id,code,name',
            'driver:id,name,email',
            'checklist.template.items',
            'checklist.answers.item',
        ]);
    }
}
