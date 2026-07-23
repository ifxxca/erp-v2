import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rajawali_mobile/features/fleet/fleet_controller.dart';
import 'package:rajawali_mobile/features/fleet/fleet_models.dart';
import 'package:rajawali_mobile/features/fleet/fleet_repository.dart';
import 'package:rajawali_mobile/features/fleet/trip_detail_controller.dart';
import 'package:rajawali_mobile/features/operations/operations_context.dart';

void main() {
  test(
    'loads capability-authorized Fleet data and exact status totals',
    () async {
      final repository = FakeFleetRepository();
      final controller = FleetController(
        repository,
        onSessionExpired: () async {},
      );

      await controller.load(workspace());

      expect(controller.stage, FleetStage.ready);
      expect(controller.vehicles.total, 25);
      expect(controller.activeTrips.total, 1);
      expect(controller.statusCounts.available, 10);
      expect(repository.vehiclePages, [1]);
      expect(repository.tripPages, [1]);
      expect(repository.statusCountCalls, 1);
    },
  );

  test('load more merges pages by stable identifier', () async {
    final repository = FakeFleetRepository();
    final controller = FleetController(
      repository,
      onSessionExpired: () async {},
    );
    await controller.load(workspace());

    await controller.loadMoreVehicles();

    expect(controller.vehicles.currentPage, 2);
    expect(controller.vehicles.data.map((item) => item.id), [
      'vehicle-1',
      'vehicle-2',
    ]);
    expect(repository.vehiclePages, [1, 2]);
  });

  test('maintenance-only workspace does not call Fleet endpoints', () async {
    final repository = FakeFleetRepository();
    final controller = FleetController(
      repository,
      onSessionExpired: () async {},
    );

    await controller.load(workspace(fleetAccess: false, tripAccess: false));

    expect(controller.stage, FleetStage.ready);
    expect(repository.vehiclePages, isEmpty);
    expect(repository.tripPages, isEmpty);
    expect(repository.statusCountCalls, 0);
  });

  test('late response from previous workspace is discarded', () async {
    final repository = FakeFleetRepository();
    final delayed = Completer<FleetPage<FleetVehicle>>();
    repository.firstVehicleResult = delayed.future;
    final controller = FleetController(
      repository,
      onSessionExpired: () async {},
    );

    final first = controller.load(workspace(locationId: 'location-1'));
    final second = controller.load(workspace(locationId: 'location-2'));
    delayed.complete(vehiclePage('vehicle-old', page: 1));
    await Future.wait([first, second]);

    expect(controller.workspace?.location.id, 'location-2');
    expect(controller.vehicles.data.single.id, 'vehicle-1');
  });

  test('unauthorized Fleet load expires the application session', () async {
    final repository = FakeFleetRepository()..unauthorized = true;
    var expired = false;
    final controller = FleetController(
      repository,
      onSessionExpired: () async => expired = true,
    );

    await controller.load(workspace());

    expect(expired, isTrue);
  });

  test('loads scoped trip detail with its checklist snapshot', () async {
    final repository = FakeFleetRepository();
    final controller = TripDetailController(
      repository,
      onSessionExpired: () async {},
    );

    await controller.load(FleetScope.fromWorkspace(workspace()), 'trip-1');

    expect(controller.stage, TripDetailStage.ready);
    expect(controller.trip?.id, 'trip-1');
    expect(controller.trip?.checklist?.answers.single.label, 'Kondisi ban');
    expect(repository.detailTripIds, ['trip-1']);
  });

  test('late trip detail response is discarded', () async {
    final repository = FakeFleetRepository();
    final delayed = Completer<FleetTripDetail>();
    repository.firstDetailResult = delayed.future;
    final controller = TripDetailController(
      repository,
      onSessionExpired: () async {},
    );
    final scope = FleetScope.fromWorkspace(workspace());

    final first = controller.load(scope, 'trip-old');
    final second = controller.load(scope, 'trip-new');
    delayed.complete(tripDetail('trip-old'));
    await Future.wait([first, second]);

    expect(controller.trip?.id, 'trip-new');
  });

  test('unauthorized trip detail expires the application session', () async {
    final repository = FakeFleetRepository()..unauthorized = true;
    var expired = false;
    final controller = TripDetailController(
      repository,
      onSessionExpired: () async => expired = true,
    );

    await controller.load(
      FleetScope.fromWorkspace(workspace()),
      'trip-unauthorized',
    );

    expect(expired, isTrue);
  });
}

final class FakeFleetRepository implements FleetRepository {
  final vehiclePages = <int>[];
  final tripPages = <int>[];
  var statusCountCalls = 0;
  var unauthorized = false;
  Future<FleetPage<FleetVehicle>>? firstVehicleResult;
  Future<FleetTripDetail>? firstDetailResult;
  final detailTripIds = <String>[];

