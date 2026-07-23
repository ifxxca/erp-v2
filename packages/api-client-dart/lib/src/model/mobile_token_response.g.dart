// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_token_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MobileTokenResponse extends MobileTokenResponse {
  @override
  final DateTime refreshExpiresAt;
  @override
  final String refreshToken;
  @override
  final JsonObject? tokenType;
  @override
  final String accessToken;
  @override
  final DateTime expiresAt;
  @override
  final bool mfaRequired;

  factory _$MobileTokenResponse(
          [void Function(MobileTokenResponseBuilder)? updates]) =>
      (MobileTokenResponseBuilder()..update(updates))._build();

  _$MobileTokenResponse._(
      {required this.refreshExpiresAt,
      required this.refreshToken,
      this.tokenType,
      required this.accessToken,
      required this.expiresAt,
      required this.mfaRequired})
      : super._();
  @override
  MobileTokenResponse rebuild(
          void Function(MobileTokenResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MobileTokenResponseBuilder toBuilder() =>
      MobileTokenResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MobileTokenResponse &&
        refreshExpiresAt == other.refreshExpiresAt &&
        refreshToken == other.refreshToken &&
        tokenType == other.tokenType &&
        accessToken == other.accessToken &&
        expiresAt == other.expiresAt &&
        mfaRequired == other.mfaRequired;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, refreshExpiresAt.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, mfaRequired.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MobileTokenResponse')
          ..add('refreshExpiresAt', refreshExpiresAt)
          ..add('refreshToken', refreshToken)
          ..add('tokenType', tokenType)
          ..add('accessToken', accessToken)
          ..add('expiresAt', expiresAt)
          ..add('mfaRequired', mfaRequired))
        .toString();
  }
}

class MobileTokenResponseBuilder
    implements
        Builder<MobileTokenResponse, MobileTokenResponseBuilder>,
        TokenResponseBuilder {
  _$MobileTokenResponse? _$v;

  DateTime? _refreshExpiresAt;
  DateTime? get refreshExpiresAt => _$this._refreshExpiresAt;
  set refreshExpiresAt(covariant DateTime? refreshExpiresAt) =>
      _$this._refreshExpiresAt = refreshExpiresAt;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(covariant String? refreshToken) =>
      _$this._refreshToken = refreshToken;

  JsonObject? _tokenType;
  JsonObject? get tokenType => _$this._tokenType;
  set tokenType(covariant JsonObject? tokenType) =>
      _$this._tokenType = tokenType;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(covariant String? accessToken) =>
      _$this._accessToken = accessToken;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(covariant DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  bool? _mfaRequired;
  bool? get mfaRequired => _$this._mfaRequired;
  set mfaRequired(covariant bool? mfaRequired) =>
      _$this._mfaRequired = mfaRequired;

  MobileTokenResponseBuilder() {
    MobileTokenResponse._defaults(this);
  }

  MobileTokenResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _refreshExpiresAt = $v.refreshExpiresAt;
      _refreshToken = $v.refreshToken;
      _tokenType = $v.tokenType;
      _accessToken = $v.accessToken;
      _expiresAt = $v.expiresAt;
      _mfaRequired = $v.mfaRequired;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant MobileTokenResponse other) {
    _$v = other as _$MobileTokenResponse;
  }

  @override
  void update(void Function(MobileTokenResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MobileTokenResponse build() => _build();

  _$MobileTokenResponse _build() {
    final _$result = _$v ??
        _$MobileTokenResponse._(
          refreshExpiresAt: BuiltValueNullFieldError.checkNotNull(
              refreshExpiresAt, r'MobileTokenResponse', 'refreshExpiresAt'),
          refreshToken: BuiltValueNullFieldError.checkNotNull(
              refreshToken, r'MobileTokenResponse', 'refreshToken'),
          tokenType: tokenType,
          accessToken: BuiltValueNullFieldError.checkNotNull(
              accessToken, r'MobileTokenResponse', 'accessToken'),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'MobileTokenResponse', 'expiresAt'),
          mfaRequired: BuiltValueNullFieldError.checkNotNull(
              mfaRequired, r'MobileTokenResponse', 'mfaRequired'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
