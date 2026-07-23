//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'revoke_all_sessions200_response.g.dart';

/// RevokeAllSessions200Response
///
/// Properties:
/// * [status]
/// * [revokedCount]
/// * [keptCurrent]
@BuiltValue()
abstract class RevokeAllSessions200Response implements Built<RevokeAllSessions200Response, RevokeAllSessions200ResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  JsonObject? get status;

  @BuiltValueField(wireName: r'revoked_count')
  int get revokedCount;

  @BuiltValueField(wireName: r'kept_current')
  bool get keptCurrent;

  RevokeAllSessions200Response._();

  factory RevokeAllSessions200Response([void updates(RevokeAllSessions200ResponseBuilder b)]) = _$RevokeAllSessions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RevokeAllSessions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RevokeAllSessions200Response> get serializer => _$RevokeAllSessions200ResponseSerializer();
}

class _$RevokeAllSessions200ResponseSerializer implements PrimitiveSerializer<RevokeAllSessions200Response> {
  @override
  final Iterable<Type> types = const [RevokeAllSessions200Response, _$RevokeAllSessions200Response];

  @override
  final String wireName = r'RevokeAllSessions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RevokeAllSessions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield object.status == null ? null : serializers.serialize(
      object.status,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'revoked_count';
    yield serializers.serialize(
      object.revokedCount,
      specifiedType: const FullType(int),
    );
    yield r'kept_current';
    yield serializers.serialize(
      object.keptCurrent,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RevokeAllSessions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RevokeAllSessions200ResponseBuilder result,
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
        case r'revoked_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.revokedCount = valueDes;
          break;
        case r'kept_current':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.keptCurrent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RevokeAllSessions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RevokeAllSessions200ResponseBuilder();
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
