// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_standard_role_assignment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateStandardRoleAssignmentRequest
    extends CreateStandardRoleAssignmentRequest {
  @override
  final String roleId;
  @override
  final String? departmentId;
  @override
  final String? locationId;
  @override
  final Date validFrom;
  @override
  final Date? validUntil;
  @override
  final String reason;

  factory _$CreateStandardRoleAssignmentRequest(
          [void Function(CreateStandardRoleAssignmentRequestBuilder)?
              updates]) =>
      (CreateStandardRoleAssignmentRequestBuilder()..update(updates))._build();

  _$CreateStandardRoleAssignmentRequest._(
      {required this.roleId,
      this.departmentId,
      this.locationId,
      required this.validFrom,
      this.validUntil,
      required this.reason})
      : super._();
  @override
  CreateStandardRoleAssignmentRequest rebuild(
          void Function(CreateStandardRoleAssignmentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateStandardRoleAssignmentRequestBuilder toBuilder() =>
      CreateStandardRoleAssignmentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateStandardRoleAssignmentRequest &&
        roleId == other.roleId &&
        departmentId == other.departmentId &&
        locationId == other.locationId &&
        validFrom == other.validFrom &&
        validUntil == other.validUntil &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roleId.hashCode);
    _$hash = $jc(_$hash, departmentId.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, validFrom.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateStandardRoleAssignmentRequest')
          ..add('roleId', roleId)
          ..add('departmentId', departmentId)
          ..add('locationId', locationId)
          ..add('validFrom', validFrom)
          ..add('validUntil', validUntil)
          ..add('reason', reason))
        .toString();
  }
}

class CreateStandardRoleAssignmentRequestBuilder
    implements
        Builder<CreateStandardRoleAssignmentRequest,
            CreateStandardRoleAssignmentRequestBuilder> {
  _$CreateStandardRoleAssignmentRequest? _$v;

  String? _roleId;
  String? get roleId => _$this._roleId;
  set roleId(String? roleId) => _$this._roleId = roleId;

  String? _departmentId;
  String? get departmentId => _$this._departmentId;
  set departmentId(String? departmentId) => _$this._departmentId = departmentId;

  String? _locationId;
  String? get locationId => _$this._locationId;
  set locationId(String? locationId) => _$this._locationId = locationId;

  Date? _validFrom;
  Date? get validFrom => _$this._validFrom;
  set validFrom(Date? validFrom) => _$this._validFrom = validFrom;

  Date? _validUntil;
  Date? get validUntil => _$this._validUntil;
  set validUntil(Date? validUntil) => _$this._validUntil = validUntil;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  CreateStandardRoleAssignmentRequestBuilder() {
    CreateStandardRoleAssignmentRequest._defaults(this);
  }

  CreateStandardRoleAssignmentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roleId = $v.roleId;
      _departmentId = $v.departmentId;
      _locationId = $v.locationId;
      _validFrom = $v.validFrom;
      _validUntil = $v.validUntil;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateStandardRoleAssignmentRequest other) {
    _$v = other as _$CreateStandardRoleAssignmentRequest;
  }

  @override
  void update(
      void Function(CreateStandardRoleAssignmentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateStandardRoleAssignmentRequest build() => _build();

  _$CreateStandardRoleAssignmentRequest _build() {
    final _$result = _$v ??
        _$CreateStandardRoleAssignmentRequest._(
          roleId: BuiltValueNullFieldError.checkNotNull(
              roleId, r'CreateStandardRoleAssignmentRequest', 'roleId'),
          departmentId: departmentId,
          locationId: locationId,
          validFrom: BuiltValueNullFieldError.checkNotNull(
              validFrom, r'CreateStandardRoleAssignmentRequest', 'validFrom'),
          validUntil: validUntil,
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'CreateStandardRoleAssignmentRequest', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
