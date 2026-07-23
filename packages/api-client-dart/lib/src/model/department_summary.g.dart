// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DepartmentSummary extends DepartmentSummary {
  @override
  final String id;
  @override
  final String code;
  @override
  final String name;
  @override
  final String? parentId;

  factory _$DepartmentSummary(
          [void Function(DepartmentSummaryBuilder)? updates]) =>
      (DepartmentSummaryBuilder()..update(updates))._build();

  _$DepartmentSummary._(
      {required this.id, required this.code, required this.name, this.parentId})
      : super._();
  @override
  DepartmentSummary rebuild(void Function(DepartmentSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepartmentSummaryBuilder toBuilder() =>
      DepartmentSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepartmentSummary &&
        id == other.id &&
        code == other.code &&
        name == other.name &&
        parentId == other.parentId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, parentId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DepartmentSummary')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('parentId', parentId))
        .toString();
  }
}

class DepartmentSummaryBuilder
    implements Builder<DepartmentSummary, DepartmentSummaryBuilder> {
  _$DepartmentSummary? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _parentId;
  String? get parentId => _$this._parentId;
  set parentId(String? parentId) => _$this._parentId = parentId;

  DepartmentSummaryBuilder() {
    DepartmentSummary._defaults(this);
  }

  DepartmentSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _parentId = $v.parentId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepartmentSummary other) {
    _$v = other as _$DepartmentSummary;
  }

  @override
  void update(void Function(DepartmentSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepartmentSummary build() => _build();

  _$DepartmentSummary _build() {
    final _$result = _$v ??
        _$DepartmentSummary._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'DepartmentSummary', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'DepartmentSummary', 'code'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'DepartmentSummary', 'name'),
          parentId: parentId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
