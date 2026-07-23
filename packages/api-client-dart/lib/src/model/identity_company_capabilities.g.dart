// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_company_capabilities.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IdentityCompanyCapabilities extends IdentityCompanyCapabilities {
  @override
  final bool canViewUsers;
  @override
  final bool canInviteUsers;
  @override
  final bool canManageEmployment;
  @override
  final bool canAssignAccess;
  @override
  final bool canRequestAccess;
  @override
  final bool canApproveAccess;
  @override
  final bool canRevokeAccess;

  factory _$IdentityCompanyCapabilities(
          [void Function(IdentityCompanyCapabilitiesBuilder)? updates]) =>
      (IdentityCompanyCapabilitiesBuilder()..update(updates))._build();

  _$IdentityCompanyCapabilities._(
      {required this.canViewUsers,
      required this.canInviteUsers,
      required this.canManageEmployment,
      required this.canAssignAccess,
      required this.canRequestAccess,
      required this.canApproveAccess,
      required this.canRevokeAccess})
      : super._();
  @override
  IdentityCompanyCapabilities rebuild(
          void Function(IdentityCompanyCapabilitiesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IdentityCompanyCapabilitiesBuilder toBuilder() =>
      IdentityCompanyCapabilitiesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IdentityCompanyCapabilities &&
        canViewUsers == other.canViewUsers &&
        canInviteUsers == other.canInviteUsers &&
        canManageEmployment == other.canManageEmployment &&
        canAssignAccess == other.canAssignAccess &&
        canRequestAccess == other.canRequestAccess &&
        canApproveAccess == other.canApproveAccess &&
        canRevokeAccess == other.canRevokeAccess;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, canViewUsers.hashCode);
    _$hash = $jc(_$hash, canInviteUsers.hashCode);
    _$hash = $jc(_$hash, canManageEmployment.hashCode);
    _$hash = $jc(_$hash, canAssignAccess.hashCode);
    _$hash = $jc(_$hash, canRequestAccess.hashCode);
    _$hash = $jc(_$hash, canApproveAccess.hashCode);
    _$hash = $jc(_$hash, canRevokeAccess.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IdentityCompanyCapabilities')
          ..add('canViewUsers', canViewUsers)
          ..add('canInviteUsers', canInviteUsers)
          ..add('canManageEmployment', canManageEmployment)
          ..add('canAssignAccess', canAssignAccess)
          ..add('canRequestAccess', canRequestAccess)
          ..add('canApproveAccess', canApproveAccess)
          ..add('canRevokeAccess', canRevokeAccess))
        .toString();
  }
}

class IdentityCompanyCapabilitiesBuilder
    implements
        Builder<IdentityCompanyCapabilities,
            IdentityCompanyCapabilitiesBuilder> {
  _$IdentityCompanyCapabilities? _$v;

  bool? _canViewUsers;
  bool? get canViewUsers => _$this._canViewUsers;
  set canViewUsers(bool? canViewUsers) => _$this._canViewUsers = canViewUsers;

  bool? _canInviteUsers;
  bool? get canInviteUsers => _$this._canInviteUsers;
  set canInviteUsers(bool? canInviteUsers) =>
      _$this._canInviteUsers = canInviteUsers;

  bool? _canManageEmployment;
  bool? get canManageEmployment => _$this._canManageEmployment;
  set canManageEmployment(bool? canManageEmployment) =>
      _$this._canManageEmployment = canManageEmployment;

  bool? _canAssignAccess;
  bool? get canAssignAccess => _$this._canAssignAccess;
  set canAssignAccess(bool? canAssignAccess) =>
      _$this._canAssignAccess = canAssignAccess;

  bool? _canRequestAccess;
  bool? get canRequestAccess => _$this._canRequestAccess;
  set canRequestAccess(bool? canRequestAccess) =>
      _$this._canRequestAccess = canRequestAccess;

  bool? _canApproveAccess;
  bool? get canApproveAccess => _$this._canApproveAccess;
  set canApproveAccess(bool? canApproveAccess) =>
      _$this._canApproveAccess = canApproveAccess;

  bool? _canRevokeAccess;
  bool? get canRevokeAccess => _$this._canRevokeAccess;
  set canRevokeAccess(bool? canRevokeAccess) =>
      _$this._canRevokeAccess = canRevokeAccess;

  IdentityCompanyCapabilitiesBuilder() {
    IdentityCompanyCapabilities._defaults(this);
  }

  IdentityCompanyCapabilitiesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _canViewUsers = $v.canViewUsers;
      _canInviteUsers = $v.canInviteUsers;
      _canManageEmployment = $v.canManageEmployment;
      _canAssignAccess = $v.canAssignAccess;
      _canRequestAccess = $v.canRequestAccess;
      _canApproveAccess = $v.canApproveAccess;
      _canRevokeAccess = $v.canRevokeAccess;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IdentityCompanyCapabilities other) {
    _$v = other as _$IdentityCompanyCapabilities;
  }

  @override
  void update(void Function(IdentityCompanyCapabilitiesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IdentityCompanyCapabilities build() => _build();

  _$IdentityCompanyCapabilities _build() {
    final _$result = _$v ??
        _$IdentityCompanyCapabilities._(
          canViewUsers: BuiltValueNullFieldError.checkNotNull(
              canViewUsers, r'IdentityCompanyCapabilities', 'canViewUsers'),
          canInviteUsers: BuiltValueNullFieldError.checkNotNull(
              canInviteUsers, r'IdentityCompanyCapabilities', 'canInviteUsers'),
          canManageEmployment: BuiltValueNullFieldError.checkNotNull(
              canManageEmployment,
              r'IdentityCompanyCapabilities',
              'canManageEmployment'),
          canAssignAccess: BuiltValueNullFieldError.checkNotNull(
              canAssignAccess,
              r'IdentityCompanyCapabilities',
              'canAssignAccess'),
          canRequestAccess: BuiltValueNullFieldError.checkNotNull(
              canRequestAccess,
              r'IdentityCompanyCapabilities',
              'canRequestAccess'),
          canApproveAccess: BuiltValueNullFieldError.checkNotNull(
              canApproveAccess,
              r'IdentityCompanyCapabilities',
              'canApproveAccess'),
          canRevokeAccess: BuiltValueNullFieldError.checkNotNull(
              canRevokeAccess,
              r'IdentityCompanyCapabilities',
              'canRevokeAccess'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
