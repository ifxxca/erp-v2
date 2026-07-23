//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'token_response.g.dart';

/// TokenResponse
///
/// Properties:
/// * [tokenType]
/// * [accessToken] - Plaintext access token returned only at issuance.
/// * [expiresAt]
/// * [mfaRequired] - When true, call the MFA challenge before accessing protected application routes.
@BuiltValue(instantiable: false)
abstract class TokenResponse  {
  @BuiltValueField(wireName: r'token_type')
  JsonObject? get tokenType;

  /// Plaintext access token returned only at issuance.
  @BuiltValueField(wireName: r'access_token')
  String get accessToken;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  /// When true, call the MFA challenge before accessing protected application routes.
  @BuiltValueField(wireName: r'mfa_required')
  bool get mfaRequired;

  @BuiltValueSerializer(custom: true)
  static Serializer<TokenResponse> get serializer => _$TokenResponseSerializer();
}

class _$TokenResponseSerializer implements PrimitiveSerializer<TokenResponse> {
  @override
  final Iterable<Type> types = const [TokenResponse];

  @override
  final String wireName = r'TokenResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TokenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token_type';
    yield object.tokenType == null ? null : serializers.serialize(
      object.tokenType,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'access_token';
    yield serializers.serialize(
      object.accessToken,
      specifiedType: const FullType(String),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'mfa_required';
    yield serializers.serialize(
      object.mfaRequired,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TokenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  TokenResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($TokenResponse)) as $TokenResponse;
  }
}

/// a concrete implementation of [TokenResponse], since [TokenResponse] is not instantiable
@BuiltValue(instantiable: true)
abstract class $TokenResponse implements TokenResponse, Built<$TokenResponse, $TokenResponseBuilder> {
  $TokenResponse._();

  factory $TokenResponse([void Function($TokenResponseBuilder)? updates]) = _$$TokenResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($TokenResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$TokenResponse> get serializer => _$$TokenResponseSerializer();
}

class _$$TokenResponseSerializer implements PrimitiveSerializer<$TokenResponse> {
  @override
  final Iterable<Type> types = const [$TokenResponse, _$$TokenResponse];

  @override
  final String wireName = r'$TokenResponse';

  @override
  Object serialize(
    Serializers serializers,
    $TokenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(TokenResponse))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TokenResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.tokenType = valueDes;
          break;
        case r'access_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accessToken = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'mfa_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mfaRequired = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $TokenResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $TokenResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