  @override
  Future<FleetPage<FleetTrip>> loadActiveTrips(
    FleetScope scope, {
    required int page,
  }) async {
    tripPages.add(page);
    _throwIfUnauthorized();
    return FleetPage(
      data: [trip('trip-$page')],
      currentPage: page,
      lastPage: 1,
      total: 1,
    );
  }

  @override
  Future<FleetStatusCounts> loadStatusCounts(FleetScope scope) async {
    statusCountCalls += 1;
    _throwIfUnauthorized();
    return const FleetStatusCounts(available: 10, inUse: 5, maintenance: 2);
  }

  @override
  Future<FleetTripDetail> loadTripDetail(
    FleetScope scope, {
    required String tripId,
  }) async {
    detailTripIds.add(tripId);
    _throwIfUnauthorized();
    final delayed = firstDetailResult;
    if (delayed != null && tripId == 'trip-old') return delayed;
    return tripDetail(tripId);
  }

  @override
  Future<FleetPage<FleetVehicle>> loadVehicles(
    FleetScope scope, {
    required int page,
  }) async {
    vehiclePages.add(page);
    _throwIfUnauthorized();
    final delayed = firstVehicleResult;
    if (delayed != null && scope.locationId == 'location-1') return delayed;
    return page == 1
        ? vehiclePage('vehicle-1', page: 1)
        : FleetPage(
            data: [vehicle('vehicle-1'), vehicle('vehicle-2')],
            currentPage: 2,
            lastPage: 2,
            total: 25,
          );
  }

  void _throwIfUnauthorized() {
    if (!unauthorized) return;
    final options = RequestOptions(path: '/fleet');
    throw DioException(
      requestOptions: options,
      response: Response<Object?>(requestOptions: options, statusCode: 401),
    );
  }
}

FleetPage<FleetVehicle> vehiclePage(String id, {required int page}) {
  return FleetPage(
    data: [vehicle(id)],
    currentPage: page,
    lastPage: 2,
    total: 25,
  );
}

FleetVehicle vehicle(String id) => FleetVehicle(
  id: id,
  code: id.toUpperCase(),
  plateNumber: 'B 1234 RKS',
  brand: 'Isuzu',
  model: 'Elf',
  modelYear: 2025,
  currentOdometer: 12000,
  status: FleetVehicleStatus.available,
  typeName: 'Light Truck',
);

FleetTrip trip(String id) => FleetTrip(
  id: id,
  status: FleetTripStatus.active,
  purpose: 'Delivery retail',
  destination: 'Jakarta',
  startOdometer: 12000,
  departedAt: DateTime.utc(2026, 7, 23, 8),
  vehicleId: 'vehicle-1',
  vehiclePlateNumber: 'B 1234 RKS',
  driverId: 'user-1',
  driverName: 'Driver Test',
);

FleetTripDetail tripDetail(String id) => FleetTripDetail(
  id: id,
  status: FleetTripStatus.active,
  purpose: 'Delivery retail',
  destination: 'Jakarta',
  startOdometer: 12000,
  endOdometer: null,
  departedAt: DateTime.utc(2026, 7, 23, 8),
  arrivedAt: null,
  cancelledAt: null,
  completionNote: null,
  cancelReason: null,
  vehicleCode: 'TRUCK-01',
  vehiclePlateNumber: 'B 1234 RKS',
  vehicleDescription: 'Isuzu Elf',
  driverName: 'Driver Test',
  driverEmail: 'driver@example.test',
  checklist: FleetChecklistSubmission(
    id: 'submission-1',
    templateName: 'Pre-departure',
    templateVersion: 1,
    submittedAt: DateTime.utc(2026, 7, 23, 8),
    answers: const [
      FleetChecklistAnswer(
        id: 'answer-1',
        lineNumber: 1,
        label: 'Kondisi ban',
        isRequired: true,
        isCritical: true,
        result: FleetChecklistResult.pass,
        note: null,
        evidence: [],
      ),
    ],
  ),
);

OperationsWorkspace workspace({
  String locationId = 'location-1',
  bool fleetAccess = true,
  bool tripAccess = true,
}) {
  return OperationsWorkspace(
    company: const LegalEntity(
      id: 'company-1',
      code: 'RKS',
      legalName: 'PT Rajawali Kresek Sejahtera',
    ),
    location: WorkLocation(
      id: locationId,
      code: locationId.toUpperCase(),
      name: 'Location $locationId',
      timezone: 'Asia/Jakarta',
    ),
    capabilities: MobileOperationsCapabilities(
      canViewVehicles: fleetAccess,
      canManageVehicles: false,
      canViewWorkOrders: !fleetAccess && !tripAccess,
      canManageWorkOrders: false,
      canViewTrips: tripAccess,
      canOperateTrips: tripAccess,
      canManageTrips: false,
    ),
  );
}
