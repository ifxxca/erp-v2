//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'revoke_session200_response.g.dart';

/// RevokeSession200Response
///
/// Properties:
/// * [status]
/// * [current]
@BuiltValue()
abstract class RevokeSession200Response implements Built<RevokeSession200Response, RevokeSession200ResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  JsonObject? get status;

  @BuiltValueField(wireName: r'current')
  bool get current;

  RevokeSession200Response._();

  factory RevokeSession200Response([void updates(RevokeSession200ResponseBuilder b)]) = _$RevokeSession200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RevokeSession200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RevokeSession200Response> get serializer => _$RevokeSession200ResponseSerializer();
}

class _$RevokeSession200ResponseSerializer implements PrimitiveSerializer<RevokeSession200Response> {
  @override
  final Iterable<Type> types = const [RevokeSession200Response, _$RevokeSession200Response];

  @override
  final String wireName = r'RevokeSession200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RevokeSession200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield object.status == null ? null : serializers.serialize(
      object.status,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'current';
    yield serializers.serialize(
      object.current,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RevokeSession200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RevokeSession200ResponseBuilder result,
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
        case r'current':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.current = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RevokeSession200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RevokeSession200ResponseBuilder();
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
