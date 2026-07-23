// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revoke_standard_role_assignment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RevokeStandardRoleAssignmentRequest
    extends RevokeStandardRoleAssignmentRequest {
  @override
  final String reason;

  factory _$RevokeStandardRoleAssignmentRequest(
          [void Function(RevokeStandardRoleAssignmentRequestBuilder)?
              updates]) =>
      (RevokeStandardRoleAssignmentRequestBuilder()..update(updates))._build();

  _$RevokeStandardRoleAssignmentRequest._({required this.reason}) : super._();
  @override
  RevokeStandardRoleAssignmentRequest rebuild(
          void Function(RevokeStandardRoleAssignmentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RevokeStandardRoleAssignmentRequestBuilder toBuilder() =>
      RevokeStandardRoleAssignmentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RevokeStandardRoleAssignmentRequest &&
        reason == other.reason;
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
    return (newBuiltValueToStringHelper(r'RevokeStandardRoleAssignmentRequest')
          ..add('reason', reason))
        .toString();
  }
}

class RevokeStandardRoleAssignmentRequestBuilder
    implements
        Builder<RevokeStandardRoleAssignmentRequest,
            RevokeStandardRoleAssignmentRequestBuilder> {
  _$RevokeStandardRoleAssignmentRequest? _$v;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  RevokeStandardRoleAssignmentRequestBuilder() {
    RevokeStandardRoleAssignmentRequest._defaults(this);
  }

  RevokeStandardRoleAssignmentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RevokeStandardRoleAssignmentRequest other) {
    _$v = other as _$RevokeStandardRoleAssignmentRequest;
  }

  @override
  void update(
      void Function(RevokeStandardRoleAssignmentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RevokeStandardRoleAssignmentRequest build() => _build();

  _$RevokeStandardRoleAssignmentRequest _build() {
    final _$result = _$v ??
        _$RevokeStandardRoleAssignmentRequest._(
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'RevokeStandardRoleAssignmentRequest', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
