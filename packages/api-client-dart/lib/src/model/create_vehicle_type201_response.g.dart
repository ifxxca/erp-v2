// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_vehicle_type201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateVehicleType201Response extends CreateVehicleType201Response {
  @override
  final VehicleType? data;

  factory _$CreateVehicleType201Response(
          [void Function(CreateVehicleType201ResponseBuilder)? updates]) =>
      (CreateVehicleType201ResponseBuilder()..update(updates))._build();

  _$CreateVehicleType201Response._({this.data}) : super._();
  @override
  CreateVehicleType201Response rebuild(
          void Function(CreateVehicleType201ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateVehicleType201ResponseBuilder toBuilder() =>
      CreateVehicleType201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateVehicleType201Response && data == other.data;
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
    return (newBuiltValueToStringHelper(r'CreateVehicleType201Response')
          ..add('data', data))
        .toString();
  }
}

class CreateVehicleType201ResponseBuilder
    implements
        Builder<CreateVehicleType201Response,
            CreateVehicleType201ResponseBuilder> {
  _$CreateVehicleType201Response? _$v;

  VehicleTypeBuilder? _data;
  VehicleTypeBuilder get data => _$this._data ??= VehicleTypeBuilder();
  set data(VehicleTypeBuilder? data) => _$this._data = data;

  CreateVehicleType201ResponseBuilder() {
    CreateVehicleType201Response._defaults(this);
  }

  CreateVehicleType201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateVehicleType201Response other) {
    _$v = other as _$CreateVehicleType201Response;
  }

  @override
  void update(void Function(CreateVehicleType201ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateVehicleType201Response build() => _build();

  _$CreateVehicleType201Response _build() {
    _$CreateVehicleType201Response _$result;
    try {
      _$result = _$v ??
          _$CreateVehicleType201Response._(
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateVehicleType201Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
