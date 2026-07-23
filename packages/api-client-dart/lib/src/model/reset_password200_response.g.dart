// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResetPassword200Response extends ResetPassword200Response {
  @override
  final JsonObject? status;

  factory _$ResetPassword200Response(
          [void Function(ResetPassword200ResponseBuilder)? updates]) =>
      (ResetPassword200ResponseBuilder()..update(updates))._build();

  _$ResetPassword200Response._({this.status}) : super._();
  @override
  ResetPassword200Response rebuild(
          void Function(ResetPassword200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResetPassword200ResponseBuilder toBuilder() =>
      ResetPassword200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResetPassword200Response && status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResetPassword200Response')
          ..add('status', status))
        .toString();
  }
}

class ResetPassword200ResponseBuilder
    implements
        Builder<ResetPassword200Response, ResetPassword200ResponseBuilder> {
  _$ResetPassword200Response? _$v;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(JsonObject? status) => _$this._status = status;

  ResetPassword200ResponseBuilder() {
    ResetPassword200Response._defaults(this);
  }

  ResetPassword200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResetPassword200Response other) {
    _$v = other as _$ResetPassword200Response;
  }

  @override
  void update(void Function(ResetPassword200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResetPassword200Response build() => _build();

  _$ResetPassword200Response _build() {
    final _$result = _$v ??
        _$ResetPassword200Response._(
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
