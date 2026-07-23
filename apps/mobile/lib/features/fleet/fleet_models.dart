import 'package:rajawali_mobile/features/operations/operations_context.dart';

enum FleetVehicleStatus {
  available,
  inUse,
  maintenance,
  blocked,
  inactive,
  unknown,
}

enum FleetTripStatus { active, completed, cancelled, unknown }

final class FleetVehicle {
  const FleetVehicle({
    required this.id,
    required this.code,
    required this.plateNumber,
    required this.brand,
    required this.model,
    required this.modelYear,
    required this.currentOdometer,
    required this.status,
    required this.typeName,
  });

  final String id;
  final String code;
  final String plateNumber;
  final String brand;
  final String model;
  final int? modelYear;
  final int currentOdometer;
  final FleetVehicleStatus status;
  final String? typeName;
}

final class FleetTrip {
  const FleetTrip({
    required this.id,
    required this.status,
    required this.purpose,
    required this.destination,
    required this.startOdometer,
    required this.departedAt,
    required this.vehicleId,
    required this.vehiclePlateNumber,
    required this.driverId,
    required this.driverName,
  });

  final String id;
  final FleetTripStatus status;
  final String purpose;
  final String? destination;
  final int startOdometer;
  final DateTime departedAt;
  final String vehicleId;
  final String vehiclePlateNumber;
  final String driverId;
  final String driverName;
}

final class FleetPage<T> {
  const FleetPage({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  const FleetPage.empty()
    : data = const [],
      currentPage = 1,
      lastPage = 1,
      total = 0;

  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;
}

final class FleetStatusCounts {
  const FleetStatusCounts({
    required this.available,
    required this.inUse,
    required this.maintenance,
  });

  const FleetStatusCounts.empty() : available = 0, inUse = 0, maintenance = 0;

  final int available;
  final int inUse;
  final int maintenance;
}

final class FleetScope {
  const FleetScope({required this.companyId, required this.locationId});

  factory FleetScope.fromWorkspace(OperationsWorkspace workspace) {
    return FleetScope(
      companyId: workspace.company.id,
      locationId: workspace.location.id,
    );
  }

  final String companyId;
  final String locationId;

  String get key => '$companyId:$locationId';
}
