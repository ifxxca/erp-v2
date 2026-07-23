//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/device_session.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_sessions200_response.g.dart';

/// ListSessions200Response
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class ListSessions200Response implements Built<ListSessions200Response, ListSessions200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<DeviceSession> get data;

  ListSessions200Response._();

  factory ListSessions200Response([void updates(ListSessions200ResponseBuilder b)]) = _$ListSessions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListSessions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListSessions200Response> get serializer => _$ListSessions200ResponseSerializer();
}

class _$ListSessions200ResponseSerializer implements PrimitiveSerializer<ListSessions200Response> {
  @override
  final Iterable<Type> types = const [ListSessions200Response, _$ListSessions200Response];

  @override
  final String wireName = r'ListSessions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListSessions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(DeviceSession)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ListSessions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListSessions200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DeviceSession)]),
          ) as BuiltList<DeviceSession>;
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
  ListSessions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListSessions200ResponseBuilder();
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
