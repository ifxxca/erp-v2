// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revoke_session200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RevokeSession200Response extends RevokeSession200Response {
  @override
  final JsonObject? status;
  @override
  final bool current;

  factory _$RevokeSession200Response(
          [void Function(RevokeSession200ResponseBuilder)? updates]) =>
      (RevokeSession200ResponseBuilder()..update(updates))._build();

  _$RevokeSession200Response._({this.status, required this.current})
      : super._();
  @override
  RevokeSession200Response rebuild(
          void Function(RevokeSession200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RevokeSession200ResponseBuilder toBuilder() =>
      RevokeSession200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RevokeSession200Response &&
        status == other.status &&
        current == other.current;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, current.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RevokeSession200Response')
          ..add('status', status)
          ..add('current', current))
        .toString();
  }
}

class RevokeSession200ResponseBuilder
    implements
        Builder<RevokeSession200Response, RevokeSession200ResponseBuilder> {
  _$RevokeSession200Response? _$v;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(JsonObject? status) => _$this._status = status;

  bool? _current;
  bool? get current => _$this._current;
  set current(bool? current) => _$this._current = current;

  RevokeSession200ResponseBuilder() {
    RevokeSession200Response._defaults(this);
  }

  RevokeSession200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _current = $v.current;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RevokeSession200Response other) {
    _$v = other as _$RevokeSession200Response;
  }

  @override
  void update(void Function(RevokeSession200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RevokeSession200Response build() => _build();

  _$RevokeSession200Response _build() {
    final _$result = _$v ??
        _$RevokeSession200Response._(
          status: status,
          current: BuiltValueNullFieldError.checkNotNull(
              current, r'RevokeSession200Response', 'current'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
