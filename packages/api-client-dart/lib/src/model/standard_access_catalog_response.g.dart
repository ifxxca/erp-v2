// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_access_catalog_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StandardAccessCatalogResponse extends StandardAccessCatalogResponse {
  @override
  final StandardAccessCatalogResponseData data;

  factory _$StandardAccessCatalogResponse(
          [void Function(StandardAccessCatalogResponseBuilder)? updates]) =>
      (StandardAccessCatalogResponseBuilder()..update(updates))._build();

  _$StandardAccessCatalogResponse._({required this.data}) : super._();
  @override
  StandardAccessCatalogResponse rebuild(
          void Function(StandardAccessCatalogResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StandardAccessCatalogResponseBuilder toBuilder() =>
      StandardAccessCatalogResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StandardAccessCatalogResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'StandardAccessCatalogResponse')
          ..add('data', data))
        .toString();
  }
}

class StandardAccessCatalogResponseBuilder
    implements
        Builder<StandardAccessCatalogResponse,
            StandardAccessCatalogResponseBuilder> {
  _$StandardAccessCatalogResponse? _$v;

  StandardAccessCatalogResponseDataBuilder? _data;
  StandardAccessCatalogResponseDataBuilder get data =>
      _$this._data ??= StandardAccessCatalogResponseDataBuilder();
  set data(StandardAccessCatalogResponseDataBuilder? data) =>
      _$this._data = data;

  StandardAccessCatalogResponseBuilder() {
    StandardAccessCatalogResponse._defaults(this);
  }

  StandardAccessCatalogResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StandardAccessCatalogResponse other) {
    _$v = other as _$StandardAccessCatalogResponse;
  }

  @override
  void update(void Function(StandardAccessCatalogResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StandardAccessCatalogResponse build() => _build();

  _$StandardAccessCatalogResponse _build() {
    _$StandardAccessCatalogResponse _$result;
    try {
      _$result = _$v ??
          _$StandardAccessCatalogResponse._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StandardAccessCatalogResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
