// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_password_reset_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RequestPasswordResetRequest extends RequestPasswordResetRequest {
  @override
  final String email;

  factory _$RequestPasswordResetRequest(
          [void Function(RequestPasswordResetRequestBuilder)? updates]) =>
      (RequestPasswordResetRequestBuilder()..update(updates))._build();

  _$RequestPasswordResetRequest._({required this.email}) : super._();
  @override
  RequestPasswordResetRequest rebuild(
          void Function(RequestPasswordResetRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RequestPasswordResetRequestBuilder toBuilder() =>
      RequestPasswordResetRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RequestPasswordResetRequest && email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RequestPasswordResetRequest')
          ..add('email', email))
        .toString();
  }
}

class RequestPasswordResetRequestBuilder
    implements
        Builder<RequestPasswordResetRequest,
            RequestPasswordResetRequestBuilder> {
  _$RequestPasswordResetRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  RequestPasswordResetRequestBuilder() {
    RequestPasswordResetRequest._defaults(this);
  }

  RequestPasswordResetRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RequestPasswordResetRequest other) {
    _$v = other as _$RequestPasswordResetRequest;
  }

  @override
  void update(void Function(RequestPasswordResetRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RequestPasswordResetRequest build() => _build();

  _$RequestPasswordResetRequest _build() {
    final _$result = _$v ??
        _$RequestPasswordResetRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'RequestPasswordResetRequest', 'email'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
