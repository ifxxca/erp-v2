// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_revocation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccessRevocation extends AccessRevocation {
  @override
  final String reason;

  factory _$AccessRevocation(
          [void Function(AccessRevocationBuilder)? updates]) =>
      (AccessRevocationBuilder()..update(updates))._build();

  _$AccessRevocation._({required this.reason}) : super._();
  @override
  AccessRevocation rebuild(void Function(AccessRevocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccessRevocationBuilder toBuilder() =>
      AccessRevocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccessRevocation && reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccessRevocation')
          ..add('reason', reason))
        .toString();
  }
}

class AccessRevocationBuilder
    implements Builder<AccessRevocation, AccessRevocationBuilder> {
  _$AccessRevocation? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  AccessRevocationBuilder() {
    AccessRevocation._defaults(this);
  }

  AccessRevocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccessRevocation other) {
    _$v = other as _$AccessRevocation;
  }

  @override
  void update(void Function(AccessRevocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccessRevocation build() => _build();

  _$AccessRevocation _build() {
    final _$result = _$v ??
        _$AccessRevocation._(
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'AccessRevocation', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
