// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totp_code.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TotpCode extends TotpCode {
  @override
  final String code;

  factory _$TotpCode([void Function(TotpCodeBuilder)? updates]) =>
      (TotpCodeBuilder()..update(updates))._build();

  _$TotpCode._({required this.code}) : super._();
  @override
  TotpCode rebuild(void Function(TotpCodeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TotpCodeBuilder toBuilder() => TotpCodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TotpCode && code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TotpCode')..add('code', code))
        .toString();
  }
}

class TotpCodeBuilder implements Builder<TotpCode, TotpCodeBuilder> {
  _$TotpCode? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  TotpCodeBuilder() {
    TotpCode._defaults(this);
  }

  TotpCodeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TotpCode other) {
    _$v = other as _$TotpCode;
  }

  @override
  void update(void Function(TotpCodeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TotpCode build() => _build();

  _$TotpCode _build() {
    final _$result = _$v ??
        _$TotpCode._(
          code:
              BuiltValueNullFieldError.checkNotNull(code, r'TotpCode', 'code'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
