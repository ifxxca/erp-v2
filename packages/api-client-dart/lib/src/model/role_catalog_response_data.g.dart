// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_catalog_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RoleCatalogResponseData extends RoleCatalogResponseData {
  @override
  final BuiltList<ManagedRole> roles;
  @override
  final BuiltList<RoleCatalogPermission> permissions;

  factory _$RoleCatalogResponseData(
          [void Function(RoleCatalogResponseDataBuilder)? updates]) =>
      (RoleCatalogResponseDataBuilder()..update(updates))._build();

  _$RoleCatalogResponseData._({required this.roles, required this.permissions})
      : super._();
  @override
  RoleCatalogResponseData rebuild(
          void Function(RoleCatalogResponseDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoleCatalogResponseDataBuilder toBuilder() =>
      RoleCatalogResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoleCatalogResponseData &&
        roles == other.roles &&
        permissions == other.permissions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roles.hashCode);
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RoleCatalogResponseData')
          ..add('roles', roles)
          ..add('permissions', permissions))
        .toString();
  }
}

class RoleCatalogResponseDataBuilder
    implements
        Builder<RoleCatalogResponseData, RoleCatalogResponseDataBuilder> {
  _$RoleCatalogResponseData? _$v;

  ListBuilder<ManagedRole>? _roles;
  ListBuilder<ManagedRole> get roles =>
      _$this._roles ??= ListBuilder<ManagedRole>();
  set roles(ListBuilder<ManagedRole>? roles) => _$this._roles = roles;

  ListBuilder<RoleCatalogPermission>? _permissions;
  ListBuilder<RoleCatalogPermission> get permissions =>
      _$this._permissions ??= ListBuilder<RoleCatalogPermission>();
  set permissions(ListBuilder<RoleCatalogPermission>? permissions) =>
      _$this._permissions = permissions;

  RoleCatalogResponseDataBuilder() {
    RoleCatalogResponseData._defaults(this);
  }

  RoleCatalogResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roles = $v.roles.toBuilder();
      _permissions = $v.permissions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RoleCatalogResponseData other) {
    _$v = other as _$RoleCatalogResponseData;
  }

  @override
  void update(void Function(RoleCatalogResponseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RoleCatalogResponseData build() => _build();

  _$RoleCatalogResponseData _build() {
    _$RoleCatalogResponseData _$result;
    try {
      _$result = _$v ??
          _$RoleCatalogResponseData._(
            roles: roles.build(),
            permissions: permissions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'roles';
        roles.build();
        _$failedField = 'permissions';
        permissions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RoleCatalogResponseData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
