//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_liveness200_response.g.dart';

/// GetLiveness200Response
///
/// Properties:
/// * [status]
/// * [checkedAt]
@BuiltValue()
abstract class GetLiveness200Response implements Built<GetLiveness200Response, GetLiveness200ResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  JsonObject? get status;

  @BuiltValueField(wireName: r'checked_at')
  DateTime get checkedAt;

  GetLiveness200Response._();

  factory GetLiveness200Response([void updates(GetLiveness200ResponseBuilder b)]) = _$GetLiveness200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetLiveness200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetLiveness200Response> get serializer => _$GetLiveness200ResponseSerializer();
}

class _$GetLiveness200ResponseSerializer implements PrimitiveSerializer<GetLiveness200Response> {
  @override
  final Iterable<Type> types = const [GetLiveness200Response, _$GetLiveness200Response];

  @override
  final String wireName = r'GetLiveness200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetLiveness200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield object.status == null ? null : serializers.serialize(
      object.status,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'checked_at';
    yield serializers.serialize(
      object.checkedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetLiveness200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetLiveness200ResponseBuilder result,
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
        case r'checked_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.checkedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetLiveness200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetLiveness200ResponseBuilder();
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
