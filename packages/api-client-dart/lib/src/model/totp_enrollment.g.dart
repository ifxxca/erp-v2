// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totp_enrollment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TotpEnrollment extends TotpEnrollment {
  @override
  final String secret;
  @override
  final String otpauthUrl;
  @override
  final JsonObject? status;

  factory _$TotpEnrollment([void Function(TotpEnrollmentBuilder)? updates]) =>
      (TotpEnrollmentBuilder()..update(updates))._build();

  _$TotpEnrollment._(
      {required this.secret, required this.otpauthUrl, this.status})
      : super._();
  @override
  TotpEnrollment rebuild(void Function(TotpEnrollmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TotpEnrollmentBuilder toBuilder() => TotpEnrollmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TotpEnrollment &&
        secret == other.secret &&
        otpauthUrl == other.otpauthUrl &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, secret.hashCode);
    _$hash = $jc(_$hash, otpauthUrl.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TotpEnrollment')
          ..add('secret', secret)
          ..add('otpauthUrl', otpauthUrl)
          ..add('status', status))
        .toString();
  }
}

class TotpEnrollmentBuilder
    implements Builder<TotpEnrollment, TotpEnrollmentBuilder> {
  _$TotpEnrollment? _$v;

  String? _secret;
  String? get secret => _$this._secret;
  set secret(String? secret) => _$this._secret = secret;

  String? _otpauthUrl;
  String? get otpauthUrl => _$this._otpauthUrl;
  set otpauthUrl(String? otpauthUrl) => _$this._otpauthUrl = otpauthUrl;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(JsonObject? status) => _$this._status = status;

  TotpEnrollmentBuilder() {
    TotpEnrollment._defaults(this);
  }

  TotpEnrollmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _secret = $v.secret;
      _otpauthUrl = $v.otpauthUrl;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TotpEnrollment other) {
    _$v = other as _$TotpEnrollment;
  }

  @override
  void update(void Function(TotpEnrollmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TotpEnrollment build() => _build();

  _$TotpEnrollment _build() {
    final _$result = _$v ??
        _$TotpEnrollment._(
          secret: BuiltValueNullFieldError.checkNotNull(
              secret, r'TotpEnrollment', 'secret'),
          otpauthUrl: BuiltValueNullFieldError.checkNotNull(
              otpauthUrl, r'TotpEnrollment', 'otpauthUrl'),
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
