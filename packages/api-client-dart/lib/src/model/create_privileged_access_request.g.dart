// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_privileged_access_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreatePrivilegedAccessRequest extends CreatePrivilegedAccessRequest {
  @override
  final String targetUserId;
  @override
  final String roleId;
  @override
  final String? departmentId;
  @override
  final String? locationId;
  @override
  final String reason;
  @override
  final DateTime validUntil;

  factory _$CreatePrivilegedAccessRequest(
          [void Function(CreatePrivilegedAccessRequestBuilder)? updates]) =>
      (CreatePrivilegedAccessRequestBuilder()..update(updates))._build();

  _$CreatePrivilegedAccessRequest._(
      {required this.targetUserId,
      required this.roleId,
      this.departmentId,
      this.locationId,
      required this.reason,
      required this.validUntil})
      : super._();
  @override
  CreatePrivilegedAccessRequest rebuild(
          void Function(CreatePrivilegedAccessRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreatePrivilegedAccessRequestBuilder toBuilder() =>
      CreatePrivilegedAccessRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePrivilegedAccessRequest &&
        targetUserId == other.targetUserId &&
        roleId == other.roleId &&
        departmentId == other.departmentId &&
        locationId == other.locationId &&
        reason == other.reason &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, targetUserId.hashCode);
    _$hash = $jc(_$hash, roleId.hashCode);
    _$hash = $jc(_$hash, departmentId.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatePrivilegedAccessRequest')
          ..add('targetUserId', targetUserId)
          ..add('roleId', roleId)
          ..add('departmentId', departmentId)
          ..add('locationId', locationId)
          ..add('reason', reason)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class CreatePrivilegedAccessRequestBuilder
    implements
        Builder<CreatePrivilegedAccessRequest,
            CreatePrivilegedAccessRequestBuilder> {
  _$CreatePrivilegedAccessRequest? _$v;

  String? _targetUserId;
  String? get targetUserId => _$this._targetUserId;
  set targetUserId(String? targetUserId) => _$this._targetUserId = targetUserId;

  String? _roleId;
  String? get roleId => _$this._roleId;
  set roleId(String? roleId) => _$this._roleId = roleId;

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

  CreatePrivilegedAccessRequestBuilder() {
    CreatePrivilegedAccessRequest._defaults(this);
  }

  CreatePrivilegedAccessRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _targetUserId = $v.targetUserId;
      _roleId = $v.roleId;
      _departmentId = $v.departmentId;
      _locationId = $v.locationId;
      _reason = $v.reason;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatePrivilegedAccessRequest other) {
    _$v = other as _$CreatePrivilegedAccessRequest;
  }

  @override
  void update(void Function(CreatePrivilegedAccessRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePrivilegedAccessRequest build() => _build();

  _$CreatePrivilegedAccessRequest _build() {
    final _$result = _$v ??
        _$CreatePrivilegedAccessRequest._(
          targetUserId: BuiltValueNullFieldError.checkNotNull(
              targetUserId, r'CreatePrivilegedAccessRequest', 'targetUserId'),
          roleId: BuiltValueNullFieldError.checkNotNull(
              roleId, r'CreatePrivilegedAccessRequest', 'roleId'),
          departmentId: departmentId,
          locationId: locationId,
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'CreatePrivilegedAccessRequest', 'reason'),
          validUntil: BuiltValueNullFieldError.checkNotNull(
              validUntil, r'CreatePrivilegedAccessRequest', 'validUntil'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
