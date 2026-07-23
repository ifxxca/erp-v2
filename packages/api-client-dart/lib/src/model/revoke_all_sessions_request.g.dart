// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revoke_all_sessions_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RevokeAllSessionsRequest extends RevokeAllSessionsRequest {
  @override
  final String password;
  @override
  final bool? keepCurrent;

  factory _$RevokeAllSessionsRequest(
          [void Function(RevokeAllSessionsRequestBuilder)? updates]) =>
      (RevokeAllSessionsRequestBuilder()..update(updates))._build();

  _$RevokeAllSessionsRequest._({required this.password, this.keepCurrent})
      : super._();
  @override
  RevokeAllSessionsRequest rebuild(
          void Function(RevokeAllSessionsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RevokeAllSessionsRequestBuilder toBuilder() =>
      RevokeAllSessionsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RevokeAllSessionsRequest &&
        password == other.password &&
        keepCurrent == other.keepCurrent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, keepCurrent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RevokeAllSessionsRequest')
          ..add('password', password)
          ..add('keepCurrent', keepCurrent))
        .toString();
  }
}

class RevokeAllSessionsRequestBuilder
    implements
        Builder<RevokeAllSessionsRequest, RevokeAllSessionsRequestBuilder> {
  _$RevokeAllSessionsRequest? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  bool? _keepCurrent;
  bool? get keepCurrent => _$this._keepCurrent;
  set keepCurrent(bool? keepCurrent) => _$this._keepCurrent = keepCurrent;

  RevokeAllSessionsRequestBuilder() {
    RevokeAllSessionsRequest._defaults(this);
  }

  RevokeAllSessionsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _keepCurrent = $v.keepCurrent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RevokeAllSessionsRequest other) {
    _$v = other as _$RevokeAllSessionsRequest;
  }

  @override
  void update(void Function(RevokeAllSessionsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RevokeAllSessionsRequest build() => _build();

  _$RevokeAllSessionsRequest _build() {
    final _$result = _$v ??
        _$RevokeAllSessionsRequest._(
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'RevokeAllSessionsRequest', 'password'),
          keepCurrent: keepCurrent,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
