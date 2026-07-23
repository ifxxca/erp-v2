// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privileged_access_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrivilegedAccessRequest extends PrivilegedAccessRequest {
  @override
  final String id;
  @override
  final AccessRequestStatus status;
  @override
  final UserSummary targetUser;
  @override
  final bool targetMfaEnabled;
  @override
  final RoleSummary role;
  @override
  final String companyId;
  @override
  final String? departmentId;
  @override
  final String? locationId;
  @override
  final String reason;
  @override
  final DateTime validUntil;
  @override
  final UserSummary requestedBy;
  @override
  final UserSummary? decidedBy;
  @override
  final DateTime? decidedAt;
  @override
  final String? decisionNote;

  factory _$PrivilegedAccessRequest(
          [void Function(PrivilegedAccessRequestBuilder)? updates]) =>
      (PrivilegedAccessRequestBuilder()..update(updates))._build();

  _$PrivilegedAccessRequest._(
      {required this.id,
      required this.status,
      required this.targetUser,
      required this.targetMfaEnabled,
      required this.role,
      required this.companyId,
      this.departmentId,
      this.locationId,
      required this.reason,
      required this.validUntil,
      required this.requestedBy,
      this.decidedBy,
      this.decidedAt,
      this.decisionNote})
      : super._();
  @override
  PrivilegedAccessRequest rebuild(
          void Function(PrivilegedAccessRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivilegedAccessRequestBuilder toBuilder() =>
      PrivilegedAccessRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivilegedAccessRequest &&
        id == other.id &&
        status == other.status &&
        targetUser == other.targetUser &&
        targetMfaEnabled == other.targetMfaEnabled &&
        role == other.role &&
        companyId == other.companyId &&
        departmentId == other.departmentId &&
        locationId == other.locationId &&
        reason == other.reason &&
        validUntil == other.validUntil &&
        requestedBy == other.requestedBy &&
        decidedBy == other.decidedBy &&
        decidedAt == other.decidedAt &&
        decisionNote == other.decisionNote;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, targetUser.hashCode);
    _$hash = $jc(_$hash, targetMfaEnabled.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, companyId.hashCode);
    _$hash = $jc(_$hash, departmentId.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jc(_$hash, requestedBy.hashCode);
    _$hash = $jc(_$hash, decidedBy.hashCode);
    _$hash = $jc(_$hash, decidedAt.hashCode);
    _$hash = $jc(_$hash, decisionNote.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrivilegedAccessRequest')
          ..add('id', id)
          ..add('status', status)
          ..add('targetUser', targetUser)
          ..add('targetMfaEnabled', targetMfaEnabled)
          ..add('role', role)
          ..add('companyId', companyId)
          ..add('departmentId', departmentId)
          ..add('locationId', locationId)
          ..add('reason', reason)
          ..add('validUntil', validUntil)
          ..add('requestedBy', requestedBy)
          ..add('decidedBy', decidedBy)
          ..add('decidedAt', decidedAt)
          ..add('decisionNote', decisionNote))
        .toString();
  }
}

class PrivilegedAccessRequestBuilder
    implements
        Builder<PrivilegedAccessRequest, PrivilegedAccessRequestBuilder> {
  _$PrivilegedAccessRequest? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  AccessRequestStatus? _status;
  AccessRequestStatus? get status => _$this._status;
  set status(AccessRequestStatus? status) => _$this._status = status;

  UserSummary? _targetUser;
  UserSummary? get targetUser => _$this._targetUser;
  set targetUser(UserSummary? targetUser) => _$this._targetUser = targetUser;

  bool? _targetMfaEnabled;
  bool? get targetMfaEnabled => _$this._targetMfaEnabled;
  set targetMfaEnabled(bool? targetMfaEnabled) =>
      _$this._targetMfaEnabled = targetMfaEnabled;

  RoleSummary? _role;
  RoleSummary? get role => _$this._role;
  set role(RoleSummary? role) => _$this._role = role;

  String? _companyId;
  String? get companyId => _$this._companyId;
  set companyId(String? companyId) => _$this._companyId = companyId;

  String? _departmentId;
  String? get departmentId => _$this._departmentId;
  set departmentId(String? departmentId) => _$this._departmentId = departmentId;

  String? _locationId;
  String? get locationId => _$this._locationId;
  set locationId(String? locationId) => _$this._locationId = locationId;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  UserSummary? _requestedBy;
  UserSummary? get requestedBy => _$this._requestedBy;
  set requestedBy(UserSummary? requestedBy) =>
      _$this._requestedBy = requestedBy;

  UserSummary? _decidedBy;
  UserSummary? get decidedBy => _$this._decidedBy;
  set decidedBy(UserSummary? decidedBy) => _$this._decidedBy = decidedBy;

  DateTime? _decidedAt;
  DateTime? get decidedAt => _$this._decidedAt;
  set decidedAt(DateTime? decidedAt) => _$this._decidedAt = decidedAt;

  String? _decisionNote;
  String? get decisionNote => _$this._decisionNote;
  set decisionNote(String? decisionNote) => _$this._decisionNote = decisionNote;

  PrivilegedAccessRequestBuilder() {
    PrivilegedAccessRequest._defaults(this);
  }

  PrivilegedAccessRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _status = $v.status;
      _targetUser = $v.targetUser;
      _targetMfaEnabled = $v.targetMfaEnabled;
      _role = $v.role;
      _companyId = $v.companyId;
      _departmentId = $v.departmentId;
      _locationId = $v.locationId;
      _reason = $v.reason;
      _validUntil = $v.validUntil;
      _requestedBy = $v.requestedBy;
      _decidedBy = $v.decidedBy;
      _decidedAt = $v.decidedAt;
      _decisionNote = $v.decisionNote;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivilegedAccessRequest other) {
    _$v = other as _$PrivilegedAccessRequest;
  }

  @override
  void update(void Function(PrivilegedAccessRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrivilegedAccessRequest build() => _build();

  _$PrivilegedAccessRequest _build() {
    final _$result = _$v ??
        _$PrivilegedAccessRequest._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'PrivilegedAccessRequest', 'id'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'PrivilegedAccessRequest', 'status'),
          targetUser: BuiltValueNullFieldError.checkNotNull(
              targetUser, r'PrivilegedAccessRequest', 'targetUser'),
          targetMfaEnabled: BuiltValueNullFieldError.checkNotNull(
              targetMfaEnabled, r'PrivilegedAccessRequest', 'targetMfaEnabled'),
          role: BuiltValueNullFieldError.checkNotNull(
              role, r'PrivilegedAccessRequest', 'role'),
          companyId: BuiltValueNullFieldError.checkNotNull(
              companyId, r'PrivilegedAccessRequest', 'companyId'),
          departmentId: departmentId,
          locationId: locationId,
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'PrivilegedAccessRequest', 'reason'),
          validUntil: BuiltValueNullFieldError.checkNotNull(
              validUntil, r'PrivilegedAccessRequest', 'validUntil'),
          requestedBy: BuiltValueNullFieldError.checkNotNull(
              requestedBy, r'PrivilegedAccessRequest', 'requestedBy'),
          decidedBy: decidedBy,
          decidedAt: decidedAt,
          decisionNote: decisionNote,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
