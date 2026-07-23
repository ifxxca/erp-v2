// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_role_assignment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const StandardRoleAssignmentStatusEnum
    _$standardRoleAssignmentStatusEnum_scheduled =
    const StandardRoleAssignmentStatusEnum._('scheduled');
const StandardRoleAssignmentStatusEnum
    _$standardRoleAssignmentStatusEnum_active =
    const StandardRoleAssignmentStatusEnum._('active');
const StandardRoleAssignmentStatusEnum
    _$standardRoleAssignmentStatusEnum_expired =
    const StandardRoleAssignmentStatusEnum._('expired');
const StandardRoleAssignmentStatusEnum
    _$standardRoleAssignmentStatusEnum_revoked =
    const StandardRoleAssignmentStatusEnum._('revoked');
const StandardRoleAssignmentStatusEnum
    _$standardRoleAssignmentStatusEnum_unknownDefaultOpenApi =
    const StandardRoleAssignmentStatusEnum._('unknownDefaultOpenApi');

StandardRoleAssignmentStatusEnum _$standardRoleAssignmentStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'scheduled':
      return _$standardRoleAssignmentStatusEnum_scheduled;
    case 'active':
      return _$standardRoleAssignmentStatusEnum_active;
    case 'expired':
      return _$standardRoleAssignmentStatusEnum_expired;
    case 'revoked':
      return _$standardRoleAssignmentStatusEnum_revoked;
    case 'unknownDefaultOpenApi':
      return _$standardRoleAssignmentStatusEnum_unknownDefaultOpenApi;
    default:
      return _$standardRoleAssignmentStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<StandardRoleAssignmentStatusEnum>
    _$standardRoleAssignmentStatusEnumValues = BuiltSet<
        StandardRoleAssignmentStatusEnum>(const <StandardRoleAssignmentStatusEnum>[
  _$standardRoleAssignmentStatusEnum_scheduled,
  _$standardRoleAssignmentStatusEnum_active,
  _$standardRoleAssignmentStatusEnum_expired,
  _$standardRoleAssignmentStatusEnum_revoked,
  _$standardRoleAssignmentStatusEnum_unknownDefaultOpenApi,
]);

Serializer<StandardRoleAssignmentStatusEnum>
    _$standardRoleAssignmentStatusEnumSerializer =
    _$StandardRoleAssignmentStatusEnumSerializer();

