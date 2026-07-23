// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_company_collection_meta.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IdentityCompanyCollectionMeta extends IdentityCompanyCollectionMeta {
  @override
  final bool canManageIdentityStatus;
  @override
  final bool canViewRoles;
  @override
  final bool canManageRoles;

  factory _$IdentityCompanyCollectionMeta(
          [void Function(IdentityCompanyCollectionMetaBuilder)? updates]) =>
      (IdentityCompanyCollectionMetaBuilder()..update(updates))._build();

  _$IdentityCompanyCollectionMeta._(
      {required this.canManageIdentityStatus,
      required this.canViewRoles,
      required this.canManageRoles})
      : super._();
  @override
  IdentityCompanyCollectionMeta rebuild(
          void Function(IdentityCompanyCollectionMetaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IdentityCompanyCollectionMetaBuilder toBuilder() =>
      IdentityCompanyCollectionMetaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IdentityCompanyCollectionMeta &&
        canManageIdentityStatus == other.canManageIdentityStatus &&
        canViewRoles == other.canViewRoles &&
        canManageRoles == other.canManageRoles;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, canManageIdentityStatus.hashCode);
    _$hash = $jc(_$hash, canViewRoles.hashCode);
    _$hash = $jc(_$hash, canManageRoles.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IdentityCompanyCollectionMeta')
          ..add('canManageIdentityStatus', canManageIdentityStatus)
          ..add('canViewRoles', canViewRoles)
          ..add('canManageRoles', canManageRoles))
        .toString();
  }
}

class IdentityCompanyCollectionMetaBuilder
    implements
        Builder<IdentityCompanyCollectionMeta,
            IdentityCompanyCollectionMetaBuilder> {
  _$IdentityCompanyCollectionMeta? _$v;

  bool? _canManageIdentityStatus;
  bool? get canManageIdentityStatus => _$this._canManageIdentityStatus;
  set canManageIdentityStatus(bool? canManageIdentityStatus) =>
      _$this._canManageIdentityStatus = canManageIdentityStatus;

  bool? _canViewRoles;
  bool? get canViewRoles => _$this._canViewRoles;
  set canViewRoles(bool? canViewRoles) => _$this._canViewRoles = canViewRoles;

  bool? _canManageRoles;
  bool? get canManageRoles => _$this._canManageRoles;
  set canManageRoles(bool? canManageRoles) =>
      _$this._canManageRoles = canManageRoles;

  IdentityCompanyCollectionMetaBuilder() {
    IdentityCompanyCollectionMeta._defaults(this);
  }

  IdentityCompanyCollectionMetaBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _canManageIdentityStatus = $v.canManageIdentityStatus;
      _canViewRoles = $v.canViewRoles;
      _canManageRoles = $v.canManageRoles;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IdentityCompanyCollectionMeta other) {
    _$v = other as _$IdentityCompanyCollectionMeta;
  }

  @override
  void update(void Function(IdentityCompanyCollectionMetaBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IdentityCompanyCollectionMeta build() => _build();

  _$IdentityCompanyCollectionMeta _build() {
    final _$result = _$v ??
        _$IdentityCompanyCollectionMeta._(
          canManageIdentityStatus: BuiltValueNullFieldError.checkNotNull(
              canManageIdentityStatus,
              r'IdentityCompanyCollectionMeta',
              'canManageIdentityStatus'),
          canViewRoles: BuiltValueNullFieldError.checkNotNull(
              canViewRoles, r'IdentityCompanyCollectionMeta', 'canViewRoles'),
          canManageRoles: BuiltValueNullFieldError.checkNotNull(canManageRoles,
              r'IdentityCompanyCollectionMeta', 'canManageRoles'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
