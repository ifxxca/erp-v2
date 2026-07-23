// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class RoleSummaryBuilder {
  void replace(RoleSummary other);
  void update(void Function(RoleSummaryBuilder) updates);
  String? get id;
  set id(String? id);

  String? get code;
  set code(String? code);

  String? get name;
  set name(String? name);
}

class _$$RoleSummary extends $RoleSummary {
  @override
  final String id;
  @override
  final String code;
  @override
  final String name;

  factory _$$RoleSummary([void Function($RoleSummaryBuilder)? updates]) =>
      ($RoleSummaryBuilder()..update(updates))._build();

  _$$RoleSummary._({required this.id, required this.code, required this.name})
      : super._();
  @override
  $RoleSummary rebuild(void Function($RoleSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $RoleSummaryBuilder toBuilder() => $RoleSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $RoleSummary &&
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
    return (newBuiltValueToStringHelper(r'$RoleSummary')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name))
        .toString();
  }
}

class $RoleSummaryBuilder
    implements Builder<$RoleSummary, $RoleSummaryBuilder>, RoleSummaryBuilder {
  _$$RoleSummary? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(covariant String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(covariant String? name) => _$this._name = name;

  $RoleSummaryBuilder() {
    $RoleSummary._defaults(this);
  }

  $RoleSummaryBuilder get _$this {
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
  void replace(covariant $RoleSummary other) {
    _$v = other as _$$RoleSummary;
  }

  @override
  void update(void Function($RoleSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $RoleSummary build() => _build();

  _$$RoleSummary _build() {
    final _$result = _$v ??
        _$$RoleSummary._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'$RoleSummary', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'$RoleSummary', 'code'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'$RoleSummary', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
