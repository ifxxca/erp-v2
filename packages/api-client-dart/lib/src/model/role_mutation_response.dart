//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/role_mutation_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_mutation_response.g.dart';

/// RoleMutationResponse
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class RoleMutationResponse implements Built<RoleMutationResponse, RoleMutationResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  RoleMutationResponseData get data;

  RoleMutationResponse._();

  factory RoleMutationResponse([void updates(RoleMutationResponseBuilder b)]) = _$RoleMutationResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleMutationResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleMutationResponse> get serializer => _$RoleMutationResponseSerializer();
}

class _$RoleMutationResponseSerializer implements PrimitiveSerializer<RoleMutationResponse> {
  @override
  final Iterable<Type> types = const [RoleMutationResponse, _$RoleMutationResponse];

  @override
  final String wireName = r'RoleMutationResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleMutationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(RoleMutationResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleMutationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RoleMutationResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RoleMutationResponseData),
          ) as RoleMutationResponseData;
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
  RoleMutationResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleMutationResponseBuilder();
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
