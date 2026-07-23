// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PasswordResetRequest extends PasswordResetRequest {
  @override
  final String email;
  @override
  final String token;
  @override
  final String password;
  @override
  final String passwordConfirmation;

  factory _$PasswordResetRequest(
          [void Function(PasswordResetRequestBuilder)? updates]) =>
      (PasswordResetRequestBuilder()..update(updates))._build();

  _$PasswordResetRequest._(
      {required this.email,
      required this.token,
      required this.password,
      required this.passwordConfirmation})
      : super._();
  @override
  PasswordResetRequest rebuild(
          void Function(PasswordResetRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PasswordResetRequestBuilder toBuilder() =>
      PasswordResetRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PasswordResetRequest &&
        email == other.email &&
        token == other.token &&
        password == other.password &&
        passwordConfirmation == other.passwordConfirmation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, passwordConfirmation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PasswordResetRequest')
          ..add('email', email)
          ..add('token', token)
          ..add('password', password)
          ..add('passwordConfirmation', passwordConfirmation))
        .toString();
  }
}

class PasswordResetRequestBuilder
    implements Builder<PasswordResetRequest, PasswordResetRequestBuilder> {
  _$PasswordResetRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _passwordConfirmation;
  String? get passwordConfirmation => _$this._passwordConfirmation;
  set passwordConfirmation(String? passwordConfirmation) =>
      _$this._passwordConfirmation = passwordConfirmation;

  PasswordResetRequestBuilder() {
    PasswordResetRequest._defaults(this);
  }

  PasswordResetRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _token = $v.token;
      _password = $v.password;
      _passwordConfirmation = $v.passwordConfirmation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PasswordResetRequest other) {
    _$v = other as _$PasswordResetRequest;
  }

  @override
  void update(void Function(PasswordResetRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PasswordResetRequest build() => _build();

  _$PasswordResetRequest _build() {
    final _$result = _$v ??
        _$PasswordResetRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'PasswordResetRequest', 'email'),
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'PasswordResetRequest', 'token'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'PasswordResetRequest', 'password'),
          passwordConfirmation: BuiltValueNullFieldError.checkNotNull(
              passwordConfirmation,
              r'PasswordResetRequest',
              'passwordConfirmation'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
