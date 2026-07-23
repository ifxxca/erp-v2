// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_catalog_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccessCatalogUser extends AccessCatalogUser {
  @override
  final BuiltSet<String> locationIds;
  @override
  final bool mfaEnabled;
  @override
  final BuiltSet<String> departmentIds;
  @override
  final String id;
  @override
  final String name;
  @override
  final String? email;

  factory _$AccessCatalogUser(
          [void Function(AccessCatalogUserBuilder)? updates]) =>
      (AccessCatalogUserBuilder()..update(updates))._build();

  _$AccessCatalogUser._(
      {required this.locationIds,
      required this.mfaEnabled,
      required this.departmentIds,
      required this.id,
      required this.name,
      this.email})
      : super._();
  @override
  AccessCatalogUser rebuild(void Function(AccessCatalogUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccessCatalogUserBuilder toBuilder() =>
      AccessCatalogUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccessCatalogUser &&
        locationIds == other.locationIds &&
        mfaEnabled == other.mfaEnabled &&
        departmentIds == other.departmentIds &&
        id == other.id &&
        name == other.name &&
        email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, locationIds.hashCode);
    _$hash = $jc(_$hash, mfaEnabled.hashCode);
    _$hash = $jc(_$hash, departmentIds.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccessCatalogUser')
          ..add('locationIds', locationIds)
          ..add('mfaEnabled', mfaEnabled)
          ..add('departmentIds', departmentIds)
          ..add('id', id)
          ..add('name', name)
          ..add('email', email))
        .toString();
  }
}

class AccessCatalogUserBuilder
    implements
        Builder<AccessCatalogUser, AccessCatalogUserBuilder>,
        UserSummaryBuilder {
  _$AccessCatalogUser? _$v;

  SetBuilder<String>? _locationIds;
  SetBuilder<String> get locationIds =>
      _$this._locationIds ??= SetBuilder<String>();
  set locationIds(covariant SetBuilder<String>? locationIds) =>
      _$this._locationIds = locationIds;

  bool? _mfaEnabled;
  bool? get mfaEnabled => _$this._mfaEnabled;
  set mfaEnabled(covariant bool? mfaEnabled) => _$this._mfaEnabled = mfaEnabled;

  SetBuilder<String>? _departmentIds;
  SetBuilder<String> get departmentIds =>
      _$this._departmentIds ??= SetBuilder<String>();
  set departmentIds(covariant SetBuilder<String>? departmentIds) =>
      _$this._departmentIds = departmentIds;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(covariant String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(covariant String? email) => _$this._email = email;

  AccessCatalogUserBuilder() {
    AccessCatalogUser._defaults(this);
  }

  AccessCatalogUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _locationIds = $v.locationIds.toBuilder();
      _mfaEnabled = $v.mfaEnabled;
      _departmentIds = $v.departmentIds.toBuilder();
      _id = $v.id;
      _name = $v.name;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant AccessCatalogUser other) {
    _$v = other as _$AccessCatalogUser;
  }

  @override
  void update(void Function(AccessCatalogUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccessCatalogUser build() => _build();

  _$AccessCatalogUser _build() {
    _$AccessCatalogUser _$result;
    try {
      _$result = _$v ??
          _$AccessCatalogUser._(
            locationIds: locationIds.build(),
            mfaEnabled: BuiltValueNullFieldError.checkNotNull(
                mfaEnabled, r'AccessCatalogUser', 'mfaEnabled'),
            departmentIds: departmentIds.build(),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'AccessCatalogUser', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'AccessCatalogUser', 'name'),
            email: email,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'locationIds';
        locationIds.build();

        _$failedField = 'departmentIds';
        departmentIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AccessCatalogUser', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
