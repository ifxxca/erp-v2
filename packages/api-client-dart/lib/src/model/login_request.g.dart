// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LoginRequestSurfaceEnum _$loginRequestSurfaceEnum_erpWeb =
    const LoginRequestSurfaceEnum._('erpWeb');
const LoginRequestSurfaceEnum _$loginRequestSurfaceEnum_opsWeb =
    const LoginRequestSurfaceEnum._('opsWeb');
const LoginRequestSurfaceEnum _$loginRequestSurfaceEnum_mobile =
    const LoginRequestSurfaceEnum._('mobile');
const LoginRequestSurfaceEnum _$loginRequestSurfaceEnum_unknownDefaultOpenApi =
    const LoginRequestSurfaceEnum._('unknownDefaultOpenApi');

LoginRequestSurfaceEnum _$loginRequestSurfaceEnumValueOf(String name) {
  switch (name) {
    case 'erpWeb':
      return _$loginRequestSurfaceEnum_erpWeb;
    case 'opsWeb':
      return _$loginRequestSurfaceEnum_opsWeb;
    case 'mobile':
      return _$loginRequestSurfaceEnum_mobile;
    case 'unknownDefaultOpenApi':
      return _$loginRequestSurfaceEnum_unknownDefaultOpenApi;
    default:
      return _$loginRequestSurfaceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LoginRequestSurfaceEnum> _$loginRequestSurfaceEnumValues =
    BuiltSet<LoginRequestSurfaceEnum>(const <LoginRequestSurfaceEnum>[
  _$loginRequestSurfaceEnum_erpWeb,
  _$loginRequestSurfaceEnum_opsWeb,
  _$loginRequestSurfaceEnum_mobile,
  _$loginRequestSurfaceEnum_unknownDefaultOpenApi,
]);

Serializer<LoginRequestSurfaceEnum> _$loginRequestSurfaceEnumSerializer =
    _$LoginRequestSurfaceEnumSerializer();

class _$LoginRequestSurfaceEnumSerializer
    implements PrimitiveSerializer<LoginRequestSurfaceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'erpWeb': 'erp_web',
    'opsWeb': 'ops_web',
    'mobile': 'mobile',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'erp_web': 'erpWeb',
    'ops_web': 'opsWeb',
    'mobile': 'mobile',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LoginRequestSurfaceEnum];
  @override
  final String wireName = 'LoginRequestSurfaceEnum';

  @override
  Object serialize(Serializers serializers, LoginRequestSurfaceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LoginRequestSurfaceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LoginRequestSurfaceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LoginRequest extends LoginRequest {
  @override
  final String email;
  @override
  final String password;
  @override
  final LoginRequestSurfaceEnum surface;
  @override
  final String deviceName;

  factory _$LoginRequest([void Function(LoginRequestBuilder)? updates]) =>
      (LoginRequestBuilder()..update(updates))._build();

  _$LoginRequest._(
      {required this.email,
      required this.password,
      required this.surface,
      required this.deviceName})
      : super._();
  @override
  LoginRequest rebuild(void Function(LoginRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginRequestBuilder toBuilder() => LoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginRequest &&
        email == other.email &&
        password == other.password &&
        surface == other.surface &&
        deviceName == other.deviceName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, surface.hashCode);
    _$hash = $jc(_$hash, deviceName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginRequest')
          ..add('email', email)
          ..add('password', password)
          ..add('surface', surface)
          ..add('deviceName', deviceName))
        .toString();
  }
}

class LoginRequestBuilder
    implements Builder<LoginRequest, LoginRequestBuilder> {
  _$LoginRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  LoginRequestSurfaceEnum? _surface;
  LoginRequestSurfaceEnum? get surface => _$this._surface;
  set surface(LoginRequestSurfaceEnum? surface) => _$this._surface = surface;

  String? _deviceName;
  String? get deviceName => _$this._deviceName;
  set deviceName(String? deviceName) => _$this._deviceName = deviceName;

  LoginRequestBuilder() {
    LoginRequest._defaults(this);
  }

  LoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _surface = $v.surface;
      _deviceName = $v.deviceName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginRequest other) {
    _$v = other as _$LoginRequest;
  }

  @override
  void update(void Function(LoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginRequest build() => _build();

  _$LoginRequest _build() {
    final _$result = _$v ??
        _$LoginRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'LoginRequest', 'email'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'LoginRequest', 'password'),
          surface: BuiltValueNullFieldError.checkNotNull(
              surface, r'LoginRequest', 'surface'),
          deviceName: BuiltValueNullFieldError.checkNotNull(
              deviceName, r'LoginRequest', 'deviceName'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
