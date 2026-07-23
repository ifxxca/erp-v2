// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_challenge.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MfaChallenge extends MfaChallenge {
  @override
  final String credential;

  factory _$MfaChallenge([void Function(MfaChallengeBuilder)? updates]) =>
      (MfaChallengeBuilder()..update(updates))._build();

  _$MfaChallenge._({required this.credential}) : super._();
  @override
  MfaChallenge rebuild(void Function(MfaChallengeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MfaChallengeBuilder toBuilder() => MfaChallengeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MfaChallenge && credential == other.credential;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, credential.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MfaChallenge')
          ..add('credential', credential))
        .toString();
  }
}

class MfaChallengeBuilder
    implements Builder<MfaChallenge, MfaChallengeBuilder> {
  _$MfaChallenge? _$v;

  String? _credential;
  String? get credential => _$this._credential;
  set credential(String? credential) => _$this._credential = credential;

  MfaChallengeBuilder() {
    MfaChallenge._defaults(this);
  }

  MfaChallengeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _credential = $v.credential;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MfaChallenge other) {
    _$v = other as _$MfaChallenge;
  }

  @override
  void update(void Function(MfaChallengeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MfaChallenge build() => _build();

  _$MfaChallenge _build() {
    final _$result = _$v ??
        _$MfaChallenge._(
          credential: BuiltValueNullFieldError.checkNotNull(
              credential, r'MfaChallenge', 'credential'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
