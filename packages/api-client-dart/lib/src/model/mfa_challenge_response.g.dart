// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_challenge_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MfaChallengeResponseMethodEnum _$mfaChallengeResponseMethodEnum_totp =
    const MfaChallengeResponseMethodEnum._('totp');
const MfaChallengeResponseMethodEnum
    _$mfaChallengeResponseMethodEnum_recoveryCode =
    const MfaChallengeResponseMethodEnum._('recoveryCode');
const MfaChallengeResponseMethodEnum
    _$mfaChallengeResponseMethodEnum_unknownDefaultOpenApi =
    const MfaChallengeResponseMethodEnum._('unknownDefaultOpenApi');

MfaChallengeResponseMethodEnum _$mfaChallengeResponseMethodEnumValueOf(
    String name) {
  switch (name) {
    case 'totp':
      return _$mfaChallengeResponseMethodEnum_totp;
    case 'recoveryCode':
      return _$mfaChallengeResponseMethodEnum_recoveryCode;
    case 'unknownDefaultOpenApi':
      return _$mfaChallengeResponseMethodEnum_unknownDefaultOpenApi;
    default:
      return _$mfaChallengeResponseMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MfaChallengeResponseMethodEnum>
    _$mfaChallengeResponseMethodEnumValues = BuiltSet<
        MfaChallengeResponseMethodEnum>(const <MfaChallengeResponseMethodEnum>[
  _$mfaChallengeResponseMethodEnum_totp,
  _$mfaChallengeResponseMethodEnum_recoveryCode,
  _$mfaChallengeResponseMethodEnum_unknownDefaultOpenApi,
]);

Serializer<MfaChallengeResponseMethodEnum>
    _$mfaChallengeResponseMethodEnumSerializer =
    _$MfaChallengeResponseMethodEnumSerializer();

class _$MfaChallengeResponseMethodEnumSerializer
    implements PrimitiveSerializer<MfaChallengeResponseMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'totp': 'totp',
    'recoveryCode': 'recovery_code',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'totp': 'totp',
    'recovery_code': 'recoveryCode',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[MfaChallengeResponseMethodEnum];
  @override
  final String wireName = 'MfaChallengeResponseMethodEnum';

  @override
  Object serialize(
          Serializers serializers, MfaChallengeResponseMethodEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MfaChallengeResponseMethodEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MfaChallengeResponseMethodEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MfaChallengeResponse extends MfaChallengeResponse {
  @override
  final JsonObject? status;
  @override
  final MfaChallengeResponseMethodEnum method;
  @override
  final DateTime stepUpExpiresAt;

  factory _$MfaChallengeResponse(
          [void Function(MfaChallengeResponseBuilder)? updates]) =>
      (MfaChallengeResponseBuilder()..update(updates))._build();

  _$MfaChallengeResponse._(
      {this.status, required this.method, required this.stepUpExpiresAt})
      : super._();
  @override
  MfaChallengeResponse rebuild(
          void Function(MfaChallengeResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MfaChallengeResponseBuilder toBuilder() =>
      MfaChallengeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MfaChallengeResponse &&
        status == other.status &&
        method == other.method &&
        stepUpExpiresAt == other.stepUpExpiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, stepUpExpiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MfaChallengeResponse')
          ..add('status', status)
          ..add('method', method)
          ..add('stepUpExpiresAt', stepUpExpiresAt))
        .toString();
  }
}

class MfaChallengeResponseBuilder
    implements Builder<MfaChallengeResponse, MfaChallengeResponseBuilder> {
  _$MfaChallengeResponse? _$v;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(JsonObject? status) => _$this._status = status;

  MfaChallengeResponseMethodEnum? _method;
  MfaChallengeResponseMethodEnum? get method => _$this._method;
  set method(MfaChallengeResponseMethodEnum? method) => _$this._method = method;

  DateTime? _stepUpExpiresAt;
  DateTime? get stepUpExpiresAt => _$this._stepUpExpiresAt;
  set stepUpExpiresAt(DateTime? stepUpExpiresAt) =>
      _$this._stepUpExpiresAt = stepUpExpiresAt;

  MfaChallengeResponseBuilder() {
    MfaChallengeResponse._defaults(this);
  }

  MfaChallengeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _method = $v.method;
      _stepUpExpiresAt = $v.stepUpExpiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MfaChallengeResponse other) {
    _$v = other as _$MfaChallengeResponse;
  }

  @override
  void update(void Function(MfaChallengeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MfaChallengeResponse build() => _build();

  _$MfaChallengeResponse _build() {
    final _$result = _$v ??
        _$MfaChallengeResponse._(
          status: status,
          method: BuiltValueNullFieldError.checkNotNull(
              method, r'MfaChallengeResponse', 'method'),
          stepUpExpiresAt: BuiltValueNullFieldError.checkNotNull(
              stepUpExpiresAt, r'MfaChallengeResponse', 'stepUpExpiresAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
