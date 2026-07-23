// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_vehicle_status_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChangeVehicleStatusRequest extends ChangeVehicleStatusRequest {
  @override
  final VehicleStatus status;
  @override
  final String reason;

  factory _$ChangeVehicleStatusRequest(
          [void Function(ChangeVehicleStatusRequestBuilder)? updates]) =>
      (ChangeVehicleStatusRequestBuilder()..update(updates))._build();

  _$ChangeVehicleStatusRequest._({required this.status, required this.reason})
      : super._();
  @override
  ChangeVehicleStatusRequest rebuild(
          void Function(ChangeVehicleStatusRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChangeVehicleStatusRequestBuilder toBuilder() =>
      ChangeVehicleStatusRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangeVehicleStatusRequest &&
        status == other.status &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangeVehicleStatusRequest')
          ..add('status', status)
          ..add('reason', reason))
        .toString();
  }
}

class ChangeVehicleStatusRequestBuilder
    implements
        Builder<ChangeVehicleStatusRequest, ChangeVehicleStatusRequestBuilder> {
  _$ChangeVehicleStatusRequest? _$v;

  VehicleStatus? _status;
  VehicleStatus? get status => _$this._status;
  set status(VehicleStatus? status) => _$this._status = status;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  ChangeVehicleStatusRequestBuilder() {
    ChangeVehicleStatusRequest._defaults(this);
  }

  ChangeVehicleStatusRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangeVehicleStatusRequest other) {
    _$v = other as _$ChangeVehicleStatusRequest;
  }

  @override
  void update(void Function(ChangeVehicleStatusRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangeVehicleStatusRequest build() => _build();

  _$ChangeVehicleStatusRequest _build() {
    final _$result = _$v ??
        _$ChangeVehicleStatusRequest._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'ChangeVehicleStatusRequest', 'status'),
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'ChangeVehicleStatusRequest', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
