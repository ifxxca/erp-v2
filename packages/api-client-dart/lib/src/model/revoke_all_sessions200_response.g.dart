// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revoke_all_sessions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RevokeAllSessions200Response extends RevokeAllSessions200Response {
  @override
  final JsonObject? status;
  @override
  final int revokedCount;
  @override
  final bool keptCurrent;

  factory _$RevokeAllSessions200Response(
          [void Function(RevokeAllSessions200ResponseBuilder)? updates]) =>
      (RevokeAllSessions200ResponseBuilder()..update(updates))._build();

  _$RevokeAllSessions200Response._(
      {this.status, required this.revokedCount, required this.keptCurrent})
      : super._();
  @override
  RevokeAllSessions200Response rebuild(
          void Function(RevokeAllSessions200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RevokeAllSessions200ResponseBuilder toBuilder() =>
      RevokeAllSessions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RevokeAllSessions200Response &&
        status == other.status &&
        revokedCount == other.revokedCount &&
        keptCurrent == other.keptCurrent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, revokedCount.hashCode);
    _$hash = $jc(_$hash, keptCurrent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RevokeAllSessions200Response')
          ..add('status', status)
          ..add('revokedCount', revokedCount)
          ..add('keptCurrent', keptCurrent))
        .toString();
  }
}

class RevokeAllSessions200ResponseBuilder
    implements
        Builder<RevokeAllSessions200Response,
            RevokeAllSessions200ResponseBuilder> {
  _$RevokeAllSessions200Response? _$v;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(JsonObject? status) => _$this._status = status;

  int? _revokedCount;
  int? get revokedCount => _$this._revokedCount;
  set revokedCount(int? revokedCount) => _$this._revokedCount = revokedCount;

  bool? _keptCurrent;
  bool? get keptCurrent => _$this._keptCurrent;
  set keptCurrent(bool? keptCurrent) => _$this._keptCurrent = keptCurrent;

  RevokeAllSessions200ResponseBuilder() {
    RevokeAllSessions200Response._defaults(this);
  }

  RevokeAllSessions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _revokedCount = $v.revokedCount;
      _keptCurrent = $v.keptCurrent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RevokeAllSessions200Response other) {
    _$v = other as _$RevokeAllSessions200Response;
  }

  @override
  void update(void Function(RevokeAllSessions200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RevokeAllSessions200Response build() => _build();

  _$RevokeAllSessions200Response _build() {
    final _$result = _$v ??
        _$RevokeAllSessions200Response._(
          status: status,
          revokedCount: BuiltValueNullFieldError.checkNotNull(
              revokedCount, r'RevokeAllSessions200Response', 'revokedCount'),
          keptCurrent: BuiltValueNullFieldError.checkNotNull(
              keptCurrent, r'RevokeAllSessions200Response', 'keptCurrent'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
