// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_vehicle_types200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListVehicleTypes200Response extends ListVehicleTypes200Response {
  @override
  final BuiltList<VehicleType> data;

  factory _$ListVehicleTypes200Response(
          [void Function(ListVehicleTypes200ResponseBuilder)? updates]) =>
      (ListVehicleTypes200ResponseBuilder()..update(updates))._build();

  _$ListVehicleTypes200Response._({required this.data}) : super._();
  @override
  ListVehicleTypes200Response rebuild(
          void Function(ListVehicleTypes200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListVehicleTypes200ResponseBuilder toBuilder() =>
      ListVehicleTypes200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListVehicleTypes200Response && data == other.data;
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
    return (newBuiltValueToStringHelper(r'ListVehicleTypes200Response')
          ..add('data', data))
        .toString();
  }
}

class ListVehicleTypes200ResponseBuilder
    implements
        Builder<ListVehicleTypes200Response,
            ListVehicleTypes200ResponseBuilder> {
  _$ListVehicleTypes200Response? _$v;

  ListBuilder<VehicleType>? _data;
  ListBuilder<VehicleType> get data =>
      _$this._data ??= ListBuilder<VehicleType>();
  set data(ListBuilder<VehicleType>? data) => _$this._data = data;

  ListVehicleTypes200ResponseBuilder() {
    ListVehicleTypes200Response._defaults(this);
  }

  ListVehicleTypes200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListVehicleTypes200Response other) {
    _$v = other as _$ListVehicleTypes200Response;
  }

  @override
  void update(void Function(ListVehicleTypes200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListVehicleTypes200Response build() => _build();

  _$ListVehicleTypes200Response _build() {
    _$ListVehicleTypes200Response _$result;
    try {
      _$result = _$v ??
          _$ListVehicleTypes200Response._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ListVehicleTypes200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
