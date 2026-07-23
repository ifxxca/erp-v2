// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_catalog_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccessCatalogResponseData extends AccessCatalogResponseData {
  @override
  final BuiltList<AccessCatalogUser> users;
  @override
  final BuiltList<AccessCatalogRole> roles;

  factory _$AccessCatalogResponseData(
          [void Function(AccessCatalogResponseDataBuilder)? updates]) =>
      (AccessCatalogResponseDataBuilder()..update(updates))._build();

  _$AccessCatalogResponseData._({required this.users, required this.roles})
      : super._();
  @override
  AccessCatalogResponseData rebuild(
          void Function(AccessCatalogResponseDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccessCatalogResponseDataBuilder toBuilder() =>
      AccessCatalogResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccessCatalogResponseData &&
        users == other.users &&
        roles == other.roles;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, users.hashCode);
    _$hash = $jc(_$hash, roles.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccessCatalogResponseData')
          ..add('users', users)
          ..add('roles', roles))
        .toString();
  }
}

class AccessCatalogResponseDataBuilder
    implements
        Builder<AccessCatalogResponseData, AccessCatalogResponseDataBuilder> {
  _$AccessCatalogResponseData? _$v;

  ListBuilder<AccessCatalogUser>? _users;
  ListBuilder<AccessCatalogUser> get users =>
      _$this._users ??= ListBuilder<AccessCatalogUser>();
  set users(ListBuilder<AccessCatalogUser>? users) => _$this._users = users;

  ListBuilder<AccessCatalogRole>? _roles;
  ListBuilder<AccessCatalogRole> get roles =>
      _$this._roles ??= ListBuilder<AccessCatalogRole>();
  set roles(ListBuilder<AccessCatalogRole>? roles) => _$this._roles = roles;

  AccessCatalogResponseDataBuilder() {
    AccessCatalogResponseData._defaults(this);
  }

  AccessCatalogResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _users = $v.users.toBuilder();
      _roles = $v.roles.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccessCatalogResponseData other) {
    _$v = other as _$AccessCatalogResponseData;
  }

  @override
  void update(void Function(AccessCatalogResponseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccessCatalogResponseData build() => _build();

  _$AccessCatalogResponseData _build() {
    _$AccessCatalogResponseData _$result;
    try {
      _$result = _$v ??
          _$AccessCatalogResponseData._(
            users: users.build(),
            roles: roles.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'users';
        users.build();
        _$failedField = 'roles';
        roles.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AccessCatalogResponseData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
