// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_change_reason.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class RoleChangeReasonBuilder {
  void replace(RoleChangeReason other);
  void update(void Function(RoleChangeReasonBuilder) updates);
  String? get reason;
  set reason(String? reason);
}

class _$$RoleChangeReason extends $RoleChangeReason {
  @override
  final String reason;

  factory _$$RoleChangeReason(
          [void Function($RoleChangeReasonBuilder)? updates]) =>
      ($RoleChangeReasonBuilder()..update(updates))._build();

  _$$RoleChangeReason._({required this.reason}) : super._();
  @override
  $RoleChangeReason rebuild(void Function($RoleChangeReasonBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $RoleChangeReasonBuilder toBuilder() =>
      $RoleChangeReasonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $RoleChangeReason && reason == other.reason;
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
    return (newBuiltValueToStringHelper(r'$RoleChangeReason')
          ..add('reason', reason))
        .toString();
  }
}

class $RoleChangeReasonBuilder
    implements
        Builder<$RoleChangeReason, $RoleChangeReasonBuilder>,
        RoleChangeReasonBuilder {
  _$$RoleChangeReason? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(covariant String? reason) => _$this._reason = reason;

  $RoleChangeReasonBuilder() {
    $RoleChangeReason._defaults(this);
  }

  $RoleChangeReasonBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $RoleChangeReason other) {
    _$v = other as _$$RoleChangeReason;
  }

  @override
  void update(void Function($RoleChangeReasonBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $RoleChangeReason build() => _build();

  _$$RoleChangeReason _build() {
    final _$result = _$v ??
        _$$RoleChangeReason._(
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'$RoleChangeReason', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
