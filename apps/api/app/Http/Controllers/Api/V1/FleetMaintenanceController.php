<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\CancelVehicleTripRequest;
use App\Http\Requests\ChangeVehicleStatusRequest;
use App\Http\Requests\CheckInVehicleRequest;
use App\Http\Requests\CheckoutVehicleRequest;
use App\Http\Requests\CreateMaintenanceWorkOrderRequest;
use App\Http\Requests\CreateVehicleRequest;
use App\Http\Requests\CreateVehicleTypeRequest;
use App\Http\Requests\TransitionMaintenanceWorkOrderRequest;
use App\Models\ChecklistTemplate;
use App\Models\Company;
use App\Models\Location;
use App\Models\MaintenanceWorkOrder;
use App\Models\Vehicle;
use App\Models\VehicleTrip;
use App\Models\VehicleType;
use App\Modules\FleetMaintenance\Application\FleetMaintenanceService;
use App\Modules\FleetMaintenance\Application\VehicleTripService;
use App\Modules\Identity\Application\EffectivePermissionResolver;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class FleetMaintenanceController extends Controller
{
    public function __construct(
        private readonly FleetMaintenanceService $service,
        private readonly VehicleTripService $trips,
        private readonly EffectivePermissionResolver $permissions,
    ) {}

    public function context(Request $request): JsonResponse
    {
        $user = $request->user();
        $hasGlobalAccess = collect([
            'fleet.vehicle.view',
            'maintenance.work-order.view',
            'fleet.trip.view',
            'fleet.trip.operate',
        ])->contains(fn (string $permission): bool => $this->permissions->allowsGlobal($user, $permission));
        $locations = Location::query()
            ->with('company:id,code,legal_name')
            ->where('status', 'active')
            ->whereHas('company', fn ($query) => $query->where('status', 'active'))
            ->when(! $hasGlobalAccess, fn ($query) => $query->whereIn(
                'id',
                $user->locationMemberships()->where('valid_from', '<=', today())
                    ->where(fn ($query) => $query->whereNull('valid_until')->orWhere('valid_until', '>=', today()))
                    ->pluck('location_id'),
            ))
            ->orderBy('name')
            ->get()
            ->map(function (Location $location) use ($user): ?array {
                $capabilities = [
                    'can_view_vehicles' => $this->permissions->allows($user, 'fleet.vehicle.view', $location->company_id, locationId: $location->id),
                    'can_manage_vehicles' => $this->permissions->allows($user, 'fleet.vehicle.manage', $location->company_id, locationId: $location->id),
                    'can_view_work_orders' => $this->permissions->allows($user, 'maintenance.work-order.view', $location->company_id, locationId: $location->id),
                    'can_manage_work_orders' => $this->permissions->allows($user, 'maintenance.work-order.manage', $location->company_id, locationId: $location->id),
                    'can_view_trips' => $this->permissions->allows($user, 'fleet.trip.view', $location->company_id, locationId: $location->id),
                    'can_operate_trips' => $this->permissions->allows($user, 'fleet.trip.operate', $location->company_id, locationId: $location->id),
                    'can_manage_trips' => $this->permissions->allows($user, 'fleet.trip.manage', $location->company_id, locationId: $location->id),
                ];

                return in_array(true, $capabilities, true) ? [
                    'company' => $location->company->only(['id', 'code', 'legal_name']),
                    'location' => $location->only(['id', 'code', 'name', 'timezone']),
                    'capabilities' => $capabilities,
                ] : null;
            })
            ->filter()
            ->values();

        return response()->json(['data' => $locations]);
    }

    public function vehicleTypes(Company $company, Location $location): JsonResponse
    {
        $this->assertLocation($company, $location);

        return response()->json(['data' => VehicleType::query()
            ->where('company_id', $company->id)
            ->where('status', 'active')
            ->orderBy('name')
            ->get(['id', 'code', 'name', 'status'])]);
    }

    public function createVehicleType(
        CreateVehicleTypeRequest $request,
        Company $company,
        Location $location,
    ): JsonResponse {
        $this->assertLocation($company, $location);
        $type = $this->service->createVehicleType($company, $request->user(), $request->validated(), $request);

        return response()->json(['data' => $type], 201);
    }

    public function vehicles(Request $request, Company $company, Location $location): JsonResponse
    {
        $this->assertLocation($company, $location);
        $vehicles = Vehicle::query()
            ->with('type:id,code,name')
            ->where('company_id', $company->id)
            ->where('location_id', $location->id)
            ->when($request->filled('status'), fn ($query) => $query->where('operational_status', $request->string('status')))
            ->when($request->filled('search'), function ($query) use ($request): void {
                $search = '%'.str_replace(['%', '_'], ['\\%', '\\_'], $request->string('search')->toString()).'%';
                $query->where(fn ($query) => $query->where('plate_number', 'like', $search)
                    ->orWhere('code', 'like', $search)
                    ->orWhere('brand', 'like', $search)
                    ->orWhere('model', 'like', $search));
            })
            ->orderBy('plate_number')
            ->paginate(min(max($request->integer('per_page', 20), 1), 100));

        return response()->json($vehicles);
    }

    public function createVehicle(
        CreateVehicleRequest $request,
        Company $company,
        Location $location,
    ): JsonResponse {
        $this->assertLocation($company, $location);
        $vehicle = $this->service->createVehicle($company, $location, $request->user(), $request->validated(), $request);

        return response()->json(['data' => $vehicle], 201);
    }

    public function vehicle(Company $company, Location $location, Vehicle $vehicle): JsonResponse
    {
        $this->assertVehicle($company, $location, $vehicle);
        $vehicle->load([
            'type:id,code,name',
            'statusHistory' => fn ($query) => $query->with('actor:id,name')->latest('changed_at')->limit(25),
        ]);

        return response()->json(['data' => $vehicle]);
    }

    public function changeVehicleStatus(
        ChangeVehicleStatusRequest $request,
        Company $company,
        Location $location,
        Vehicle $vehicle,
    ): JsonResponse {
        $this->assertVehicle($company, $location, $vehicle);
        $changed = $this->service->changeVehicleStatus(
            $vehicle,
            $request->validated('status'),
            $request->validated('reason'),
            $request->user(),
            $request,
        );

        return response()->json(['data' => $changed]);
    }

    public function checklistTemplate(Company $company, Location $location): JsonResponse
    {
        $this->assertLocation($company, $location);
        $template = ChecklistTemplate::query()
            ->with('items')
            ->where('company_id', $company->id)
            ->where('code', 'VEHICLE_PRE_DEPARTURE')
            ->where('status', 'active')
            ->orderByDesc('version')
            ->first();

        return $template
            ? response()->json(['data' => $template])
            : response()->json(['message' => 'Checklist template is not configured.', 'code' => 'CHECKLIST_TEMPLATE_NOT_CONFIGURED'], 404);
    }

    public function trips(Request $request, Company $company, Location $location): JsonResponse
    {
        $this->assertLocation($company, $location);
        $trips = VehicleTrip::query()
            ->with(['vehicle.type:id,code,name', 'driver:id,name,email'])
            ->where('company_id', $company->id)
            ->where('location_id', $location->id)
            ->when(! $this->permissions->allows(
                $request->user(), 'fleet.trip.manage', $company->id, locationId: $location->id,
            ), fn ($query) => $query->where('driver_id', $request->user()->id))
            ->when($request->filled('status'), fn ($query) => $query->where('status', $request->string('status')))
            ->latest('departed_at')
            ->paginate(min(max($request->integer('per_page', 20), 1), 100));

        return response()->json($trips);
    }

    public function checkout(
        CheckoutVehicleRequest $request,
        Company $company,
        Location $location,
    ): JsonResponse {
        $this->assertLocation($company, $location);
        $trip = $this->trips->checkout($company, $location, $request->user(), $request->validated(), $request);

        return response()->json(['data' => $trip], 201);
    }

    public function trip(Request $request, Company $company, Location $location, VehicleTrip $trip): JsonResponse
    {
        $this->assertTrip($company, $location, $trip);
        $this->assertTripVisibleTo($request, $trip);

        return response()->json(['data' => $trip->load([
            'vehicle.type:id,code,name', 'driver:id,name,email', 'checklist.template.items',
            'checklist.answers.item',
            'checklist.answers.evidenceFiles' => fn ($query) => $query->select([
                'id', 'attached_id', 'original_name', 'declared_mime_type', 'detected_mime_type',
                'expected_size', 'actual_size', 'status', 'scan_status', 'created_at',
            ]),
        ])]);
    }

    public function checkIn(
        CheckInVehicleRequest $request,
        Company $company,
        Location $location,
        VehicleTrip $trip,
    ): JsonResponse {
        $this->assertTrip($company, $location, $trip);
        $this->assertTripVisibleTo($request, $trip);
        $changed = $this->trips->checkIn($trip, $request->user(), $request->validated(), $request);

        return response()->json(['data' => $changed]);
    }

    public function cancelTrip(
        CancelVehicleTripRequest $request,
        Company $company,
        Location $location,
        VehicleTrip $trip,
    ): JsonResponse {
        $this->assertTrip($company, $location, $trip);
        $changed = $this->trips->cancel($trip, $request->user(), $request->validated('reason'), $request);

        return response()->json(['data' => $changed]);
    }

    public function workOrders(Request $request, Company $company, Location $location): JsonResponse
    {
        $this->assertLocation($company, $location);
        $orders = MaintenanceWorkOrder::query()
            ->with(['vehicle.type:id,code,name', 'jobs'])
            ->where('company_id', $company->id)
            ->where('location_id', $location->id)
            ->when($request->filled('status'), fn ($query) => $query->where('status', $request->string('status')))
            ->latest('work_order_date')
            ->latest('created_at')
            ->paginate(min(max($request->integer('per_page', 20), 1), 100));

        return response()->json($orders);
    }

    public function createWorkOrder(
        CreateMaintenanceWorkOrderRequest $request,
        Company $company,
        Location $location,
    ): JsonResponse {
        $this->assertLocation($company, $location);
        $workOrder = $this->service->createWorkOrder($company, $location, $request->user(), $request->validated(), $request);

        return response()->json(['data' => $workOrder], 201);
    }

    public function workOrder(
        Company $company,
        Location $location,
        MaintenanceWorkOrder $workOrder,
    ): JsonResponse {
        $this->assertWorkOrder($company, $location, $workOrder);

        return response()->json(['data' => $workOrder->load(['vehicle.type', 'jobs', 'creator:id,name'])]);
    }

    public function transitionWorkOrder(
        TransitionMaintenanceWorkOrderRequest $request,
        Company $company,
        Location $location,
        MaintenanceWorkOrder $workOrder,
    ): JsonResponse {
        $this->assertWorkOrder($company, $location, $workOrder);
        $changed = $this->service->transitionWorkOrder(
            $workOrder,
            $request->validated('status'),
            $request->validated('note'),
            $request->user(),
            $request,
        );

        return response()->json(['data' => $changed]);
    }

    private function assertLocation(Company $company, Location $location): void
    {
        abort_unless($location->company_id === $company->id, 404);
    }

    private function assertVehicle(Company $company, Location $location, Vehicle $vehicle): void
    {
        $this->assertLocation($company, $location);
        abort_unless($vehicle->company_id === $company->id && $vehicle->location_id === $location->id, 404);
    }

    private function assertWorkOrder(Company $company, Location $location, MaintenanceWorkOrder $workOrder): void
    {
        $this->assertLocation($company, $location);
        abort_unless($workOrder->company_id === $company->id && $workOrder->location_id === $location->id, 404);
    }

    private function assertTrip(Company $company, Location $location, VehicleTrip $trip): void
    {
        $this->assertLocation($company, $location);
        abort_unless($trip->company_id === $company->id && $trip->location_id === $location->id, 404);
    }

    private function assertTripVisibleTo(Request $request, VehicleTrip $trip): void
    {
        abort_unless(
            $trip->driver_id === $request->user()->id || $this->permissions->allows(
                $request->user(), 'fleet.trip.manage', $trip->company_id, locationId: $trip->location_id,
            ),
            404,
        );
    }
}
