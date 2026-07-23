//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mark_all_notifications_read200_response.g.dart';

/// MarkAllNotificationsRead200Response
///
/// Properties:
/// * [updated]
@BuiltValue()
abstract class MarkAllNotificationsRead200Response implements Built<MarkAllNotificationsRead200Response, MarkAllNotificationsRead200ResponseBuilder> {
  @BuiltValueField(wireName: r'updated')
  int get updated;

  MarkAllNotificationsRead200Response._();

  factory MarkAllNotificationsRead200Response([void updates(MarkAllNotificationsRead200ResponseBuilder b)]) = _$MarkAllNotificationsRead200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MarkAllNotificationsRead200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MarkAllNotificationsRead200Response> get serializer => _$MarkAllNotificationsRead200ResponseSerializer();
}

class _$MarkAllNotificationsRead200ResponseSerializer implements PrimitiveSerializer<MarkAllNotificationsRead200Response> {
  @override
  final Iterable<Type> types = const [MarkAllNotificationsRead200Response, _$MarkAllNotificationsRead200Response];

  @override
  final String wireName = r'MarkAllNotificationsRead200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MarkAllNotificationsRead200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'updated';
    yield serializers.serialize(
      object.updated,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MarkAllNotificationsRead200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MarkAllNotificationsRead200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'updated':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.updated = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MarkAllNotificationsRead200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MarkAllNotificationsRead200ResponseBuilder();
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
