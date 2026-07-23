// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_permission_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class RolePermissionSummaryBuilder {
  void replace(RolePermissionSummary other);
  void update(void Function(RolePermissionSummaryBuilder) updates);
  String? get id;
  set id(String? id);

  String? get code;
  set code(String? code);

  String? get module;
  set module(String? module);

  String? get resource;
  set resource(String? resource);

  String? get action;
  set action(String? action);

  String? get description;
  set description(String? description);
}

class _$$RolePermissionSummary extends $RolePermissionSummary {
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

  factory _$$RolePermissionSummary(
          [void Function($RolePermissionSummaryBuilder)? updates]) =>
      ($RolePermissionSummaryBuilder()..update(updates))._build();

  _$$RolePermissionSummary._(
      {required this.id,
      required this.code,
      required this.module,
      required this.resource,
      required this.action,
      this.description})
      : super._();
  @override
  $RolePermissionSummary rebuild(
          void Function($RolePermissionSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $RolePermissionSummaryBuilder toBuilder() =>
      $RolePermissionSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $RolePermissionSummary &&
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
    return (newBuiltValueToStringHelper(r'$RolePermissionSummary')
          ..add('id', id)
          ..add('code', code)
          ..add('module', module)
          ..add('resource', resource)
          ..add('action', action)
          ..add('description', description))
        .toString();
  }
}

class $RolePermissionSummaryBuilder
    implements
        Builder<$RolePermissionSummary, $RolePermissionSummaryBuilder>,
        RolePermissionSummaryBuilder {
  _$$RolePermissionSummary? _$v;

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

  $RolePermissionSummaryBuilder() {
    $RolePermissionSummary._defaults(this);
  }

  $RolePermissionSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(covariant $RolePermissionSummary other) {
    _$v = other as _$$RolePermissionSummary;
  }

  @override
  void update(void Function($RolePermissionSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $RolePermissionSummary build() => _build();

  _$$RolePermissionSummary _build() {
    final _$result = _$v ??
        _$$RolePermissionSummary._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'$RolePermissionSummary', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'$RolePermissionSummary', 'code'),
          module: BuiltValueNullFieldError.checkNotNull(
              module, r'$RolePermissionSummary', 'module'),
          resource: BuiltValueNullFieldError.checkNotNull(
              resource, r'$RolePermissionSummary', 'resource'),
          action: BuiltValueNullFieldError.checkNotNull(
              action, r'$RolePermissionSummary', 'action'),
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
