//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'access_revocation_response.g.dart';

/// AccessRevocationResponse
///
/// Properties:
/// * [assignmentId]
/// * [status]
/// * [revokedAt]
@BuiltValue()
abstract class AccessRevocationResponse implements Built<AccessRevocationResponse, AccessRevocationResponseBuilder> {
  @BuiltValueField(wireName: r'assignment_id')
  String get assignmentId;

  @BuiltValueField(wireName: r'status')
  JsonObject? get status;

  @BuiltValueField(wireName: r'revoked_at')
  DateTime get revokedAt;

  AccessRevocationResponse._();

  factory AccessRevocationResponse([void updates(AccessRevocationResponseBuilder b)]) = _$AccessRevocationResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccessRevocationResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccessRevocationResponse> get serializer => _$AccessRevocationResponseSerializer();
}

class _$AccessRevocationResponseSerializer implements PrimitiveSerializer<AccessRevocationResponse> {
  @override
  final Iterable<Type> types = const [AccessRevocationResponse, _$AccessRevocationResponse];

  @override
  final String wireName = r'AccessRevocationResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccessRevocationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    yield r'revoked_at';
    yield serializers.serialize(
      object.revokedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccessRevocationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccessRevocationResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'revoked_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.revokedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccessRevocationResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccessRevocationResponseBuilder();
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
