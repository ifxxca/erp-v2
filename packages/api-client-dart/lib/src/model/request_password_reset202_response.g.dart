// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_password_reset202_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RequestPasswordReset202Response
    extends RequestPasswordReset202Response {
  @override
  final String message;

  factory _$RequestPasswordReset202Response(
          [void Function(RequestPasswordReset202ResponseBuilder)? updates]) =>
      (RequestPasswordReset202ResponseBuilder()..update(updates))._build();

  _$RequestPasswordReset202Response._({required this.message}) : super._();
  @override
  RequestPasswordReset202Response rebuild(
          void Function(RequestPasswordReset202ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RequestPasswordReset202ResponseBuilder toBuilder() =>
      RequestPasswordReset202ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RequestPasswordReset202Response && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RequestPasswordReset202Response')
          ..add('message', message))
        .toString();
  }
}

class RequestPasswordReset202ResponseBuilder
    implements
        Builder<RequestPasswordReset202Response,
            RequestPasswordReset202ResponseBuilder> {
  _$RequestPasswordReset202Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  RequestPasswordReset202ResponseBuilder() {
    RequestPasswordReset202Response._defaults(this);
  }

  RequestPasswordReset202ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RequestPasswordReset202Response other) {
    _$v = other as _$RequestPasswordReset202Response;
  }

  @override
  void update(void Function(RequestPasswordReset202ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RequestPasswordReset202Response build() => _build();

  _$RequestPasswordReset202Response _build() {
    final _$result = _$v ??
        _$RequestPasswordReset202Response._(
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'RequestPasswordReset202Response', 'message'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
