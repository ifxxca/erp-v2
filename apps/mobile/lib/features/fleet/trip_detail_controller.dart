import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rajawali_mobile/core/network/api_failure.dart';
import 'package:rajawali_mobile/features/fleet/fleet_models.dart';
import 'package:rajawali_mobile/features/fleet/fleet_repository.dart';

enum TripDetailStage { loading, ready, failure }

final class TripDetailController extends ChangeNotifier {
  TripDetailController(this._repository, {required this.onSessionExpired});

  final FleetRepository _repository;
  final Future<void> Function() onSessionExpired;

  TripDetailStage _stage = TripDetailStage.loading;
  FleetTripDetail? _trip;
  ApiFailure? _failure;
  FleetScope? _scope;
  String? _tripId;
  var _revision = 0;
  var _disposed = false;

  TripDetailStage get stage => _stage;
  FleetTripDetail? get trip => _trip;
  ApiFailure? get failure => _failure;

  Future<void> load(FleetScope scope, String tripId) async {
    final revision = ++_revision;
    _scope = scope;
    _tripId = tripId;
    _stage = TripDetailStage.loading;
    _failure = null;
    _notifyIfActive();

    try {
      final value = await _repository.loadTripDetail(scope, tripId: tripId);
      if (!_isCurrent(revision)) return;
      _trip = value;
      _stage = TripDetailStage.ready;
      _notifyIfActive();
    } on DioException catch (error) {
      if (!_isCurrent(revision)) return;
      final failure = ApiFailure.fromDio(error);
      if (failure.kind == ApiFailureKind.unauthenticated) {
        await onSessionExpired();
        return;
      }
      _failure = failure;
      _stage = TripDetailStage.failure;
      _notifyIfActive();
    } on Object {
      if (!_isCurrent(revision)) return;
      _failure = const ApiFailure(
        kind: ApiFailureKind.unknown,
        message: 'Detail trip tidak dapat disiapkan.',
      );
      _stage = TripDetailStage.failure;
      _notifyIfActive();
    }
  }

  Future<void> retry() async {
    final scope = _scope;
    final tripId = _tripId;
    if (scope == null || tripId == null) return;
    await load(scope, tripId);
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
