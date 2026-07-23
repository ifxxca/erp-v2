// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_company_collection.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IdentityCompanyCollection extends IdentityCompanyCollection {
  @override
  final BuiltList<IdentityCompany> data;
  @override
  final IdentityCompanyCollectionMeta meta;

  factory _$IdentityCompanyCollection(
          [void Function(IdentityCompanyCollectionBuilder)? updates]) =>
      (IdentityCompanyCollectionBuilder()..update(updates))._build();

  _$IdentityCompanyCollection._({required this.data, required this.meta})
      : super._();
  @override
  IdentityCompanyCollection rebuild(
          void Function(IdentityCompanyCollectionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IdentityCompanyCollectionBuilder toBuilder() =>
      IdentityCompanyCollectionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IdentityCompanyCollection &&
        data == other.data &&
        meta == other.meta;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, meta.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IdentityCompanyCollection')
          ..add('data', data)
          ..add('meta', meta))
        .toString();
  }
}

class IdentityCompanyCollectionBuilder
    implements
        Builder<IdentityCompanyCollection, IdentityCompanyCollectionBuilder> {
  _$IdentityCompanyCollection? _$v;

  ListBuilder<IdentityCompany>? _data;
  ListBuilder<IdentityCompany> get data =>
      _$this._data ??= ListBuilder<IdentityCompany>();
  set data(ListBuilder<IdentityCompany>? data) => _$this._data = data;

  IdentityCompanyCollectionMetaBuilder? _meta;
  IdentityCompanyCollectionMetaBuilder get meta =>
      _$this._meta ??= IdentityCompanyCollectionMetaBuilder();
  set meta(IdentityCompanyCollectionMetaBuilder? meta) => _$this._meta = meta;

  IdentityCompanyCollectionBuilder() {
    IdentityCompanyCollection._defaults(this);
  }

  IdentityCompanyCollectionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _meta = $v.meta.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IdentityCompanyCollection other) {
    _$v = other as _$IdentityCompanyCollection;
  }

  @override
  void update(void Function(IdentityCompanyCollectionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IdentityCompanyCollection build() => _build();

  _$IdentityCompanyCollection _build() {
    _$IdentityCompanyCollection _$result;
    try {
      _$result = _$v ??
          _$IdentityCompanyCollection._(
            data: data.build(),
            meta: meta.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
        _$failedField = 'meta';
        meta.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'IdentityCompanyCollection', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
