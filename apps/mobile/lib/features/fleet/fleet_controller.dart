import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rajawali_mobile/core/network/api_failure.dart';
import 'package:rajawali_mobile/features/fleet/fleet_models.dart';
import 'package:rajawali_mobile/features/fleet/fleet_repository.dart';
import 'package:rajawali_mobile/features/operations/operations_context.dart';

enum FleetStage { idle, loading, ready, failure }

final class FleetController extends ChangeNotifier {
  FleetController(this._repository, {required this.onSessionExpired});

  final FleetRepository _repository;
  final Future<void> Function() onSessionExpired;

  FleetStage _stage = FleetStage.idle;
  OperationsWorkspace? _workspace;
  FleetPage<FleetVehicle> _vehicles = const FleetPage.empty();
  FleetPage<FleetTrip> _activeTrips = const FleetPage.empty();
  FleetStatusCounts _statusCounts = const FleetStatusCounts.empty();
  ApiFailure? _failure;
  String? _paginationError;
  var _loadingMoreVehicles = false;
  var _loadingMoreTrips = false;
  var _revision = 0;
  var _disposed = false;

  FleetStage get stage => _stage;
  OperationsWorkspace? get workspace => _workspace;
  FleetPage<FleetVehicle> get vehicles => _vehicles;
  FleetPage<FleetTrip> get activeTrips => _activeTrips;
  FleetStatusCounts get statusCounts => _statusCounts;
  ApiFailure? get failure => _failure;
  String? get paginationError => _paginationError;
  bool get loadingMoreVehicles => _loadingMoreVehicles;
  bool get loadingMoreTrips => _loadingMoreTrips;

  Future<void> load(OperationsWorkspace workspace) async {
    final revision = ++_revision;
    _workspace = workspace;
    _stage = FleetStage.loading;
    _failure = null;
    _paginationError = null;
    _loadingMoreVehicles = false;
    _loadingMoreTrips = false;
    _notifyIfActive();

    var vehicles = const FleetPage<FleetVehicle>.empty();
    var trips = const FleetPage<FleetTrip>.empty();
    var counts = const FleetStatusCounts.empty();
    final scope = FleetScope.fromWorkspace(workspace);
    final requests = <Future<void>>[];
    if (workspace.capabilities.canViewVehicles ||
        workspace.capabilities.canManageVehicles) {
      requests
        ..add(
          _repository.loadVehicles(scope, page: 1).then((value) {
            vehicles = value;
          }),
        )
        ..add(
          _repository.loadStatusCounts(scope).then((value) {
            counts = value;
          }),
        );
    }
    if (workspace.capabilities.canViewTrips ||
        workspace.capabilities.canOperateTrips ||
        workspace.capabilities.canManageTrips) {
      requests.add(
        _repository.loadActiveTrips(scope, page: 1).then((value) {
          trips = value;
        }),
      );
    }

    try {
      await Future.wait(requests);
      if (!_isCurrent(revision)) return;
      _vehicles = vehicles;
      _activeTrips = trips;
      _statusCounts = counts;
      _stage = FleetStage.ready;
      _notifyIfActive();
    } on DioException catch (error) {
      await _handleFailure(error, revision);
    } on Object {
      if (!_isCurrent(revision)) return;
      _failure = const ApiFailure(
        kind: ApiFailureKind.unknown,
        message: 'Data Fleet tidak dapat disiapkan.',
      );
      _stage = FleetStage.failure;
      _notifyIfActive();
    }
  }

  Future<void> loadMoreVehicles() async {
    final workspace = _workspace;
    if (workspace == null ||
        _loadingMoreVehicles ||
        !_vehicles.hasMore ||
        _stage != FleetStage.ready) {
      return;
    }
    _loadingMoreVehicles = true;
    _paginationError = null;
    final revision = _revision;
    notifyListeners();
    try {
      final next = await _repository.loadVehicles(
        FleetScope.fromWorkspace(workspace),
        page: _vehicles.currentPage + 1,
      );
      if (!_isCurrent(revision)) return;
      _vehicles = FleetPage(
        data: _mergeById(_vehicles.data, next.data, (vehicle) => vehicle.id),
        currentPage: next.currentPage,
        lastPage: next.lastPage,
        total: next.total,
      );
    } on DioException catch (error) {
      if (!_isCurrent(revision)) return;
      await _handlePaginationFailure(error);
    } on Object {
      if (_isCurrent(revision)) {
        _paginationError = 'Kendaraan berikutnya tidak dapat dimuat.';
      }
    } finally {
      if (_isCurrent(revision)) {
        _loadingMoreVehicles = false;
        _notifyIfActive();
      }
    }
  }

  Future<void> loadMoreTrips() async {
    final workspace = _workspace;
    if (workspace == null ||
        _loadingMoreTrips ||
        !_activeTrips.hasMore ||
        _stage != FleetStage.ready) {
      return;
    }
    _loadingMoreTrips = true;
    _paginationError = null;
    final revision = _revision;
    notifyListeners();
    try {
      final next = await _repository.loadActiveTrips(
        FleetScope.fromWorkspace(workspace),
        page: _activeTrips.currentPage + 1,
      );
      if (!_isCurrent(revision)) return;
      _activeTrips = FleetPage(
        data: _mergeById(_activeTrips.data, next.data, (trip) => trip.id),
        currentPage: next.currentPage,
        lastPage: next.lastPage,
        total: next.total,
      );
    } on DioException catch (error) {
      if (!_isCurrent(revision)) return;
      await _handlePaginationFailure(error);
    } on Object {
      if (_isCurrent(revision)) {
        _paginationError = 'Trip berikutnya tidak dapat dimuat.';
      }
    } finally {
      if (_isCurrent(revision)) {
        _loadingMoreTrips = false;
        _notifyIfActive();
      }
    }
  }

  Future<void> _handleFailure(DioException error, int revision) async {
    if (!_isCurrent(revision)) return;
    final failure = ApiFailure.fromDio(error);
    if (failure.kind == ApiFailureKind.unauthenticated) {
      await onSessionExpired();
      return;
    }
    _failure = failure;
    _stage = FleetStage.failure;
    _notifyIfActive();
  }

  Future<void> _handlePaginationFailure(DioException error) async {
    final failure = ApiFailure.fromDio(error);
    if (failure.kind == ApiFailureKind.unauthenticated) {
      await onSessionExpired();
      return;
    }
    _paginationError = failure.message;
  }

  static List<T> _mergeById<T>(
    List<T> current,
    List<T> incoming,
    String Function(T) idOf,
  ) {
    final values = <String, T>{for (final item in current) idOf(item): item};
    for (final item in incoming) {
      values[idOf(item)] = item;
    }
    return List.unmodifiable(values.values);
  }

  bool _isCurrent(int revision) => !_disposed && revision == _revision;

  void _notifyIfActive() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _revision += 1;
    super.dispose();
  }
}
