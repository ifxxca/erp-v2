import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rajawali_mobile/core/network/api_failure.dart';
import 'package:rajawali_mobile/features/operations/operations_context.dart';
import 'package:rajawali_mobile/features/operations/operations_context_repository.dart';

enum OperationsContextStage { loading, ready, empty, failure }

final class OperationsContextController extends ChangeNotifier {
  OperationsContextController(
    this._repository, {
    required this._onSessionExpired,
  });

  final OperationsContextRepository _repository;
  final Future<void> Function() _onSessionExpired;

  OperationsContextStage _stage = OperationsContextStage.loading;
  OperatorIdentity? _identity;
  List<OperationsWorkspace> _workspaces = const [];
  OperationsWorkspace? _activeWorkspace;
  ApiFailure? _failure;
  var _loadRevision = 0;
  var _disposed = false;

  OperationsContextStage get stage => _stage;
  OperatorIdentity? get identity => _identity;
  List<OperationsWorkspace> get workspaces => _workspaces;
  OperationsWorkspace? get activeWorkspace => _activeWorkspace;
  ApiFailure? get failure => _failure;

  Future<void> load() async {
    final revision = ++_loadRevision;
    _stage = OperationsContextStage.loading;
    _failure = null;
    _notifyIfActive();

    try {
      final result = await _repository.load();
      if (!_isCurrent(revision)) return;
      _identity = result.identity;
      _workspaces = result.workspaces;
      _activeWorkspace = _preservedOrFirst(result.workspaces);
      _stage = result.workspaces.isEmpty
          ? OperationsContextStage.empty
          : OperationsContextStage.ready;
      _notifyIfActive();
    } on DioException catch (error) {
      if (!_isCurrent(revision)) return;
      final failure = ApiFailure.fromDio(error);
      if (failure.kind == ApiFailureKind.unauthenticated) {
        await _onSessionExpired();
        return;
      }
      _failure = failure;
      _stage = OperationsContextStage.failure;
      _notifyIfActive();
    } on Object {
      if (!_isCurrent(revision)) return;
      _failure = const ApiFailure(
        kind: ApiFailureKind.unknown,
        message: 'Area kerja tidak dapat disiapkan.',
      );
      _stage = OperationsContextStage.failure;
      _notifyIfActive();
    }
  }

  void select(String workspaceKey) {
    if (_stage != OperationsContextStage.ready) return;
    for (final workspace in _workspaces) {
      if (workspace.key == workspaceKey) {
        if (!identical(_activeWorkspace, workspace)) {
          _activeWorkspace = workspace;
          notifyListeners();
        }
        return;
      }
    }
  }

  OperationsWorkspace? _preservedOrFirst(List<OperationsWorkspace> workspaces) {
    final selectedKey = _activeWorkspace?.key;
    if (selectedKey != null) {
      for (final workspace in workspaces) {
        if (workspace.key == selectedKey) return workspace;
      }
    }
    return workspaces.isEmpty ? null : workspaces.first;
  }

  bool _isCurrent(int revision) => !_disposed && revision == _loadRevision;

  void _notifyIfActive() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _loadRevision += 1;
    super.dispose();
  }
}
