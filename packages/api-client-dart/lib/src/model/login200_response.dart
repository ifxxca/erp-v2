//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/token_response.dart';
import 'package:rajawali_api_client/src/model/mobile_token_response.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'login200_response.g.dart';

/// Login200Response
///
/// Properties:
/// * [tokenType]
/// * [accessToken] - Plaintext access token returned only at issuance.
/// * [expiresAt]
/// * [mfaRequired] - When true, call the MFA challenge before accessing protected application routes.
/// * [refreshToken] - Rotating plaintext secret returned only at issuance; store in OS-protected secure storage.
/// * [refreshExpiresAt] - Absolute family expiry; rotation never extends it.
@BuiltValue()
abstract class Login200Response implements Built<Login200Response, Login200ResponseBuilder> {
  /// Any Of [MobileTokenResponse], [TokenResponse]
  AnyOf get anyOf;

  Login200Response._();

  factory Login200Response([void updates(Login200ResponseBuilder b)]) = _$Login200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Login200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Login200Response> get serializer => _$Login200ResponseSerializer();
}

class _$Login200ResponseSerializer implements PrimitiveSerializer<Login200Response> {
  @override
  final Iterable<Type> types = const [Login200Response, _$Login200Response];

  @override
  final String wireName = r'Login200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Login200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    Login200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  Login200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Login200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(TokenResponse), FullType(MobileTokenResponse), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}
