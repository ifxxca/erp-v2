//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/organization_catalog.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_identity_organization200_response.g.dart';

/// GetIdentityOrganization200Response
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class GetIdentityOrganization200Response implements Built<GetIdentityOrganization200Response, GetIdentityOrganization200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  OrganizationCatalog get data;

  GetIdentityOrganization200Response._();

  factory GetIdentityOrganization200Response([void updates(GetIdentityOrganization200ResponseBuilder b)]) = _$GetIdentityOrganization200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetIdentityOrganization200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetIdentityOrganization200Response> get serializer => _$GetIdentityOrganization200ResponseSerializer();
}

class _$GetIdentityOrganization200ResponseSerializer implements PrimitiveSerializer<GetIdentityOrganization200Response> {
  @override
  final Iterable<Type> types = const [GetIdentityOrganization200Response, _$GetIdentityOrganization200Response];

  @override
  final String wireName = r'GetIdentityOrganization200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetIdentityOrganization200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(OrganizationCatalog),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetIdentityOrganization200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetIdentityOrganization200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrganizationCatalog),
          ) as OrganizationCatalog;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetIdentityOrganization200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetIdentityOrganization200ResponseBuilder();
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
