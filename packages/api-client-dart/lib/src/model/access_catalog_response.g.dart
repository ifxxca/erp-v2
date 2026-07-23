// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_catalog_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccessCatalogResponse extends AccessCatalogResponse {
  @override
  final AccessCatalogResponseData data;

  factory _$AccessCatalogResponse(
          [void Function(AccessCatalogResponseBuilder)? updates]) =>
      (AccessCatalogResponseBuilder()..update(updates))._build();

  _$AccessCatalogResponse._({required this.data}) : super._();
  @override
  AccessCatalogResponse rebuild(
          void Function(AccessCatalogResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccessCatalogResponseBuilder toBuilder() =>
      AccessCatalogResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccessCatalogResponse && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccessCatalogResponse')
          ..add('data', data))
        .toString();
  }
}

class AccessCatalogResponseBuilder
    implements Builder<AccessCatalogResponse, AccessCatalogResponseBuilder> {
  _$AccessCatalogResponse? _$v;

  AccessCatalogResponseDataBuilder? _data;
  AccessCatalogResponseDataBuilder get data =>
      _$this._data ??= AccessCatalogResponseDataBuilder();
  set data(AccessCatalogResponseDataBuilder? data) => _$this._data = data;

  AccessCatalogResponseBuilder() {
    AccessCatalogResponse._defaults(this);
  }

  AccessCatalogResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccessCatalogResponse other) {
    _$v = other as _$AccessCatalogResponse;
  }

  @override
  void update(void Function(AccessCatalogResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccessCatalogResponse build() => _build();

  _$AccessCatalogResponse _build() {
    _$AccessCatalogResponse _$result;
    try {
      _$result = _$v ??
          _$AccessCatalogResponse._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AccessCatalogResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
