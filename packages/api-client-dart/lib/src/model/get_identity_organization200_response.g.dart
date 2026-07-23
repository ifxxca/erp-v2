// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_identity_organization200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetIdentityOrganization200Response
    extends GetIdentityOrganization200Response {
  @override
  final OrganizationCatalog data;

  factory _$GetIdentityOrganization200Response(
          [void Function(GetIdentityOrganization200ResponseBuilder)?
              updates]) =>
      (GetIdentityOrganization200ResponseBuilder()..update(updates))._build();

  _$GetIdentityOrganization200Response._({required this.data}) : super._();
  @override
  GetIdentityOrganization200Response rebuild(
          void Function(GetIdentityOrganization200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetIdentityOrganization200ResponseBuilder toBuilder() =>
      GetIdentityOrganization200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetIdentityOrganization200Response && data == other.data;
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
    return (newBuiltValueToStringHelper(r'GetIdentityOrganization200Response')
          ..add('data', data))
        .toString();
  }
}

class GetIdentityOrganization200ResponseBuilder
    implements
        Builder<GetIdentityOrganization200Response,
            GetIdentityOrganization200ResponseBuilder> {
  _$GetIdentityOrganization200Response? _$v;

  OrganizationCatalogBuilder? _data;
  OrganizationCatalogBuilder get data =>
      _$this._data ??= OrganizationCatalogBuilder();
  set data(OrganizationCatalogBuilder? data) => _$this._data = data;

  GetIdentityOrganization200ResponseBuilder() {
    GetIdentityOrganization200Response._defaults(this);
  }

  GetIdentityOrganization200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetIdentityOrganization200Response other) {
    _$v = other as _$GetIdentityOrganization200Response;
  }

  @override
  void update(
      void Function(GetIdentityOrganization200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetIdentityOrganization200Response build() => _build();

  _$GetIdentityOrganization200Response _build() {
    _$GetIdentityOrganization200Response _$result;
    try {
      _$result = _$v ??
          _$GetIdentityOrganization200Response._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetIdentityOrganization200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
