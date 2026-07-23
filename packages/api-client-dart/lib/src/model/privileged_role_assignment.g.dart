// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privileged_role_assignment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrivilegedRoleAssignment extends PrivilegedRoleAssignment {
  @override
  final String id;
  @override
  final UserSummary user;
  @override
  final PrivilegedRoleAssignmentRole role;
  @override
  final String companyId;
  @override
  final String? departmentId;
  @override
  final String? locationId;
  @override
  final String? accessRequestId;
  @override
  final DateTime validFrom;
  @override
  final DateTime? validUntil;

  factory _$PrivilegedRoleAssignment(
          [void Function(PrivilegedRoleAssignmentBuilder)? updates]) =>
      (PrivilegedRoleAssignmentBuilder()..update(updates))._build();

  _$PrivilegedRoleAssignment._(
      {required this.id,
      required this.user,
      required this.role,
      required this.companyId,
      this.departmentId,
      this.locationId,
      this.accessRequestId,
      required this.validFrom,
      this.validUntil})
      : super._();
  @override
  PrivilegedRoleAssignment rebuild(
          void Function(PrivilegedRoleAssignmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivilegedRoleAssignmentBuilder toBuilder() =>
      PrivilegedRoleAssignmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivilegedRoleAssignment &&
        id == other.id &&
        user == other.user &&
        role == other.role &&
        companyId == other.companyId &&
        departmentId == other.departmentId &&
        locationId == other.locationId &&
        accessRequestId == other.accessRequestId &&
        validFrom == other.validFrom &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, companyId.hashCode);
    _$hash = $jc(_$hash, departmentId.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, accessRequestId.hashCode);
    _$hash = $jc(_$hash, validFrom.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrivilegedRoleAssignment')
          ..add('id', id)
          ..add('user', user)
          ..add('role', role)
          ..add('companyId', companyId)
          ..add('departmentId', departmentId)
          ..add('locationId', locationId)
          ..add('accessRequestId', accessRequestId)
          ..add('validFrom', validFrom)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class PrivilegedRoleAssignmentBuilder
    implements
        Builder<PrivilegedRoleAssignment, PrivilegedRoleAssignmentBuilder> {
  _$PrivilegedRoleAssignment? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  UserSummary? _user;
  UserSummary? get user => _$this._user;
  set user(UserSummary? user) => _$this._user = user;

  PrivilegedRoleAssignmentRoleBuilder? _role;
  PrivilegedRoleAssignmentRoleBuilder get role =>
      _$this._role ??= PrivilegedRoleAssignmentRoleBuilder();
  set role(PrivilegedRoleAssignmentRoleBuilder? role) => _$this._role = role;

  String? _companyId;
  String? get companyId => _$this._companyId;
  set companyId(String? companyId) => _$this._companyId = companyId;

  String? _departmentId;
  String? get departmentId => _$this._departmentId;
  set departmentId(String? departmentId) => _$this._departmentId = departmentId;

  String? _locationId;
  String? get locationId => _$this._locationId;
  set locationId(String? locationId) => _$this._locationId = locationId;

  String? _accessRequestId;
  String? get accessRequestId => _$this._accessRequestId;
  set accessRequestId(String? accessRequestId) =>
      _$this._accessRequestId = accessRequestId;

  DateTime? _validFrom;
  DateTime? get validFrom => _$this._validFrom;
  set validFrom(DateTime? validFrom) => _$this._validFrom = validFrom;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  PrivilegedRoleAssignmentBuilder() {
    PrivilegedRoleAssignment._defaults(this);
  }

  PrivilegedRoleAssignmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _user = $v.user;
      _role = $v.role.toBuilder();
      _companyId = $v.companyId;
      _departmentId = $v.departmentId;
      _locationId = $v.locationId;
      _accessRequestId = $v.accessRequestId;
      _validFrom = $v.validFrom;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivilegedRoleAssignment other) {
    _$v = other as _$PrivilegedRoleAssignment;
  }

  @override
  void update(void Function(PrivilegedRoleAssignmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrivilegedRoleAssignment build() => _build();

  _$PrivilegedRoleAssignment _build() {
    _$PrivilegedRoleAssignment _$result;
    try {
      _$result = _$v ??
          _$PrivilegedRoleAssignment._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'PrivilegedRoleAssignment', 'id'),
            user: BuiltValueNullFieldError.checkNotNull(
                user, r'PrivilegedRoleAssignment', 'user'),
            role: role.build(),
            companyId: BuiltValueNullFieldError.checkNotNull(
                companyId, r'PrivilegedRoleAssignment', 'companyId'),
            departmentId: departmentId,
            locationId: locationId,
            accessRequestId: accessRequestId,
            validFrom: BuiltValueNullFieldError.checkNotNull(
                validFrom, r'PrivilegedRoleAssignment', 'validFrom'),
            validUntil: validUntil,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'role';
        role.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PrivilegedRoleAssignment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
