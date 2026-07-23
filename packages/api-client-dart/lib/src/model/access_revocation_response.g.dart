// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_revocation_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccessRevocationResponse extends AccessRevocationResponse {
  @override
  final String assignmentId;
  @override
  final JsonObject? status;
  @override
  final DateTime revokedAt;

  factory _$AccessRevocationResponse(
          [void Function(AccessRevocationResponseBuilder)? updates]) =>
      (AccessRevocationResponseBuilder()..update(updates))._build();

  _$AccessRevocationResponse._(
      {required this.assignmentId, this.status, required this.revokedAt})
      : super._();
  @override
  AccessRevocationResponse rebuild(
          void Function(AccessRevocationResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccessRevocationResponseBuilder toBuilder() =>
      AccessRevocationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccessRevocationResponse &&
        assignmentId == other.assignmentId &&
        status == other.status &&
        revokedAt == other.revokedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assignmentId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, revokedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccessRevocationResponse')
          ..add('assignmentId', assignmentId)
          ..add('status', status)
          ..add('revokedAt', revokedAt))
        .toString();
  }
}

class AccessRevocationResponseBuilder
    implements
        Builder<AccessRevocationResponse, AccessRevocationResponseBuilder> {
  _$AccessRevocationResponse? _$v;

  String? _assignmentId;
  String? get assignmentId => _$this._assignmentId;
  set assignmentId(String? assignmentId) => _$this._assignmentId = assignmentId;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(JsonObject? status) => _$this._status = status;

  DateTime? _revokedAt;
  DateTime? get revokedAt => _$this._revokedAt;
  set revokedAt(DateTime? revokedAt) => _$this._revokedAt = revokedAt;

  AccessRevocationResponseBuilder() {
    AccessRevocationResponse._defaults(this);
  }

  AccessRevocationResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assignmentId = $v.assignmentId;
      _status = $v.status;
      _revokedAt = $v.revokedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccessRevocationResponse other) {
    _$v = other as _$AccessRevocationResponse;
  }

  @override
  void update(void Function(AccessRevocationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccessRevocationResponse build() => _build();

  _$AccessRevocationResponse _build() {
    final _$result = _$v ??
        _$AccessRevocationResponse._(
          assignmentId: BuiltValueNullFieldError.checkNotNull(
              assignmentId, r'AccessRevocationResponse', 'assignmentId'),
          status: status,
          revokedAt: BuiltValueNullFieldError.checkNotNull(
              revokedAt, r'AccessRevocationResponse', 'revokedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
