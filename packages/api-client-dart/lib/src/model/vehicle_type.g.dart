// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VehicleType extends VehicleType {
  @override
  final String id;
  @override
  final String code;
  @override
  final String name;

  factory _$VehicleType([void Function(VehicleTypeBuilder)? updates]) =>
      (VehicleTypeBuilder()..update(updates))._build();

  _$VehicleType._({required this.id, required this.code, required this.name})
      : super._();
  @override
  VehicleType rebuild(void Function(VehicleTypeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VehicleTypeBuilder toBuilder() => VehicleTypeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VehicleType &&
        id == other.id &&
        code == other.code &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VehicleType')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name))
        .toString();
  }
}

class VehicleTypeBuilder implements Builder<VehicleType, VehicleTypeBuilder> {
  _$VehicleType? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  VehicleTypeBuilder() {
    VehicleType._defaults(this);
  }

  VehicleTypeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VehicleType other) {
    _$v = other as _$VehicleType;
  }

  @override
  void update(void Function(VehicleTypeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VehicleType build() => _build();

  _$VehicleType _build() {
    final _$result = _$v ??
        _$VehicleType._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'VehicleType', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'VehicleType', 'code'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'VehicleType', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
