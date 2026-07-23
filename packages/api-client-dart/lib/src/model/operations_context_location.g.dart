// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations_context_location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OperationsContextLocation extends OperationsContextLocation {
  @override
  final String id;
  @override
  final String code;
  @override
  final String name;
  @override
  final String timezone;

  factory _$OperationsContextLocation(
          [void Function(OperationsContextLocationBuilder)? updates]) =>
      (OperationsContextLocationBuilder()..update(updates))._build();

  _$OperationsContextLocation._(
      {required this.id,
      required this.code,
      required this.name,
      required this.timezone})
      : super._();
  @override
  OperationsContextLocation rebuild(
          void Function(OperationsContextLocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OperationsContextLocationBuilder toBuilder() =>
      OperationsContextLocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OperationsContextLocation &&
        id == other.id &&
        code == other.code &&
        name == other.name &&
        timezone == other.timezone;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, timezone.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OperationsContextLocation')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('timezone', timezone))
        .toString();
  }
}

class OperationsContextLocationBuilder
    implements
        Builder<OperationsContextLocation, OperationsContextLocationBuilder> {
  _$OperationsContextLocation? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _timezone;
  String? get timezone => _$this._timezone;
  set timezone(String? timezone) => _$this._timezone = timezone;

  OperationsContextLocationBuilder() {
    OperationsContextLocation._defaults(this);
  }

  OperationsContextLocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _timezone = $v.timezone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OperationsContextLocation other) {
    _$v = other as _$OperationsContextLocation;
  }

  @override
  void update(void Function(OperationsContextLocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OperationsContextLocation build() => _build();

  _$OperationsContextLocation _build() {
    final _$result = _$v ??
        _$OperationsContextLocation._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'OperationsContextLocation', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'OperationsContextLocation', 'code'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'OperationsContextLocation', 'name'),
          timezone: BuiltValueNullFieldError.checkNotNull(
              timezone, r'OperationsContextLocation', 'timezone'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
