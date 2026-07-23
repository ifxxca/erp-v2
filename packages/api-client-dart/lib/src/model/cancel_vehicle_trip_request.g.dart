// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_vehicle_trip_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CancelVehicleTripRequest extends CancelVehicleTripRequest {
  @override
  final String reason;

  factory _$CancelVehicleTripRequest(
          [void Function(CancelVehicleTripRequestBuilder)? updates]) =>
      (CancelVehicleTripRequestBuilder()..update(updates))._build();

  _$CancelVehicleTripRequest._({required this.reason}) : super._();
  @override
  CancelVehicleTripRequest rebuild(
          void Function(CancelVehicleTripRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CancelVehicleTripRequestBuilder toBuilder() =>
      CancelVehicleTripRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CancelVehicleTripRequest && reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CancelVehicleTripRequest')
          ..add('reason', reason))
        .toString();
  }
}

class CancelVehicleTripRequestBuilder
    implements
        Builder<CancelVehicleTripRequest, CancelVehicleTripRequestBuilder> {
  _$CancelVehicleTripRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  CancelVehicleTripRequestBuilder() {
    CancelVehicleTripRequest._defaults(this);
  }

  CancelVehicleTripRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CancelVehicleTripRequest other) {
    _$v = other as _$CancelVehicleTripRequest;
  }

  @override
  void update(void Function(CancelVehicleTripRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CancelVehicleTripRequest build() => _build();

  _$CancelVehicleTripRequest _build() {
    final _$result = _$v ??
        _$CancelVehicleTripRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'CancelVehicleTripRequest', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
