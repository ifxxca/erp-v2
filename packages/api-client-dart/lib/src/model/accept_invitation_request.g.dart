// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_invitation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AcceptInvitationRequest extends AcceptInvitationRequest {
  @override
  final String token;
  @override
  final String password;
  @override
  final String passwordConfirmation;

  factory _$AcceptInvitationRequest(
          [void Function(AcceptInvitationRequestBuilder)? updates]) =>
      (AcceptInvitationRequestBuilder()..update(updates))._build();

  _$AcceptInvitationRequest._(
      {required this.token,
      required this.password,
      required this.passwordConfirmation})
      : super._();
  @override
  AcceptInvitationRequest rebuild(
          void Function(AcceptInvitationRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AcceptInvitationRequestBuilder toBuilder() =>
      AcceptInvitationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AcceptInvitationRequest &&
        token == other.token &&
        password == other.password &&
        passwordConfirmation == other.passwordConfirmation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, passwordConfirmation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AcceptInvitationRequest')
          ..add('token', token)
          ..add('password', password)
          ..add('passwordConfirmation', passwordConfirmation))
        .toString();
  }
}

class AcceptInvitationRequestBuilder
    implements
        Builder<AcceptInvitationRequest, AcceptInvitationRequestBuilder> {
  _$AcceptInvitationRequest? _$v;

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

  AcceptInvitationRequestBuilder() {
    AcceptInvitationRequest._defaults(this);
  }

  AcceptInvitationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _password = $v.password;
      _passwordConfirmation = $v.passwordConfirmation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AcceptInvitationRequest other) {
    _$v = other as _$AcceptInvitationRequest;
  }

  @override
  void update(void Function(AcceptInvitationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AcceptInvitationRequest build() => _build();

  _$AcceptInvitationRequest _build() {
    final _$result = _$v ??
        _$AcceptInvitationRequest._(
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'AcceptInvitationRequest', 'token'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'AcceptInvitationRequest', 'password'),
          passwordConfirmation: BuiltValueNullFieldError.checkNotNull(
              passwordConfirmation,
              r'AcceptInvitationRequest',
              'passwordConfirmation'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
