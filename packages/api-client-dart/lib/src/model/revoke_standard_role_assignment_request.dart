//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'revoke_standard_role_assignment_request.g.dart';

/// RevokeStandardRoleAssignmentRequest
///
/// Properties:
/// * [reason]
@BuiltValue()
abstract class RevokeStandardRoleAssignmentRequest implements Built<RevokeStandardRoleAssignmentRequest, RevokeStandardRoleAssignmentRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  String get reason;

  RevokeStandardRoleAssignmentRequest._();

  factory RevokeStandardRoleAssignmentRequest([void updates(RevokeStandardRoleAssignmentRequestBuilder b)]) = _$RevokeStandardRoleAssignmentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RevokeStandardRoleAssignmentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RevokeStandardRoleAssignmentRequest> get serializer => _$RevokeStandardRoleAssignmentRequestSerializer();
}

class _$RevokeStandardRoleAssignmentRequestSerializer implements PrimitiveSerializer<RevokeStandardRoleAssignmentRequest> {
  @override
  final Iterable<Type> types = const [RevokeStandardRoleAssignmentRequest, _$RevokeStandardRoleAssignmentRequest];

  @override
  final String wireName = r'RevokeStandardRoleAssignmentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RevokeStandardRoleAssignmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RevokeStandardRoleAssignmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RevokeStandardRoleAssignmentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RevokeStandardRoleAssignmentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RevokeStandardRoleAssignmentRequestBuilder();
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
