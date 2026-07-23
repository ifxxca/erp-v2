// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_organization_memberships_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateOrganizationMembershipsRequest
    extends UpdateOrganizationMembershipsRequest {
  @override
  final BuiltSet<String> departmentIds;
  @override
  final String primaryDepartmentId;
  @override
  final BuiltSet<String> locationIds;
  @override
  final Date effectiveFrom;
  @override
  final String reason;

  factory _$UpdateOrganizationMembershipsRequest(
          [void Function(UpdateOrganizationMembershipsRequestBuilder)?
              updates]) =>
      (UpdateOrganizationMembershipsRequestBuilder()..update(updates))._build();

  _$UpdateOrganizationMembershipsRequest._(
      {required this.departmentIds,
      required this.primaryDepartmentId,
      required this.locationIds,
      required this.effectiveFrom,
      required this.reason})
      : super._();
  @override
  UpdateOrganizationMembershipsRequest rebuild(
          void Function(UpdateOrganizationMembershipsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateOrganizationMembershipsRequestBuilder toBuilder() =>
      UpdateOrganizationMembershipsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateOrganizationMembershipsRequest &&
        departmentIds == other.departmentIds &&
        primaryDepartmentId == other.primaryDepartmentId &&
        locationIds == other.locationIds &&
        effectiveFrom == other.effectiveFrom &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, departmentIds.hashCode);
    _$hash = $jc(_$hash, primaryDepartmentId.hashCode);
    _$hash = $jc(_$hash, locationIds.hashCode);
    _$hash = $jc(_$hash, effectiveFrom.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateOrganizationMembershipsRequest')
          ..add('departmentIds', departmentIds)
          ..add('primaryDepartmentId', primaryDepartmentId)
          ..add('locationIds', locationIds)
          ..add('effectiveFrom', effectiveFrom)
          ..add('reason', reason))
        .toString();
  }
}

class UpdateOrganizationMembershipsRequestBuilder
    implements
        Builder<UpdateOrganizationMembershipsRequest,
            UpdateOrganizationMembershipsRequestBuilder> {
  _$UpdateOrganizationMembershipsRequest? _$v;

  SetBuilder<String>? _departmentIds;
  SetBuilder<String> get departmentIds =>
      _$this._departmentIds ??= SetBuilder<String>();
  set departmentIds(SetBuilder<String>? departmentIds) =>
      _$this._departmentIds = departmentIds;

  String? _primaryDepartmentId;
  String? get primaryDepartmentId => _$this._primaryDepartmentId;
  set primaryDepartmentId(String? primaryDepartmentId) =>
      _$this._primaryDepartmentId = primaryDepartmentId;

  SetBuilder<String>? _locationIds;
  SetBuilder<String> get locationIds =>
      _$this._locationIds ??= SetBuilder<String>();
  set locationIds(SetBuilder<String>? locationIds) =>
      _$this._locationIds = locationIds;

  Date? _effectiveFrom;
  Date? get effectiveFrom => _$this._effectiveFrom;
  set effectiveFrom(Date? effectiveFrom) =>
      _$this._effectiveFrom = effectiveFrom;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  UpdateOrganizationMembershipsRequestBuilder() {
    UpdateOrganizationMembershipsRequest._defaults(this);
  }

  UpdateOrganizationMembershipsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _departmentIds = $v.departmentIds.toBuilder();
      _primaryDepartmentId = $v.primaryDepartmentId;
      _locationIds = $v.locationIds.toBuilder();
      _effectiveFrom = $v.effectiveFrom;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateOrganizationMembershipsRequest other) {
    _$v = other as _$UpdateOrganizationMembershipsRequest;
  }

  @override
  void update(
      void Function(UpdateOrganizationMembershipsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateOrganizationMembershipsRequest build() => _build();

  _$UpdateOrganizationMembershipsRequest _build() {
    _$UpdateOrganizationMembershipsRequest _$result;
    try {
      _$result = _$v ??
          _$UpdateOrganizationMembershipsRequest._(
            departmentIds: departmentIds.build(),
            primaryDepartmentId: BuiltValueNullFieldError.checkNotNull(
                primaryDepartmentId,
                r'UpdateOrganizationMembershipsRequest',
                'primaryDepartmentId'),
            locationIds: locationIds.build(),
            effectiveFrom: BuiltValueNullFieldError.checkNotNull(effectiveFrom,
                r'UpdateOrganizationMembershipsRequest', 'effectiveFrom'),
            reason: BuiltValueNullFieldError.checkNotNull(
                reason, r'UpdateOrganizationMembershipsRequest', 'reason'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'departmentIds';
        departmentIds.build();

        _$failedField = 'locationIds';
        locationIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UpdateOrganizationMembershipsRequest',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
