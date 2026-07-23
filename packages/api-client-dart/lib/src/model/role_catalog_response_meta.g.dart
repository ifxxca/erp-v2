// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_catalog_response_meta.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RoleCatalogResponseMeta extends RoleCatalogResponseMeta {
  @override
  final bool canManage;

  factory _$RoleCatalogResponseMeta(
          [void Function(RoleCatalogResponseMetaBuilder)? updates]) =>
      (RoleCatalogResponseMetaBuilder()..update(updates))._build();

  _$RoleCatalogResponseMeta._({required this.canManage}) : super._();
  @override
  RoleCatalogResponseMeta rebuild(
          void Function(RoleCatalogResponseMetaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoleCatalogResponseMetaBuilder toBuilder() =>
      RoleCatalogResponseMetaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoleCatalogResponseMeta && canManage == other.canManage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, canManage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RoleCatalogResponseMeta')
          ..add('canManage', canManage))
        .toString();
  }
}

class RoleCatalogResponseMetaBuilder
    implements
        Builder<RoleCatalogResponseMeta, RoleCatalogResponseMetaBuilder> {
  _$RoleCatalogResponseMeta? _$v;

  bool? _canManage;
  bool? get canManage => _$this._canManage;
  set canManage(bool? canManage) => _$this._canManage = canManage;

  RoleCatalogResponseMetaBuilder() {
    RoleCatalogResponseMeta._defaults(this);
  }

  RoleCatalogResponseMetaBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _canManage = $v.canManage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RoleCatalogResponseMeta other) {
    _$v = other as _$RoleCatalogResponseMeta;
  }

  @override
  void update(void Function(RoleCatalogResponseMetaBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RoleCatalogResponseMeta build() => _build();

  _$RoleCatalogResponseMeta _build() {
    final _$result = _$v ??
        _$RoleCatalogResponseMeta._(
          canManage: BuiltValueNullFieldError.checkNotNull(
              canManage, r'RoleCatalogResponseMeta', 'canManage'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
