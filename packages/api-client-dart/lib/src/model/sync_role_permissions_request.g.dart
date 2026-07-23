// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_role_permissions_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SyncRolePermissionsRequest extends SyncRolePermissionsRequest {
  @override
  final BuiltSet<String> permissionIds;
  @override
  final String reason;

  factory _$SyncRolePermissionsRequest(
          [void Function(SyncRolePermissionsRequestBuilder)? updates]) =>
      (SyncRolePermissionsRequestBuilder()..update(updates))._build();

  _$SyncRolePermissionsRequest._(
      {required this.permissionIds, required this.reason})
      : super._();
  @override
  SyncRolePermissionsRequest rebuild(
          void Function(SyncRolePermissionsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SyncRolePermissionsRequestBuilder toBuilder() =>
      SyncRolePermissionsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SyncRolePermissionsRequest &&
        permissionIds == other.permissionIds &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, permissionIds.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SyncRolePermissionsRequest')
          ..add('permissionIds', permissionIds)
          ..add('reason', reason))
        .toString();
  }
}

class SyncRolePermissionsRequestBuilder
    implements
        Builder<SyncRolePermissionsRequest, SyncRolePermissionsRequestBuilder>,
        RoleChangeReasonBuilder {
  _$SyncRolePermissionsRequest? _$v;

  SetBuilder<String>? _permissionIds;
  SetBuilder<String> get permissionIds =>
      _$this._permissionIds ??= SetBuilder<String>();
  set permissionIds(covariant SetBuilder<String>? permissionIds) =>
      _$this._permissionIds = permissionIds;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(covariant String? reason) => _$this._reason = reason;

  SyncRolePermissionsRequestBuilder() {
    SyncRolePermissionsRequest._defaults(this);
  }

  SyncRolePermissionsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _permissionIds = $v.permissionIds.toBuilder();
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant SyncRolePermissionsRequest other) {
    _$v = other as _$SyncRolePermissionsRequest;
  }

  @override
  void update(void Function(SyncRolePermissionsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SyncRolePermissionsRequest build() => _build();

  _$SyncRolePermissionsRequest _build() {
    _$SyncRolePermissionsRequest _$result;
    try {
      _$result = _$v ??
          _$SyncRolePermissionsRequest._(
            permissionIds: permissionIds.build(),
            reason: BuiltValueNullFieldError.checkNotNull(
                reason, r'SyncRolePermissionsRequest', 'reason'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'permissionIds';
        permissionIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SyncRolePermissionsRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
