// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations_capabilities.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OperationsCapabilities extends OperationsCapabilities {
  @override
  final bool canViewVehicles;
  @override
  final bool canManageVehicles;
  @override
  final bool canViewWorkOrders;
  @override
  final bool canManageWorkOrders;
  @override
  final bool canViewTrips;
  @override
  final bool canOperateTrips;
  @override
  final bool canManageTrips;

  factory _$OperationsCapabilities(
          [void Function(OperationsCapabilitiesBuilder)? updates]) =>
      (OperationsCapabilitiesBuilder()..update(updates))._build();

  _$OperationsCapabilities._(
      {required this.canViewVehicles,
      required this.canManageVehicles,
      required this.canViewWorkOrders,
      required this.canManageWorkOrders,
      required this.canViewTrips,
      required this.canOperateTrips,
      required this.canManageTrips})
      : super._();
  @override
  OperationsCapabilities rebuild(
          void Function(OperationsCapabilitiesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OperationsCapabilitiesBuilder toBuilder() =>
      OperationsCapabilitiesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OperationsCapabilities &&
        canViewVehicles == other.canViewVehicles &&
        canManageVehicles == other.canManageVehicles &&
        canViewWorkOrders == other.canViewWorkOrders &&
        canManageWorkOrders == other.canManageWorkOrders &&
        canViewTrips == other.canViewTrips &&
        canOperateTrips == other.canOperateTrips &&
        canManageTrips == other.canManageTrips;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, canViewVehicles.hashCode);
    _$hash = $jc(_$hash, canManageVehicles.hashCode);
    _$hash = $jc(_$hash, canViewWorkOrders.hashCode);
    _$hash = $jc(_$hash, canManageWorkOrders.hashCode);
    _$hash = $jc(_$hash, canViewTrips.hashCode);
    _$hash = $jc(_$hash, canOperateTrips.hashCode);
    _$hash = $jc(_$hash, canManageTrips.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OperationsCapabilities')
          ..add('canViewVehicles', canViewVehicles)
          ..add('canManageVehicles', canManageVehicles)
          ..add('canViewWorkOrders', canViewWorkOrders)
          ..add('canManageWorkOrders', canManageWorkOrders)
          ..add('canViewTrips', canViewTrips)
          ..add('canOperateTrips', canOperateTrips)
          ..add('canManageTrips', canManageTrips))
        .toString();
  }
}

class OperationsCapabilitiesBuilder
    implements Builder<OperationsCapabilities, OperationsCapabilitiesBuilder> {
  _$OperationsCapabilities? _$v;

  bool? _canViewVehicles;
  bool? get canViewVehicles => _$this._canViewVehicles;
  set canViewVehicles(bool? canViewVehicles) =>
      _$this._canViewVehicles = canViewVehicles;

  bool? _canManageVehicles;
  bool? get canManageVehicles => _$this._canManageVehicles;
  set canManageVehicles(bool? canManageVehicles) =>
      _$this._canManageVehicles = canManageVehicles;

  bool? _canViewWorkOrders;
  bool? get canViewWorkOrders => _$this._canViewWorkOrders;
  set canViewWorkOrders(bool? canViewWorkOrders) =>
      _$this._canViewWorkOrders = canViewWorkOrders;

  bool? _canManageWorkOrders;
  bool? get canManageWorkOrders => _$this._canManageWorkOrders;
  set canManageWorkOrders(bool? canManageWorkOrders) =>
      _$this._canManageWorkOrders = canManageWorkOrders;

  bool? _canViewTrips;
  bool? get canViewTrips => _$this._canViewTrips;
  set canViewTrips(bool? canViewTrips) => _$this._canViewTrips = canViewTrips;

  bool? _canOperateTrips;
  bool? get canOperateTrips => _$this._canOperateTrips;
  set canOperateTrips(bool? canOperateTrips) =>
      _$this._canOperateTrips = canOperateTrips;

  bool? _canManageTrips;
  bool? get canManageTrips => _$this._canManageTrips;
  set canManageTrips(bool? canManageTrips) =>
      _$this._canManageTrips = canManageTrips;

  OperationsCapabilitiesBuilder() {
    OperationsCapabilities._defaults(this);
  }

  OperationsCapabilitiesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _canViewVehicles = $v.canViewVehicles;
      _canManageVehicles = $v.canManageVehicles;
      _canViewWorkOrders = $v.canViewWorkOrders;
      _canManageWorkOrders = $v.canManageWorkOrders;
      _canViewTrips = $v.canViewTrips;
      _canOperateTrips = $v.canOperateTrips;
      _canManageTrips = $v.canManageTrips;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OperationsCapabilities other) {
    _$v = other as _$OperationsCapabilities;
  }

  @override
  void update(void Function(OperationsCapabilitiesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OperationsCapabilities build() => _build();

  _$OperationsCapabilities _build() {
    final _$result = _$v ??
        _$OperationsCapabilities._(
          canViewVehicles: BuiltValueNullFieldError.checkNotNull(
              canViewVehicles, r'OperationsCapabilities', 'canViewVehicles'),
          canManageVehicles: BuiltValueNullFieldError.checkNotNull(
              canManageVehicles,
              r'OperationsCapabilities',
              'canManageVehicles'),
          canViewWorkOrders: BuiltValueNullFieldError.checkNotNull(
              canViewWorkOrders,
              r'OperationsCapabilities',
              'canViewWorkOrders'),
          canManageWorkOrders: BuiltValueNullFieldError.checkNotNull(
              canManageWorkOrders,
              r'OperationsCapabilities',
              'canManageWorkOrders'),
          canViewTrips: BuiltValueNullFieldError.checkNotNull(
              canViewTrips, r'OperationsCapabilities', 'canViewTrips'),
          canOperateTrips: BuiltValueNullFieldError.checkNotNull(
              canOperateTrips, r'OperationsCapabilities', 'canOperateTrips'),
          canManageTrips: BuiltValueNullFieldError.checkNotNull(
              canManageTrips, r'OperationsCapabilities', 'canManageTrips'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
