import 'package:rajawali_api_client/rajawali_api_client.dart';
import 'package:rajawali_mobile/features/fleet/fleet_models.dart';

abstract interface class FleetRepository {
  Future<FleetPage<FleetVehicle>> loadVehicles(
    FleetScope scope, {
    required int page,
  });

  Future<FleetPage<FleetTrip>> loadActiveTrips(
    FleetScope scope, {
    required int page,
  });

  Future<FleetStatusCounts> loadStatusCounts(FleetScope scope);
}

final class GeneratedFleetRepository implements FleetRepository {
  const GeneratedFleetRepository(this._api);

  static const _pageSize = 20;

  final DefaultApi _api;

  @override
  Future<FleetPage<FleetTrip>> loadActiveTrips(
    FleetScope scope, {
    required int page,
  }) async {
    final body = (await _api.listVehicleTrips(
      companyId: scope.companyId,
      locationId: scope.locationId,
      status: VehicleTripStatus.active,
      perPage: _pageSize,
      page: page,
    )).data;
    if (body == null) throw const FleetProtocolException();

    return FleetPage(
      data: List.unmodifiable(body.data.map(_trip)),
      currentPage: body.currentPage,
      lastPage: body.lastPage,
      total: body.total,
    );
  }

  @override
  Future<FleetStatusCounts> loadStatusCounts(FleetScope scope) async {
    final responses = await Future.wait([
      _vehicleCount(scope, VehicleStatus.available),
      _vehicleCount(scope, VehicleStatus.inUse),
      _vehicleCount(scope, VehicleStatus.maintenance),
    ]);
    return FleetStatusCounts(
      available: responses[0],
      inUse: responses[1],
      maintenance: responses[2],
    );
  }

  @override
  Future<FleetPage<FleetVehicle>> loadVehicles(
    FleetScope scope, {
    required int page,
  }) async {
    final body = (await _api.listVehicles(
      companyId: scope.companyId,
      locationId: scope.locationId,
      perPage: _pageSize,
      page: page,
    )).data;
    if (body == null) throw const FleetProtocolException();

    return FleetPage(
      data: List.unmodifiable(body.data.map(_vehicle)),
      currentPage: body.currentPage,
      lastPage: body.lastPage,
      total: body.total,
    );
  }

  Future<int> _vehicleCount(FleetScope scope, VehicleStatus status) async {
    final body = (await _api.listVehicles(
      companyId: scope.companyId,
      locationId: scope.locationId,
      status: status,
      perPage: 1,
      page: 1,
    )).data;
    if (body == null) throw const FleetProtocolException();
    return body.total;
  }

  static FleetTrip _trip(VehicleTrip value) => FleetTrip(
    id: value.id,
    status: _tripStatus(value.status),
    purpose: value.purpose,
    destination: value.destination,
    startOdometer: value.startOdometer,
    departedAt: value.departedAt.toUtc(),
    vehicleId: value.vehicle.id,
    vehiclePlateNumber: value.vehicle.plateNumber,
    driverId: value.driver.id,
    driverName: value.driver.name,
  );

  static FleetVehicle _vehicle(Vehicle value) => FleetVehicle(
    id: value.id,
    code: value.code,
    plateNumber: value.plateNumber,
    brand: value.brand,
    model: value.model,
    modelYear: value.modelYear,
    currentOdometer: value.currentOdometer,
    status: _vehicleStatus(value.operationalStatus),
    typeName: value.type?.name,
  );

  static FleetTripStatus _tripStatus(VehicleTripStatus value) {
    if (value == VehicleTripStatus.active) return FleetTripStatus.active;
    if (value == VehicleTripStatus.completed) return FleetTripStatus.completed;
    if (value == VehicleTripStatus.cancelled) return FleetTripStatus.cancelled;
    return FleetTripStatus.unknown;
  }

  static FleetVehicleStatus _vehicleStatus(VehicleStatus value) {
    if (value == VehicleStatus.available) return FleetVehicleStatus.available;
    if (value == VehicleStatus.inUse) return FleetVehicleStatus.inUse;
    if (value == VehicleStatus.maintenance) {
      return FleetVehicleStatus.maintenance;
    }
    if (value == VehicleStatus.blocked) return FleetVehicleStatus.blocked;
    if (value == VehicleStatus.inactive) return FleetVehicleStatus.inactive;
    return FleetVehicleStatus.unknown;
  }
}

final class FleetProtocolException implements Exception {
  const FleetProtocolException();
}
