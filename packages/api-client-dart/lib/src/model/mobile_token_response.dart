//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/token_response.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mobile_token_response.g.dart';

/// MobileTokenResponse
///
/// Properties:
/// * [tokenType]
/// * [accessToken] - Plaintext access token returned only at issuance.
/// * [expiresAt]
/// * [mfaRequired] - When true, call the MFA challenge before accessing protected application routes.
/// * [refreshToken] - Rotating plaintext secret returned only at issuance; store in OS-protected secure storage.
/// * [refreshExpiresAt] - Absolute family expiry; rotation never extends it.
@BuiltValue()
abstract class MobileTokenResponse implements TokenResponse, Built<MobileTokenResponse, MobileTokenResponseBuilder> {
  /// Absolute family expiry; rotation never extends it.
  @BuiltValueField(wireName: r'refresh_expires_at')
  DateTime get refreshExpiresAt;

  /// Rotating plaintext secret returned only at issuance; store in OS-protected secure storage.
  @BuiltValueField(wireName: r'refresh_token')
  String get refreshToken;

  MobileTokenResponse._();

  factory MobileTokenResponse([void updates(MobileTokenResponseBuilder b)]) = _$MobileTokenResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MobileTokenResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MobileTokenResponse> get serializer => _$MobileTokenResponseSerializer();
}

class _$MobileTokenResponseSerializer implements PrimitiveSerializer<MobileTokenResponse> {
  @override
  final Iterable<Type> types = const [MobileTokenResponse, _$MobileTokenResponse];

  @override
  final String wireName = r'MobileTokenResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MobileTokenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'mfa_required';
    yield serializers.serialize(
      object.mfaRequired,
      specifiedType: const FullType(bool),
    );
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
    yield r'refresh_expires_at';
    yield serializers.serialize(
      object.refreshExpiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'refresh_token';
    yield serializers.serialize(
      object.refreshToken,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MobileTokenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MobileTokenResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mfa_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mfaRequired = valueDes;
          break;
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
        case r'refresh_expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.refreshExpiresAt = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'refresh_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.refreshToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MobileTokenResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MobileTokenResponseBuilder();
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
