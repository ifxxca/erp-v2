//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/date.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'organization_membership_update_response.g.dart';

/// OrganizationMembershipUpdateResponse
///
/// Properties:
/// * [status]
/// * [effectiveFrom]
@BuiltValue()
abstract class OrganizationMembershipUpdateResponse implements Built<OrganizationMembershipUpdateResponse, OrganizationMembershipUpdateResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  JsonObject? get status;

  @BuiltValueField(wireName: r'effective_from')
  Date get effectiveFrom;

  OrganizationMembershipUpdateResponse._();

  factory OrganizationMembershipUpdateResponse([void updates(OrganizationMembershipUpdateResponseBuilder b)]) = _$OrganizationMembershipUpdateResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrganizationMembershipUpdateResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrganizationMembershipUpdateResponse> get serializer => _$OrganizationMembershipUpdateResponseSerializer();
}

class _$OrganizationMembershipUpdateResponseSerializer implements PrimitiveSerializer<OrganizationMembershipUpdateResponse> {
  @override
  final Iterable<Type> types = const [OrganizationMembershipUpdateResponse, _$OrganizationMembershipUpdateResponse];

  @override
  final String wireName = r'OrganizationMembershipUpdateResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrganizationMembershipUpdateResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield object.status == null ? null : serializers.serialize(
      object.status,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'effective_from';
    yield serializers.serialize(
      object.effectiveFrom,
      specifiedType: const FullType(Date),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrganizationMembershipUpdateResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrganizationMembershipUpdateResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'effective_from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.effectiveFrom = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrganizationMembershipUpdateResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrganizationMembershipUpdateResponseBuilder();
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
