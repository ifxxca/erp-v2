//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/standard_role_assignment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'standard_role_assignment_response.g.dart';

/// StandardRoleAssignmentResponse
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class StandardRoleAssignmentResponse implements Built<StandardRoleAssignmentResponse, StandardRoleAssignmentResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  StandardRoleAssignment get data;

  StandardRoleAssignmentResponse._();

  factory StandardRoleAssignmentResponse([void updates(StandardRoleAssignmentResponseBuilder b)]) = _$StandardRoleAssignmentResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StandardRoleAssignmentResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StandardRoleAssignmentResponse> get serializer => _$StandardRoleAssignmentResponseSerializer();
}

class _$StandardRoleAssignmentResponseSerializer implements PrimitiveSerializer<StandardRoleAssignmentResponse> {
  @override
  final Iterable<Type> types = const [StandardRoleAssignmentResponse, _$StandardRoleAssignmentResponse];

  @override
  final String wireName = r'StandardRoleAssignmentResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StandardRoleAssignmentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(StandardRoleAssignment),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StandardRoleAssignmentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StandardRoleAssignmentResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StandardRoleAssignment),
          ) as StandardRoleAssignment;
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
  StandardRoleAssignmentResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StandardRoleAssignmentResponseBuilder();
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