class _$StandardRoleAssignmentStatusEnumSerializer
    implements PrimitiveSerializer<StandardRoleAssignmentStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'scheduled': 'scheduled',
    'active': 'active',
    'expired': 'expired',
    'revoked': 'revoked',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'scheduled': 'scheduled',
    'active': 'active',
    'expired': 'expired',
    'revoked': 'revoked',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[StandardRoleAssignmentStatusEnum];
  @override
  final String wireName = 'StandardRoleAssignmentStatusEnum';

  @override
  Object serialize(
          Serializers serializers, StandardRoleAssignmentStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  StandardRoleAssignmentStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      StandardRoleAssignmentStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$StandardRoleAssignment extends StandardRoleAssignment {
  @override
  final String id;
  @override
  final StandardRoleAssignmentRole role;
  @override
  final String companyId;
  @override
  final DepartmentSummary? department;
  @override
  final LocationSummary? location;
  @override
  final DateTime validFrom;
  @override
  final DateTime? validUntil;
  @override
  final UserSummary assignedBy;
  @override
  final DateTime? revokedAt;
  @override
  final UserSummary? revokedBy;
  @override
  final String? revocationReason;
  @override
  final StandardRoleAssignmentStatusEnum status;
  @override
  final bool canRevoke;

  factory _$StandardRoleAssignment(
          [void Function(StandardRoleAssignmentBuilder)? updates]) =>
      (StandardRoleAssignmentBuilder()..update(updates))._build();

  _$StandardRoleAssignment._(
      {required this.id,
      required this.role,
      required this.companyId,
      this.department,
      this.location,
      required this.validFrom,
      this.validUntil,
      required this.assignedBy,
      this.revokedAt,
      this.revokedBy,
      this.revocationReason,
      required this.status,
      required this.canRevoke})
      : super._();
  @override
  StandardRoleAssignment rebuild(
          void Function(StandardRoleAssignmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StandardRoleAssignmentBuilder toBuilder() =>
      StandardRoleAssignmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StandardRoleAssignment &&
        id == other.id &&
        role == other.role &&
        companyId == other.companyId &&
        department == other.department &&
        location == other.location &&
        validFrom == other.validFrom &&
        validUntil == other.validUntil &&
        assignedBy == other.assignedBy &&
        revokedAt == other.revokedAt &&
        revokedBy == other.revokedBy &&
        revocationReason == other.revocationReason &&
        status == other.status &&
        canRevoke == other.canRevoke;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, companyId.hashCode);
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, validFrom.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jc(_$hash, assignedBy.hashCode);
    _$hash = $jc(_$hash, revokedAt.hashCode);
    _$hash = $jc(_$hash, revokedBy.hashCode);
    _$hash = $jc(_$hash, revocationReason.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, canRevoke.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StandardRoleAssignment')
          ..add('id', id)
          ..add('role', role)
          ..add('companyId', companyId)
          ..add('department', department)
          ..add('location', location)
          ..add('validFrom', validFrom)
          ..add('validUntil', validUntil)
          ..add('assignedBy', assignedBy)
          ..add('revokedAt', revokedAt)
          ..add('revokedBy', revokedBy)
          ..add('revocationReason', revocationReason)
          ..add('status', status)
          ..add('canRevoke', canRevoke))
        .toString();
  }
}

class StandardRoleAssignmentBuilder
    implements Builder<StandardRoleAssignment, StandardRoleAssignmentBuilder> {
  _$StandardRoleAssignment? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  StandardRoleAssignmentRoleBuilder? _role;
  StandardRoleAssignmentRoleBuilder get role =>
      _$this._role ??= StandardRoleAssignmentRoleBuilder();
  set role(StandardRoleAssignmentRoleBuilder? role) => _$this._role = role;

  String? _companyId;
  String? get companyId => _$this._companyId;
  set companyId(String? companyId) => _$this._companyId = companyId;

  DepartmentSummaryBuilder? _department;
  DepartmentSummaryBuilder get department =>
      _$this._department ??= DepartmentSummaryBuilder();
  set department(DepartmentSummaryBuilder? department) =>
      _$this._department = department;

  LocationSummaryBuilder? _location;
  LocationSummaryBuilder get location =>
      _$this._location ??= LocationSummaryBuilder();
  set location(LocationSummaryBuilder? location) => _$this._location = location;

  DateTime? _validFrom;
  DateTime? get validFrom => _$this._validFrom;
  set validFrom(DateTime? validFrom) => _$this._validFrom = validFrom;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  UserSummary? _assignedBy;
  UserSummary? get assignedBy => _$this._assignedBy;
  set assignedBy(UserSummary? assignedBy) => _$this._assignedBy = assignedBy;

  DateTime? _revokedAt;
  DateTime? get revokedAt => _$this._revokedAt;
  set revokedAt(DateTime? revokedAt) => _$this._revokedAt = revokedAt;

  UserSummary? _revokedBy;
  UserSummary? get revokedBy => _$this._revokedBy;
  set revokedBy(UserSummary? revokedBy) => _$this._revokedBy = revokedBy;

  String? _revocationReason;
  String? get revocationReason => _$this._revocationReason;
  set revocationReason(String? revocationReason) =>
      _$this._revocationReason = revocationReason;

  StandardRoleAssignmentStatusEnum? _status;
  StandardRoleAssignmentStatusEnum? get status => _$this._status;
  set status(StandardRoleAssignmentStatusEnum? status) =>
      _$this._status = status;

  bool? _canRevoke;
  bool? get canRevoke => _$this._canRevoke;
  set canRevoke(bool? canRevoke) => _$this._canRevoke = canRevoke;

  StandardRoleAssignmentBuilder() {
    StandardRoleAssignment._defaults(this);
  }

  StandardRoleAssignmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _role = $v.role.toBuilder();
      _companyId = $v.companyId;
      _department = $v.department?.toBuilder();
      _location = $v.location?.toBuilder();
      _validFrom = $v.validFrom;
      _validUntil = $v.validUntil;
      _assignedBy = $v.assignedBy;
      _revokedAt = $v.revokedAt;
      _revokedBy = $v.revokedBy;
      _revocationReason = $v.revocationReason;
      _status = $v.status;
      _canRevoke = $v.canRevoke;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StandardRoleAssignment other) {
    _$v = other as _$StandardRoleAssignment;
  }

  @override
  void update(void Function(StandardRoleAssignmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StandardRoleAssignment build() => _build();

  _$StandardRoleAssignment _build() {
    _$StandardRoleAssignment _$result;
    try {
      _$result = _$v ??
          _$StandardRoleAssignment._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'StandardRoleAssignment', 'id'),
            role: role.build(),
            companyId: BuiltValueNullFieldError.checkNotNull(
                companyId, r'StandardRoleAssignment', 'companyId'),
            department: _department?.build(),
            location: _location?.build(),
            validFrom: BuiltValueNullFieldError.checkNotNull(
                validFrom, r'StandardRoleAssignment', 'validFrom'),
            validUntil: validUntil,
            assignedBy: BuiltValueNullFieldError.checkNotNull(
                assignedBy, r'StandardRoleAssignment', 'assignedBy'),
            revokedAt: revokedAt,
            revokedBy: revokedBy,
            revocationReason: revocationReason,
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'StandardRoleAssignment', 'status'),
            canRevoke: BuiltValueNullFieldError.checkNotNull(
                canRevoke, r'StandardRoleAssignment', 'canRevoke'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'role';
        role.build();

        _$failedField = 'department';
        _department?.build();
        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StandardRoleAssignment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
