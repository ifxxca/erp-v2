// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_membership_update_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrganizationMembershipUpdateResponse
    extends OrganizationMembershipUpdateResponse {
  @override
  final JsonObject? status;
  @override
  final Date effectiveFrom;

  factory _$OrganizationMembershipUpdateResponse(
          [void Function(OrganizationMembershipUpdateResponseBuilder)?
              updates]) =>
      (OrganizationMembershipUpdateResponseBuilder()..update(updates))._build();

  _$OrganizationMembershipUpdateResponse._(
      {this.status, required this.effectiveFrom})
      : super._();
  @override
  OrganizationMembershipUpdateResponse rebuild(
          void Function(OrganizationMembershipUpdateResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrganizationMembershipUpdateResponseBuilder toBuilder() =>
      OrganizationMembershipUpdateResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrganizationMembershipUpdateResponse &&
        status == other.status &&
        effectiveFrom == other.effectiveFrom;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, effectiveFrom.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrganizationMembershipUpdateResponse')
          ..add('status', status)
          ..add('effectiveFrom', effectiveFrom))
        .toString();
  }
}

class OrganizationMembershipUpdateResponseBuilder
    implements
        Builder<OrganizationMembershipUpdateResponse,
            OrganizationMembershipUpdateResponseBuilder> {
  _$OrganizationMembershipUpdateResponse? _$v;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(JsonObject? status) => _$this._status = status;

  Date? _effectiveFrom;
  Date? get effectiveFrom => _$this._effectiveFrom;
  set effectiveFrom(Date? effectiveFrom) =>
      _$this._effectiveFrom = effectiveFrom;

  OrganizationMembershipUpdateResponseBuilder() {
    OrganizationMembershipUpdateResponse._defaults(this);
  }

  OrganizationMembershipUpdateResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _effectiveFrom = $v.effectiveFrom;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrganizationMembershipUpdateResponse other) {
    _$v = other as _$OrganizationMembershipUpdateResponse;
  }

  @override
  void update(
      void Function(OrganizationMembershipUpdateResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrganizationMembershipUpdateResponse build() => _build();

  _$OrganizationMembershipUpdateResponse _build() {
    final _$result = _$v ??
        _$OrganizationMembershipUpdateResponse._(
          status: status,
          effectiveFrom: BuiltValueNullFieldError.checkNotNull(effectiveFrom,
              r'OrganizationMembershipUpdateResponse', 'effectiveFrom'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
