// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_identity_user200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetIdentityUser200Response extends GetIdentityUser200Response {
  @override
  final IdentityUser data;

  factory _$GetIdentityUser200Response(
          [void Function(GetIdentityUser200ResponseBuilder)? updates]) =>
      (GetIdentityUser200ResponseBuilder()..update(updates))._build();

  _$GetIdentityUser200Response._({required this.data}) : super._();
  @override
  GetIdentityUser200Response rebuild(
          void Function(GetIdentityUser200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetIdentityUser200ResponseBuilder toBuilder() =>
      GetIdentityUser200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetIdentityUser200Response && data == other.data;
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
    return (newBuiltValueToStringHelper(r'GetIdentityUser200Response')
          ..add('data', data))
        .toString();
  }
}

class GetIdentityUser200ResponseBuilder
    implements
        Builder<GetIdentityUser200Response, GetIdentityUser200ResponseBuilder> {
  _$GetIdentityUser200Response? _$v;

  IdentityUserBuilder? _data;
  IdentityUserBuilder get data => _$this._data ??= IdentityUserBuilder();
  set data(IdentityUserBuilder? data) => _$this._data = data;

  GetIdentityUser200ResponseBuilder() {
    GetIdentityUser200Response._defaults(this);
  }

  GetIdentityUser200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetIdentityUser200Response other) {
    _$v = other as _$GetIdentityUser200Response;
  }

  @override
  void update(void Function(GetIdentityUser200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetIdentityUser200Response build() => _build();

  _$GetIdentityUser200Response _build() {
    _$GetIdentityUser200Response _$result;
    try {
      _$result = _$v ??
          _$GetIdentityUser200Response._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetIdentityUser200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
