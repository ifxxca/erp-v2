// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privileged_role_assignment_role.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrivilegedRoleAssignmentRole extends PrivilegedRoleAssignmentRole {
  @override
  final RoleAssignmentScope assignmentScope;
  @override
  final String id;
  @override
  final String code;
  @override
  final String name;

  factory _$PrivilegedRoleAssignmentRole(
          [void Function(PrivilegedRoleAssignmentRoleBuilder)? updates]) =>
      (PrivilegedRoleAssignmentRoleBuilder()..update(updates))._build();

  _$PrivilegedRoleAssignmentRole._(
      {required this.assignmentScope,
      required this.id,
      required this.code,
      required this.name})
      : super._();
  @override
  PrivilegedRoleAssignmentRole rebuild(
          void Function(PrivilegedRoleAssignmentRoleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivilegedRoleAssignmentRoleBuilder toBuilder() =>
      PrivilegedRoleAssignmentRoleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivilegedRoleAssignmentRole &&
        assignmentScope == other.assignmentScope &&
        id == other.id &&
        code == other.code &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assignmentScope.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrivilegedRoleAssignmentRole')
          ..add('assignmentScope', assignmentScope)
          ..add('id', id)
          ..add('code', code)
          ..add('name', name))
        .toString();
  }
}

class PrivilegedRoleAssignmentRoleBuilder
    implements
        Builder<PrivilegedRoleAssignmentRole,
            PrivilegedRoleAssignmentRoleBuilder>,
        RoleSummaryBuilder {
  _$PrivilegedRoleAssignmentRole? _$v;

  RoleAssignmentScope? _assignmentScope;
  RoleAssignmentScope? get assignmentScope => _$this._assignmentScope;
  set assignmentScope(covariant RoleAssignmentScope? assignmentScope) =>
      _$this._assignmentScope = assignmentScope;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(covariant String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(covariant String? name) => _$this._name = name;

  PrivilegedRoleAssignmentRoleBuilder() {
    PrivilegedRoleAssignmentRole._defaults(this);
  }

  PrivilegedRoleAssignmentRoleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assignmentScope = $v.assignmentScope;
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant PrivilegedRoleAssignmentRole other) {
    _$v = other as _$PrivilegedRoleAssignmentRole;
  }

  @override
  void update(void Function(PrivilegedRoleAssignmentRoleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrivilegedRoleAssignmentRole build() => _build();

  _$PrivilegedRoleAssignmentRole _build() {
    final _$result = _$v ??
        _$PrivilegedRoleAssignmentRole._(
          assignmentScope: BuiltValueNullFieldError.checkNotNull(
              assignmentScope,
              r'PrivilegedRoleAssignmentRole',
              'assignmentScope'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'PrivilegedRoleAssignmentRole', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'PrivilegedRoleAssignmentRole', 'code'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'PrivilegedRoleAssignmentRole', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
