// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_approval_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccessApprovalResponse extends AccessApprovalResponse {
  @override
  final String accessRequestId;
  @override
  final String assignmentId;
  @override
  final JsonObject? status;
  @override
  final DateTime validUntil;

  factory _$AccessApprovalResponse(
          [void Function(AccessApprovalResponseBuilder)? updates]) =>
      (AccessApprovalResponseBuilder()..update(updates))._build();

  _$AccessApprovalResponse._(
      {required this.accessRequestId,
      required this.assignmentId,
      this.status,
      required this.validUntil})
      : super._();
  @override
  AccessApprovalResponse rebuild(
          void Function(AccessApprovalResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccessApprovalResponseBuilder toBuilder() =>
      AccessApprovalResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccessApprovalResponse &&
        accessRequestId == other.accessRequestId &&
        assignmentId == other.assignmentId &&
        status == other.status &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessRequestId.hashCode);
    _$hash = $jc(_$hash, assignmentId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccessApprovalResponse')
          ..add('accessRequestId', accessRequestId)
          ..add('assignmentId', assignmentId)
          ..add('status', status)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class AccessApprovalResponseBuilder
    implements Builder<AccessApprovalResponse, AccessApprovalResponseBuilder> {
  _$AccessApprovalResponse? _$v;

  String? _accessRequestId;
  String? get accessRequestId => _$this._accessRequestId;
  set accessRequestId(String? accessRequestId) =>
      _$this._accessRequestId = accessRequestId;

  String? _assignmentId;
  String? get assignmentId => _$this._assignmentId;
  set assignmentId(String? assignmentId) => _$this._assignmentId = assignmentId;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(JsonObject? status) => _$this._status = status;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  AccessApprovalResponseBuilder() {
    AccessApprovalResponse._defaults(this);
  }

  AccessApprovalResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessRequestId = $v.accessRequestId;
      _assignmentId = $v.assignmentId;
      _status = $v.status;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccessApprovalResponse other) {
    _$v = other as _$AccessApprovalResponse;
  }

  @override
  void update(void Function(AccessApprovalResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccessApprovalResponse build() => _build();

  _$AccessApprovalResponse _build() {
    final _$result = _$v ??
        _$AccessApprovalResponse._(
          accessRequestId: BuiltValueNullFieldError.checkNotNull(
              accessRequestId, r'AccessApprovalResponse', 'accessRequestId'),
          assignmentId: BuiltValueNullFieldError.checkNotNull(
              assignmentId, r'AccessApprovalResponse', 'assignmentId'),
          status: status,
          validUntil: BuiltValueNullFieldError.checkNotNull(
              validUntil, r'AccessApprovalResponse', 'validUntil'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
