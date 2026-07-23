// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class TokenResponseBuilder {
  void replace(TokenResponse other);
  void update(void Function(TokenResponseBuilder) updates);
  JsonObject? get tokenType;
  set tokenType(JsonObject? tokenType);

  String? get accessToken;
  set accessToken(String? accessToken);

  DateTime? get expiresAt;
  set expiresAt(DateTime? expiresAt);

  bool? get mfaRequired;
  set mfaRequired(bool? mfaRequired);
}

class _$$TokenResponse extends $TokenResponse {
  @override
  final JsonObject? tokenType;
  @override
  final String accessToken;
  @override
  final DateTime expiresAt;
  @override
  final bool mfaRequired;

  factory _$$TokenResponse([void Function($TokenResponseBuilder)? updates]) =>
      ($TokenResponseBuilder()..update(updates))._build();

  _$$TokenResponse._(
      {this.tokenType,
      required this.accessToken,
      required this.expiresAt,
      required this.mfaRequired})
      : super._();
  @override
  $TokenResponse rebuild(void Function($TokenResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $TokenResponseBuilder toBuilder() => $TokenResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $TokenResponse &&
        tokenType == other.tokenType &&
        accessToken == other.accessToken &&
        expiresAt == other.expiresAt &&
        mfaRequired == other.mfaRequired;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, mfaRequired.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$TokenResponse')
          ..add('tokenType', tokenType)
          ..add('accessToken', accessToken)
          ..add('expiresAt', expiresAt)
          ..add('mfaRequired', mfaRequired))
        .toString();
  }
}

class $TokenResponseBuilder
    implements
        Builder<$TokenResponse, $TokenResponseBuilder>,
        TokenResponseBuilder {
  _$$TokenResponse? _$v;

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

  $TokenResponseBuilder() {
    $TokenResponse._defaults(this);
  }

  $TokenResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tokenType = $v.tokenType;
      _accessToken = $v.accessToken;
      _expiresAt = $v.expiresAt;
      _mfaRequired = $v.mfaRequired;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $TokenResponse other) {
    _$v = other as _$$TokenResponse;
  }

  @override
  void update(void Function($TokenResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $TokenResponse build() => _build();

  _$$TokenResponse _build() {
    final _$result = _$v ??
        _$$TokenResponse._(
          tokenType: tokenType,
          accessToken: BuiltValueNullFieldError.checkNotNull(
              accessToken, r'$TokenResponse', 'accessToken'),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'$TokenResponse', 'expiresAt'),
          mfaRequired: BuiltValueNullFieldError.checkNotNull(
              mfaRequired, r'$TokenResponse', 'mfaRequired'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
