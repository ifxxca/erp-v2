// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_mutation_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RoleMutationResponseData extends RoleMutationResponseData {
  @override
  final bool isSystem;
  @override
  final bool isPrivileged;
  @override
  final BuiltList<RolePermissionSummary> permissions;
  @override
  final String? description;
  @override
  final RoleAssignmentScope assignmentScope;
  @override
  final String id;
  @override
  final String code;
  @override
  final String name;

  factory _$RoleMutationResponseData(
          [void Function(RoleMutationResponseDataBuilder)? updates]) =>
      (RoleMutationResponseDataBuilder()..update(updates))._build();

  _$RoleMutationResponseData._(
      {required this.isSystem,
      required this.isPrivileged,
      required this.permissions,
      this.description,
      required this.assignmentScope,
      required this.id,
      required this.code,
      required this.name})
      : super._();
  @override
  RoleMutationResponseData rebuild(
          void Function(RoleMutationResponseDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoleMutationResponseDataBuilder toBuilder() =>
      RoleMutationResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoleMutationResponseData &&
        isSystem == other.isSystem &&
        isPrivileged == other.isPrivileged &&
        permissions == other.permissions &&
        description == other.description &&
        assignmentScope == other.assignmentScope &&
        id == other.id &&
        code == other.code &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isSystem.hashCode);
    _$hash = $jc(_$hash, isPrivileged.hashCode);
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, assignmentScope.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RoleMutationResponseData')
          ..add('isSystem', isSystem)
          ..add('isPrivileged', isPrivileged)
          ..add('permissions', permissions)
          ..add('description', description)
          ..add('assignmentScope', assignmentScope)
          ..add('id', id)
          ..add('code', code)
          ..add('name', name))
        .toString();
  }
}

class RoleMutationResponseDataBuilder
    implements
        Builder<RoleMutationResponseData, RoleMutationResponseDataBuilder>,
        RoleSummaryBuilder {
  _$RoleMutationResponseData? _$v;

  bool? _isSystem;
  bool? get isSystem => _$this._isSystem;
  set isSystem(covariant bool? isSystem) => _$this._isSystem = isSystem;

  bool? _isPrivileged;
  bool? get isPrivileged => _$this._isPrivileged;
  set isPrivileged(covariant bool? isPrivileged) =>
      _$this._isPrivileged = isPrivileged;

  ListBuilder<RolePermissionSummary>? _permissions;
  ListBuilder<RolePermissionSummary> get permissions =>
      _$this._permissions ??= ListBuilder<RolePermissionSummary>();
  set permissions(covariant ListBuilder<RolePermissionSummary>? permissions) =>
      _$this._permissions = permissions;

  String? _description;
  String? get description => _$this._description;
  set description(covariant String? description) =>
      _$this._description = description;

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

  RoleMutationResponseDataBuilder() {
    RoleMutationResponseData._defaults(this);
  }

  RoleMutationResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isSystem = $v.isSystem;
      _isPrivileged = $v.isPrivileged;
      _permissions = $v.permissions.toBuilder();
      _description = $v.description;
      _assignmentScope = $v.assignmentScope;
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant RoleMutationResponseData other) {
    _$v = other as _$RoleMutationResponseData;
  }

  @override
  void update(void Function(RoleMutationResponseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RoleMutationResponseData build() => _build();

  _$RoleMutationResponseData _build() {
    _$RoleMutationResponseData _$result;
    try {
      _$result = _$v ??
          _$RoleMutationResponseData._(
            isSystem: BuiltValueNullFieldError.checkNotNull(
                isSystem, r'RoleMutationResponseData', 'isSystem'),
            isPrivileged: BuiltValueNullFieldError.checkNotNull(
                isPrivileged, r'RoleMutationResponseData', 'isPrivileged'),
            permissions: permissions.build(),
            description: description,
            assignmentScope: BuiltValueNullFieldError.checkNotNull(
                assignmentScope,
                r'RoleMutationResponseData',
                'assignmentScope'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'RoleMutationResponseData', 'id'),
            code: BuiltValueNullFieldError.checkNotNull(
                code, r'RoleMutationResponseData', 'code'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'RoleMutationResponseData', 'name'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'permissions';
        permissions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RoleMutationResponseData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
