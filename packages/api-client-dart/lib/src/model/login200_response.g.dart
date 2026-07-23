// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Login200Response extends Login200Response {
  @override
  final AnyOf anyOf;

  factory _$Login200Response(
          [void Function(Login200ResponseBuilder)? updates]) =>
      (Login200ResponseBuilder()..update(updates))._build();

  _$Login200Response._({required this.anyOf}) : super._();
  @override
  Login200Response rebuild(void Function(Login200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Login200ResponseBuilder toBuilder() =>
      Login200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Login200Response && anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Login200Response')
          ..add('anyOf', anyOf))
        .toString();
  }
}

class Login200ResponseBuilder
    implements Builder<Login200Response, Login200ResponseBuilder> {
  _$Login200Response? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  Login200ResponseBuilder() {
    Login200Response._defaults(this);
  }

  Login200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Login200Response other) {
    _$v = other as _$Login200Response;
  }

  @override
  void update(void Function(Login200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Login200Response build() => _build();

  _$Login200Response _build() {
    final _$result = _$v ??
        _$Login200Response._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
              anyOf, r'Login200Response', 'anyOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
