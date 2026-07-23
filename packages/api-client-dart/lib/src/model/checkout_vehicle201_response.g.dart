// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_vehicle201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CheckoutVehicle201Response extends CheckoutVehicle201Response {
  @override
  final VehicleTrip? data;

  factory _$CheckoutVehicle201Response(
          [void Function(CheckoutVehicle201ResponseBuilder)? updates]) =>
      (CheckoutVehicle201ResponseBuilder()..update(updates))._build();

  _$CheckoutVehicle201Response._({this.data}) : super._();
  @override
  CheckoutVehicle201Response rebuild(
          void Function(CheckoutVehicle201ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CheckoutVehicle201ResponseBuilder toBuilder() =>
      CheckoutVehicle201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckoutVehicle201Response && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CheckoutVehicle201Response')
          ..add('data', data))
        .toString();
  }
}

class CheckoutVehicle201ResponseBuilder
    implements
        Builder<CheckoutVehicle201Response, CheckoutVehicle201ResponseBuilder> {
  _$CheckoutVehicle201Response? _$v;

  VehicleTripBuilder? _data;
  VehicleTripBuilder get data => _$this._data ??= VehicleTripBuilder();
  set data(VehicleTripBuilder? data) => _$this._data = data;

  CheckoutVehicle201ResponseBuilder() {
    CheckoutVehicle201Response._defaults(this);
  }

  CheckoutVehicle201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckoutVehicle201Response other) {
    _$v = other as _$CheckoutVehicle201Response;
  }

  @override
  void update(void Function(CheckoutVehicle201ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckoutVehicle201Response build() => _build();

  _$CheckoutVehicle201Response _build() {
    _$CheckoutVehicle201Response _$result;
    try {
      _$result = _$v ??
          _$CheckoutVehicle201Response._(
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CheckoutVehicle201Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
