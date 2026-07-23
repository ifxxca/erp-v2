// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_identity_status200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChangeIdentityStatus200Response
    extends ChangeIdentityStatus200Response {
  @override
  final IdentitySummary data;

  factory _$ChangeIdentityStatus200Response(
          [void Function(ChangeIdentityStatus200ResponseBuilder)? updates]) =>
      (ChangeIdentityStatus200ResponseBuilder()..update(updates))._build();

  _$ChangeIdentityStatus200Response._({required this.data}) : super._();
  @override
  ChangeIdentityStatus200Response rebuild(
          void Function(ChangeIdentityStatus200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChangeIdentityStatus200ResponseBuilder toBuilder() =>
      ChangeIdentityStatus200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangeIdentityStatus200Response && data == other.data;
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
    return (newBuiltValueToStringHelper(r'ChangeIdentityStatus200Response')
          ..add('data', data))
        .toString();
  }
}

class ChangeIdentityStatus200ResponseBuilder
    implements
        Builder<ChangeIdentityStatus200Response,
            ChangeIdentityStatus200ResponseBuilder> {
  _$ChangeIdentityStatus200Response? _$v;

  IdentitySummary? _data;
  IdentitySummary? get data => _$this._data;
  set data(IdentitySummary? data) => _$this._data = data;

  ChangeIdentityStatus200ResponseBuilder() {
    ChangeIdentityStatus200Response._defaults(this);
  }

  ChangeIdentityStatus200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangeIdentityStatus200Response other) {
    _$v = other as _$ChangeIdentityStatus200Response;
  }

  @override
  void update(void Function(ChangeIdentityStatus200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangeIdentityStatus200Response build() => _build();

  _$ChangeIdentityStatus200Response _build() {
    final _$result = _$v ??
        _$ChangeIdentityStatus200Response._(
          data: BuiltValueNullFieldError.checkNotNull(
              data, r'ChangeIdentityStatus200Response', 'data'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
