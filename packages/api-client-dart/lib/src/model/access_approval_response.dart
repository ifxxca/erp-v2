//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'access_approval_response.g.dart';

/// AccessApprovalResponse
///
/// Properties:
/// * [accessRequestId]
/// * [assignmentId]
/// * [status]
/// * [validUntil]
@BuiltValue()
abstract class AccessApprovalResponse implements Built<AccessApprovalResponse, AccessApprovalResponseBuilder> {
  @BuiltValueField(wireName: r'access_request_id')
  String get accessRequestId;

  @BuiltValueField(wireName: r'assignment_id')
  String get assignmentId;

  @BuiltValueField(wireName: r'status')
  JsonObject? get status;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  AccessApprovalResponse._();

  factory AccessApprovalResponse([void updates(AccessApprovalResponseBuilder b)]) = _$AccessApprovalResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccessApprovalResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccessApprovalResponse> get serializer => _$AccessApprovalResponseSerializer();
}

class _$AccessApprovalResponseSerializer implements PrimitiveSerializer<AccessApprovalResponse> {
  @override
  final Iterable<Type> types = const [AccessApprovalResponse, _$AccessApprovalResponse];

  @override
  final String wireName = r'AccessApprovalResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccessApprovalResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'access_request_id';
    yield serializers.serialize(
      object.accessRequestId,
      specifiedType: const FullType(String),
    );
    yield r'assignment_id';
    yield serializers.serialize(
      object.assignmentId,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield object.status == null ? null : serializers.serialize(
      object.status,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'valid_until';
    yield serializers.serialize(
      object.validUntil,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccessApprovalResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccessApprovalResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'access_request_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accessRequestId = valueDes;
          break;
        case r'assignment_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.assignmentId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccessApprovalResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccessApprovalResponseBuilder();
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
