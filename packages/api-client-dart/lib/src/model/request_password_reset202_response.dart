//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'request_password_reset202_response.g.dart';

/// RequestPasswordReset202Response
///
/// Properties:
/// * [message]
@BuiltValue()
abstract class RequestPasswordReset202Response implements Built<RequestPasswordReset202Response, RequestPasswordReset202ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  RequestPasswordReset202Response._();

  factory RequestPasswordReset202Response([void updates(RequestPasswordReset202ResponseBuilder b)]) = _$RequestPasswordReset202Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RequestPasswordReset202ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RequestPasswordReset202Response> get serializer => _$RequestPasswordReset202ResponseSerializer();
}

class _$RequestPasswordReset202ResponseSerializer implements PrimitiveSerializer<RequestPasswordReset202Response> {
  @override
  final Iterable<Type> types = const [RequestPasswordReset202Response, _$RequestPasswordReset202Response];

  @override
  final String wireName = r'RequestPasswordReset202Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RequestPasswordReset202Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RequestPasswordReset202Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RequestPasswordReset202ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RequestPasswordReset202Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RequestPasswordReset202ResponseBuilder();
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
