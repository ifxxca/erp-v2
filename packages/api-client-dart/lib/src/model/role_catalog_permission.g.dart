// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_catalog_permission.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RoleCatalogPermission extends RoleCatalogPermission {
  @override
  final bool globalOnly;
  @override
  final String id;
  @override
  final String code;
  @override
  final String module;
  @override
  final String resource;
  @override
  final String action;
  @override
  final String? description;

  factory _$RoleCatalogPermission(
          [void Function(RoleCatalogPermissionBuilder)? updates]) =>
      (RoleCatalogPermissionBuilder()..update(updates))._build();

  _$RoleCatalogPermission._(
      {required this.globalOnly,
      required this.id,
      required this.code,
      required this.module,
      required this.resource,
      required this.action,
      this.description})
      : super._();
  @override
  RoleCatalogPermission rebuild(
          void Function(RoleCatalogPermissionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoleCatalogPermissionBuilder toBuilder() =>
      RoleCatalogPermissionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoleCatalogPermission &&
        globalOnly == other.globalOnly &&
        id == other.id &&
        code == other.code &&
        module == other.module &&
        resource == other.resource &&
        action == other.action &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, globalOnly.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, module.hashCode);
    _$hash = $jc(_$hash, resource.hashCode);
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RoleCatalogPermission')
          ..add('globalOnly', globalOnly)
          ..add('id', id)
          ..add('code', code)
          ..add('module', module)
          ..add('resource', resource)
          ..add('action', action)
          ..add('description', description))
        .toString();
  }
}

class RoleCatalogPermissionBuilder
    implements
        Builder<RoleCatalogPermission, RoleCatalogPermissionBuilder>,
        RolePermissionSummaryBuilder {
  _$RoleCatalogPermission? _$v;

  bool? _globalOnly;
  bool? get globalOnly => _$this._globalOnly;
  set globalOnly(covariant bool? globalOnly) => _$this._globalOnly = globalOnly;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(covariant String? code) => _$this._code = code;

  String? _module;
  String? get module => _$this._module;
  set module(covariant String? module) => _$this._module = module;

  String? _resource;
  String? get resource => _$this._resource;
  set resource(covariant String? resource) => _$this._resource = resource;

  String? _action;
  String? get action => _$this._action;
  set action(covariant String? action) => _$this._action = action;

  String? _description;
  String? get description => _$this._description;
  set description(covariant String? description) =>
      _$this._description = description;

  RoleCatalogPermissionBuilder() {
    RoleCatalogPermission._defaults(this);
  }

  RoleCatalogPermissionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _globalOnly = $v.globalOnly;
      _id = $v.id;
      _code = $v.code;
      _module = $v.module;
      _resource = $v.resource;
      _action = $v.action;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant RoleCatalogPermission other) {
    _$v = other as _$RoleCatalogPermission;
  }

  @override
  void update(void Function(RoleCatalogPermissionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RoleCatalogPermission build() => _build();

  _$RoleCatalogPermission _build() {
    final _$result = _$v ??
        _$RoleCatalogPermission._(
          globalOnly: BuiltValueNullFieldError.checkNotNull(
              globalOnly, r'RoleCatalogPermission', 'globalOnly'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'RoleCatalogPermission', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'RoleCatalogPermission', 'code'),
          module: BuiltValueNullFieldError.checkNotNull(
              module, r'RoleCatalogPermission', 'module'),
          resource: BuiltValueNullFieldError.checkNotNull(
              resource, r'RoleCatalogPermission', 'resource'),
          action: BuiltValueNullFieldError.checkNotNull(
              action, r'RoleCatalogPermission', 'action'),
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
