// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IdentityUser extends IdentityUser {
  @override
  final DateTime? lastLoginAt;
  @override
  final BuiltList<CompanyMembership> companyMemberships;
  @override
  final BuiltList<DepartmentMembership> departmentMemberships;
  @override
  final BuiltList<LocationMembership> locationMemberships;
  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final IdentityStatus status;

  factory _$IdentityUser([void Function(IdentityUserBuilder)? updates]) =>
      (IdentityUserBuilder()..update(updates))._build();

  _$IdentityUser._(
      {this.lastLoginAt,
      required this.companyMemberships,
      required this.departmentMemberships,
      required this.locationMemberships,
      required this.id,
      required this.name,
      required this.email,
      required this.status})
      : super._();
  @override
  IdentityUser rebuild(void Function(IdentityUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IdentityUserBuilder toBuilder() => IdentityUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IdentityUser &&
        lastLoginAt == other.lastLoginAt &&
        companyMemberships == other.companyMemberships &&
        departmentMemberships == other.departmentMemberships &&
        locationMemberships == other.locationMemberships &&
        id == other.id &&
        name == other.name &&
        email == other.email &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, lastLoginAt.hashCode);
    _$hash = $jc(_$hash, companyMemberships.hashCode);
    _$hash = $jc(_$hash, departmentMemberships.hashCode);
    _$hash = $jc(_$hash, locationMemberships.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IdentityUser')
          ..add('lastLoginAt', lastLoginAt)
          ..add('companyMemberships', companyMemberships)
          ..add('departmentMemberships', departmentMemberships)
          ..add('locationMemberships', locationMemberships)
          ..add('id', id)
          ..add('name', name)
          ..add('email', email)
          ..add('status', status))
        .toString();
  }
}

class IdentityUserBuilder
    implements
        Builder<IdentityUser, IdentityUserBuilder>,
        IdentitySummaryBuilder {
  _$IdentityUser? _$v;

  DateTime? _lastLoginAt;
  DateTime? get lastLoginAt => _$this._lastLoginAt;
  set lastLoginAt(covariant DateTime? lastLoginAt) =>
      _$this._lastLoginAt = lastLoginAt;

  ListBuilder<CompanyMembership>? _companyMemberships;
  ListBuilder<CompanyMembership> get companyMemberships =>
      _$this._companyMemberships ??= ListBuilder<CompanyMembership>();
  set companyMemberships(
          covariant ListBuilder<CompanyMembership>? companyMemberships) =>
      _$this._companyMemberships = companyMemberships;

  ListBuilder<DepartmentMembership>? _departmentMemberships;
  ListBuilder<DepartmentMembership> get departmentMemberships =>
      _$this._departmentMemberships ??= ListBuilder<DepartmentMembership>();
  set departmentMemberships(
          covariant ListBuilder<DepartmentMembership>? departmentMemberships) =>
      _$this._departmentMemberships = departmentMemberships;

  ListBuilder<LocationMembership>? _locationMemberships;
  ListBuilder<LocationMembership> get locationMemberships =>
      _$this._locationMemberships ??= ListBuilder<LocationMembership>();
  set locationMemberships(
          covariant ListBuilder<LocationMembership>? locationMemberships) =>
      _$this._locationMemberships = locationMemberships;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(covariant String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(covariant String? email) => _$this._email = email;

  IdentityStatus? _status;
  IdentityStatus? get status => _$this._status;
  set status(covariant IdentityStatus? status) => _$this._status = status;

  IdentityUserBuilder() {
    IdentityUser._defaults(this);
  }

  IdentityUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lastLoginAt = $v.lastLoginAt;
      _companyMemberships = $v.companyMemberships.toBuilder();
      _departmentMemberships = $v.departmentMemberships.toBuilder();
      _locationMemberships = $v.locationMemberships.toBuilder();
      _id = $v.id;
      _name = $v.name;
      _email = $v.email;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant IdentityUser other) {
    _$v = other as _$IdentityUser;
  }

  @override
  void update(void Function(IdentityUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IdentityUser build() => _build();

  _$IdentityUser _build() {
    _$IdentityUser _$result;
    try {
      _$result = _$v ??
          _$IdentityUser._(
            lastLoginAt: lastLoginAt,
            companyMemberships: companyMemberships.build(),
            departmentMemberships: departmentMemberships.build(),
            locationMemberships: locationMemberships.build(),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'IdentityUser', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'IdentityUser', 'name'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'IdentityUser', 'email'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'IdentityUser', 'status'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'companyMemberships';
        companyMemberships.build();
        _$failedField = 'departmentMemberships';
        departmentMemberships.build();
        _$failedField = 'locationMemberships';
        locationMemberships.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'IdentityUser', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
