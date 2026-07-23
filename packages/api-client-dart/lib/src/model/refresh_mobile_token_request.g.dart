// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_mobile_token_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RefreshMobileTokenRequest extends RefreshMobileTokenRequest {
  @override
  final String refreshToken;

  factory _$RefreshMobileTokenRequest(
          [void Function(RefreshMobileTokenRequestBuilder)? updates]) =>
      (RefreshMobileTokenRequestBuilder()..update(updates))._build();

  _$RefreshMobileTokenRequest._({required this.refreshToken}) : super._();
  @override
  RefreshMobileTokenRequest rebuild(
          void Function(RefreshMobileTokenRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RefreshMobileTokenRequestBuilder toBuilder() =>
      RefreshMobileTokenRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RefreshMobileTokenRequest &&
        refreshToken == other.refreshToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RefreshMobileTokenRequest')
          ..add('refreshToken', refreshToken))
        .toString();
  }
}

class RefreshMobileTokenRequestBuilder
    implements
        Builder<RefreshMobileTokenRequest, RefreshMobileTokenRequestBuilder> {
  _$RefreshMobileTokenRequest? _$v;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  RefreshMobileTokenRequestBuilder() {
    RefreshMobileTokenRequest._defaults(this);
  }

  RefreshMobileTokenRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _refreshToken = $v.refreshToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RefreshMobileTokenRequest other) {
    _$v = other as _$RefreshMobileTokenRequest;
  }

  @override
  void update(void Function(RefreshMobileTokenRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RefreshMobileTokenRequest build() => _build();

  _$RefreshMobileTokenRequest _build() {
    final _$result = _$v ??
        _$RefreshMobileTokenRequest._(
          refreshToken: BuiltValueNullFieldError.checkNotNull(
              refreshToken, r'RefreshMobileTokenRequest', 'refreshToken'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
