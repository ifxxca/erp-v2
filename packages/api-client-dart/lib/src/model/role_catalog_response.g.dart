// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_catalog_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RoleCatalogResponse extends RoleCatalogResponse {
  @override
  final RoleCatalogResponseData data;
  @override
  final RoleCatalogResponseMeta meta;

  factory _$RoleCatalogResponse(
          [void Function(RoleCatalogResponseBuilder)? updates]) =>
      (RoleCatalogResponseBuilder()..update(updates))._build();

  _$RoleCatalogResponse._({required this.data, required this.meta}) : super._();
  @override
  RoleCatalogResponse rebuild(
          void Function(RoleCatalogResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoleCatalogResponseBuilder toBuilder() =>
      RoleCatalogResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoleCatalogResponse &&
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
    return (newBuiltValueToStringHelper(r'RoleCatalogResponse')
          ..add('data', data)
          ..add('meta', meta))
        .toString();
  }
}

class RoleCatalogResponseBuilder
    implements Builder<RoleCatalogResponse, RoleCatalogResponseBuilder> {
  _$RoleCatalogResponse? _$v;

  RoleCatalogResponseDataBuilder? _data;
  RoleCatalogResponseDataBuilder get data =>
      _$this._data ??= RoleCatalogResponseDataBuilder();
  set data(RoleCatalogResponseDataBuilder? data) => _$this._data = data;

  RoleCatalogResponseMetaBuilder? _meta;
  RoleCatalogResponseMetaBuilder get meta =>
      _$this._meta ??= RoleCatalogResponseMetaBuilder();
  set meta(RoleCatalogResponseMetaBuilder? meta) => _$this._meta = meta;

  RoleCatalogResponseBuilder() {
    RoleCatalogResponse._defaults(this);
  }

  RoleCatalogResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _meta = $v.meta.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RoleCatalogResponse other) {
    _$v = other as _$RoleCatalogResponse;
  }

  @override
  void update(void Function(RoleCatalogResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RoleCatalogResponse build() => _build();

  _$RoleCatalogResponse _build() {
    _$RoleCatalogResponse _$result;
    try {
      _$result = _$v ??
          _$RoleCatalogResponse._(
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
            r'RoleCatalogResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
