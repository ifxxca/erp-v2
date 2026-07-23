// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_vehicle201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateVehicle201Response extends CreateVehicle201Response {
  @override
  final Vehicle? data;

  factory _$CreateVehicle201Response(
          [void Function(CreateVehicle201ResponseBuilder)? updates]) =>
      (CreateVehicle201ResponseBuilder()..update(updates))._build();

  _$CreateVehicle201Response._({this.data}) : super._();
  @override
  CreateVehicle201Response rebuild(
          void Function(CreateVehicle201ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateVehicle201ResponseBuilder toBuilder() =>
      CreateVehicle201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateVehicle201Response && data == other.data;
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
    return (newBuiltValueToStringHelper(r'CreateVehicle201Response')
          ..add('data', data))
        .toString();
  }
}

class CreateVehicle201ResponseBuilder
    implements
        Builder<CreateVehicle201Response, CreateVehicle201ResponseBuilder> {
  _$CreateVehicle201Response? _$v;

  VehicleBuilder? _data;
  VehicleBuilder get data => _$this._data ??= VehicleBuilder();
  set data(VehicleBuilder? data) => _$this._data = data;

  CreateVehicle201ResponseBuilder() {
    CreateVehicle201Response._defaults(this);
  }

  CreateVehicle201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateVehicle201Response other) {
    _$v = other as _$CreateVehicle201Response;
  }

  @override
  void update(void Function(CreateVehicle201ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateVehicle201Response build() => _build();

  _$CreateVehicle201Response _build() {
    _$CreateVehicle201Response _$result;
    try {
      _$result = _$v ??
          _$CreateVehicle201Response._(
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateVehicle201Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
