// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_activation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MfaActivation extends MfaActivation {
  @override
  final JsonObject? status;
  @override
  final BuiltSet<String> recoveryCodes;

  factory _$MfaActivation([void Function(MfaActivationBuilder)? updates]) =>
      (MfaActivationBuilder()..update(updates))._build();

  _$MfaActivation._({this.status, required this.recoveryCodes}) : super._();
  @override
  MfaActivation rebuild(void Function(MfaActivationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MfaActivationBuilder toBuilder() => MfaActivationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MfaActivation &&
        status == other.status &&
        recoveryCodes == other.recoveryCodes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, recoveryCodes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MfaActivation')
          ..add('status', status)
          ..add('recoveryCodes', recoveryCodes))
        .toString();
  }
}

class MfaActivationBuilder
    implements
        Builder<MfaActivation, MfaActivationBuilder>,
        RecoveryCodeSetBuilder {
  _$MfaActivation? _$v;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(covariant JsonObject? status) => _$this._status = status;

  SetBuilder<String>? _recoveryCodes;
  SetBuilder<String> get recoveryCodes =>
      _$this._recoveryCodes ??= SetBuilder<String>();
  set recoveryCodes(covariant SetBuilder<String>? recoveryCodes) =>
      _$this._recoveryCodes = recoveryCodes;

  MfaActivationBuilder() {
    MfaActivation._defaults(this);
  }

  MfaActivationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _recoveryCodes = $v.recoveryCodes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant MfaActivation other) {
    _$v = other as _$MfaActivation;
  }

  @override
  void update(void Function(MfaActivationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MfaActivation build() => _build();

  _$MfaActivation _build() {
    _$MfaActivation _$result;
    try {
      _$result = _$v ??
          _$MfaActivation._(
            status: status,
            recoveryCodes: recoveryCodes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recoveryCodes';
        recoveryCodes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MfaActivation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
