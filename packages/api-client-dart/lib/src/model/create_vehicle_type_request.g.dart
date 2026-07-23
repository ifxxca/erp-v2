// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_vehicle_type_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateVehicleTypeRequest extends CreateVehicleTypeRequest {
  @override
  final String code;
  @override
  final String name;

  factory _$CreateVehicleTypeRequest(
          [void Function(CreateVehicleTypeRequestBuilder)? updates]) =>
      (CreateVehicleTypeRequestBuilder()..update(updates))._build();

  _$CreateVehicleTypeRequest._({required this.code, required this.name})
      : super._();
  @override
  CreateVehicleTypeRequest rebuild(
          void Function(CreateVehicleTypeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateVehicleTypeRequestBuilder toBuilder() =>
      CreateVehicleTypeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateVehicleTypeRequest &&
        code == other.code &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateVehicleTypeRequest')
          ..add('code', code)
          ..add('name', name))
        .toString();
  }
}

class CreateVehicleTypeRequestBuilder
    implements
        Builder<CreateVehicleTypeRequest, CreateVehicleTypeRequestBuilder> {
  _$CreateVehicleTypeRequest? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CreateVehicleTypeRequestBuilder() {
    CreateVehicleTypeRequest._defaults(this);
  }

  CreateVehicleTypeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateVehicleTypeRequest other) {
    _$v = other as _$CreateVehicleTypeRequest;
  }

  @override
  void update(void Function(CreateVehicleTypeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateVehicleTypeRequest build() => _build();

  _$CreateVehicleTypeRequest _build() {
    final _$result = _$v ??
        _$CreateVehicleTypeRequest._(
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'CreateVehicleTypeRequest', 'code'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'CreateVehicleTypeRequest', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
