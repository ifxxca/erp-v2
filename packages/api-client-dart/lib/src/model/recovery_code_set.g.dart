// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recovery_code_set.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class RecoveryCodeSetBuilder {
  void replace(RecoveryCodeSet other);
  void update(void Function(RecoveryCodeSetBuilder) updates);
  SetBuilder<String> get recoveryCodes;
  set recoveryCodes(SetBuilder<String>? recoveryCodes);
}

class _$$RecoveryCodeSet extends $RecoveryCodeSet {
  @override
  final BuiltSet<String> recoveryCodes;

  factory _$$RecoveryCodeSet(
          [void Function($RecoveryCodeSetBuilder)? updates]) =>
      ($RecoveryCodeSetBuilder()..update(updates))._build();

  _$$RecoveryCodeSet._({required this.recoveryCodes}) : super._();
  @override
  $RecoveryCodeSet rebuild(void Function($RecoveryCodeSetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $RecoveryCodeSetBuilder toBuilder() =>
      $RecoveryCodeSetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $RecoveryCodeSet && recoveryCodes == other.recoveryCodes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recoveryCodes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$RecoveryCodeSet')
          ..add('recoveryCodes', recoveryCodes))
        .toString();
  }
}

class $RecoveryCodeSetBuilder
    implements
        Builder<$RecoveryCodeSet, $RecoveryCodeSetBuilder>,
        RecoveryCodeSetBuilder {
  _$$RecoveryCodeSet? _$v;

  SetBuilder<String>? _recoveryCodes;
  SetBuilder<String> get recoveryCodes =>
      _$this._recoveryCodes ??= SetBuilder<String>();
  set recoveryCodes(covariant SetBuilder<String>? recoveryCodes) =>
      _$this._recoveryCodes = recoveryCodes;

  $RecoveryCodeSetBuilder() {
    $RecoveryCodeSet._defaults(this);
  }

  $RecoveryCodeSetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recoveryCodes = $v.recoveryCodes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $RecoveryCodeSet other) {
    _$v = other as _$$RecoveryCodeSet;
  }

  @override
  void update(void Function($RecoveryCodeSetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $RecoveryCodeSet build() => _build();

  _$$RecoveryCodeSet _build() {
    _$$RecoveryCodeSet _$result;
    try {
      _$result = _$v ??
          _$$RecoveryCodeSet._(
            recoveryCodes: recoveryCodes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recoveryCodes';
        recoveryCodes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'$RecoveryCodeSet', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
