import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rajawali_mobile/core/network/api_failure.dart';
import 'package:rajawali_mobile/features/operations/operations_context.dart';
import 'package:rajawali_mobile/features/operations/operations_context_controller.dart';
import 'package:rajawali_mobile/features/operations/operations_context_repository.dart';

void main() {
  test('loads workspaces and preserves a still-authorized selection', () async {
    final repository = FakeOperationsContextRepository([
      bootstrap([workspace('location-1'), workspace('location-2')]),
      bootstrap([workspace('location-2'), workspace('location-3')]),
    ]);
    final controller = OperationsContextController(
      repository,
      onSessionExpired: () async {},
    );

    await controller.load();
    controller.select('company-1:location-2');
    await controller.load();

    expect(controller.stage, OperationsContextStage.ready);
    expect(controller.activeWorkspace?.location.id, 'location-2');
    expect(controller.workspaces, hasLength(2));
  });

  test(
    'valid identity without authorized workspace becomes empty state',
    () async {
      final controller = OperationsContextController(
        FakeOperationsContextRepository([bootstrap(const [])]),
        onSessionExpired: () async {},
      );

      await controller.load();

      expect(controller.stage, OperationsContextStage.empty);
      expect(controller.identity?.name, 'Driver Test');
      expect(controller.activeWorkspace, isNull);
    },
  );

  test('correlated API failure remains retryable', () async {
    final repository = FakeOperationsContextRepository([
      dioFailure(503, requestId: 'request-123'),
      bootstrap([workspace('location-1')]),
    ]);
    final controller = OperationsContextController(
      repository,
      onSessionExpired: () async {},
    );

    await controller.load();
    expect(controller.stage, OperationsContextStage.failure);
    expect(controller.failure?.kind, ApiFailureKind.server);
    expect(controller.failure?.requestId, 'request-123');

    await controller.load();
    expect(controller.stage, OperationsContextStage.ready);
  });

  test('unauthorized context load expires the application session', () async {
    var expired = false;
    final controller = OperationsContextController(
      FakeOperationsContextRepository([dioFailure(401)]),
      onSessionExpired: () async => expired = true,
    );

    await controller.load();

    expect(expired, isTrue);
  });
}

final class FakeOperationsContextRepository
    implements OperationsContextRepository {
  FakeOperationsContextRepository(this.results);

  final List<Object> results;
  var calls = 0;

  @override
  Future<OperationsBootstrapData> load() async {
    final result = results[calls++];
    if (result is Exception) throw result;
    return result as OperationsBootstrapData;
  }
}

OperationsBootstrapData bootstrap(List<OperationsWorkspace> workspaces) {
  return OperationsBootstrapData(
    identity: const OperatorIdentity(
      id: 'user-1',
      name: 'Driver Test',
      email: 'driver@example.test',
    ),
    workspaces: workspaces,
  );
}

OperationsWorkspace workspace(String locationId) {
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
    capabilities: const MobileOperationsCapabilities(
      canViewVehicles: true,
      canManageVehicles: false,
      canViewWorkOrders: false,
      canManageWorkOrders: false,
      canViewTrips: true,
      canOperateTrips: true,
      canManageTrips: false,
    ),
  );
}

DioException dioFailure(int status, {String? requestId}) {
  final options = RequestOptions(path: '/operations/context');
  return DioException(
    requestOptions: options,
    response: Response<Object?>(
      requestOptions: options,
      statusCode: status,
      headers: requestId == null
          ? Headers()
          : (Headers()..set('X-Request-ID', requestId)),
    ),
  );
}
