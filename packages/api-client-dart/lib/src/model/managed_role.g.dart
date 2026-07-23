// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'managed_role.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ManagedRole extends ManagedRole {
  @override
  final String id;
  @override
  final String code;
  @override
  final String name;
  @override
  final String? description;
  @override
  final bool isSystem;
  @override
  final bool isPrivileged;
  @override
  final RoleAssignmentScope assignmentScope;
  @override
  final BuiltSet<String> permissionIds;
  @override
  final int permissionCount;
  @override
  final int assignmentCount;
  @override
  final int activeAssignmentCount;
  @override
  final bool hasHistory;
  @override
  final bool canEdit;

  factory _$ManagedRole([void Function(ManagedRoleBuilder)? updates]) =>
      (ManagedRoleBuilder()..update(updates))._build();

  _$ManagedRole._(
      {required this.id,
      required this.code,
      required this.name,
      this.description,
      required this.isSystem,
      required this.isPrivileged,
      required this.assignmentScope,
      required this.permissionIds,
      required this.permissionCount,
      required this.assignmentCount,
      required this.activeAssignmentCount,
      required this.hasHistory,
      required this.canEdit})
      : super._();
  @override
  ManagedRole rebuild(void Function(ManagedRoleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ManagedRoleBuilder toBuilder() => ManagedRoleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ManagedRole &&
        id == other.id &&
        code == other.code &&
        name == other.name &&
        description == other.description &&
        isSystem == other.isSystem &&
        isPrivileged == other.isPrivileged &&
        assignmentScope == other.assignmentScope &&
        permissionIds == other.permissionIds &&
        permissionCount == other.permissionCount &&
        assignmentCount == other.assignmentCount &&
        activeAssignmentCount == other.activeAssignmentCount &&
        hasHistory == other.hasHistory &&
        canEdit == other.canEdit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isSystem.hashCode);
    _$hash = $jc(_$hash, isPrivileged.hashCode);
    _$hash = $jc(_$hash, assignmentScope.hashCode);
    _$hash = $jc(_$hash, permissionIds.hashCode);
    _$hash = $jc(_$hash, permissionCount.hashCode);
    _$hash = $jc(_$hash, assignmentCount.hashCode);
    _$hash = $jc(_$hash, activeAssignmentCount.hashCode);
    _$hash = $jc(_$hash, hasHistory.hashCode);
    _$hash = $jc(_$hash, canEdit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ManagedRole')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('description', description)
          ..add('isSystem', isSystem)
          ..add('isPrivileged', isPrivileged)
          ..add('assignmentScope', assignmentScope)
          ..add('permissionIds', permissionIds)
          ..add('permissionCount', permissionCount)
          ..add('assignmentCount', assignmentCount)
          ..add('activeAssignmentCount', activeAssignmentCount)
          ..add('hasHistory', hasHistory)
          ..add('canEdit', canEdit))
        .toString();
  }
}

class ManagedRoleBuilder implements Builder<ManagedRole, ManagedRoleBuilder> {
  _$ManagedRole? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _isSystem;
  bool? get isSystem => _$this._isSystem;
  set isSystem(bool? isSystem) => _$this._isSystem = isSystem;

  bool? _isPrivileged;
  bool? get isPrivileged => _$this._isPrivileged;
  set isPrivileged(bool? isPrivileged) => _$this._isPrivileged = isPrivileged;

  RoleAssignmentScope? _assignmentScope;
  RoleAssignmentScope? get assignmentScope => _$this._assignmentScope;
  set assignmentScope(RoleAssignmentScope? assignmentScope) =>
      _$this._assignmentScope = assignmentScope;

  SetBuilder<String>? _permissionIds;
  SetBuilder<String> get permissionIds =>
      _$this._permissionIds ??= SetBuilder<String>();
  set permissionIds(SetBuilder<String>? permissionIds) =>
      _$this._permissionIds = permissionIds;

  int? _permissionCount;
  int? get permissionCount => _$this._permissionCount;
  set permissionCount(int? permissionCount) =>
      _$this._permissionCount = permissionCount;

  int? _assignmentCount;
  int? get assignmentCount => _$this._assignmentCount;
  set assignmentCount(int? assignmentCount) =>
      _$this._assignmentCount = assignmentCount;

  int? _activeAssignmentCount;
  int? get activeAssignmentCount => _$this._activeAssignmentCount;
  set activeAssignmentCount(int? activeAssignmentCount) =>
      _$this._activeAssignmentCount = activeAssignmentCount;

  bool? _hasHistory;
  bool? get hasHistory => _$this._hasHistory;
  set hasHistory(bool? hasHistory) => _$this._hasHistory = hasHistory;

  bool? _canEdit;
  bool? get canEdit => _$this._canEdit;
  set canEdit(bool? canEdit) => _$this._canEdit = canEdit;

  ManagedRoleBuilder() {
    ManagedRole._defaults(this);
  }

  ManagedRoleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _description = $v.description;
      _isSystem = $v.isSystem;
      _isPrivileged = $v.isPrivileged;
      _assignmentScope = $v.assignmentScope;
      _permissionIds = $v.permissionIds.toBuilder();
      _permissionCount = $v.permissionCount;
      _assignmentCount = $v.assignmentCount;
      _activeAssignmentCount = $v.activeAssignmentCount;
      _hasHistory = $v.hasHistory;
      _canEdit = $v.canEdit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ManagedRole other) {
    _$v = other as _$ManagedRole;
  }

  @override
  void update(void Function(ManagedRoleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ManagedRole build() => _build();

  _$ManagedRole _build() {
    _$ManagedRole _$result;
    try {
      _$result = _$v ??
          _$ManagedRole._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'ManagedRole', 'id'),
            code: BuiltValueNullFieldError.checkNotNull(
                code, r'ManagedRole', 'code'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'ManagedRole', 'name'),
            description: description,
            isSystem: BuiltValueNullFieldError.checkNotNull(
                isSystem, r'ManagedRole', 'isSystem'),
            isPrivileged: BuiltValueNullFieldError.checkNotNull(
                isPrivileged, r'ManagedRole', 'isPrivileged'),
            assignmentScope: BuiltValueNullFieldError.checkNotNull(
                assignmentScope, r'ManagedRole', 'assignmentScope'),
            permissionIds: permissionIds.build(),
            permissionCount: BuiltValueNullFieldError.checkNotNull(
                permissionCount, r'ManagedRole', 'permissionCount'),
            assignmentCount: BuiltValueNullFieldError.checkNotNull(
                assignmentCount, r'ManagedRole', 'assignmentCount'),
            activeAssignmentCount: BuiltValueNullFieldError.checkNotNull(
                activeAssignmentCount, r'ManagedRole', 'activeAssignmentCount'),
            hasHistory: BuiltValueNullFieldError.checkNotNull(
                hasHistory, r'ManagedRole', 'hasHistory'),
            canEdit: BuiltValueNullFieldError.checkNotNull(
                canEdit, r'ManagedRole', 'canEdit'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'permissionIds';
        permissionIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ManagedRole', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
