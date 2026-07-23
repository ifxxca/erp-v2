//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'request_password_reset_request.g.dart';

/// RequestPasswordResetRequest
///
/// Properties:
/// * [email]
@BuiltValue()
abstract class RequestPasswordResetRequest implements Built<RequestPasswordResetRequest, RequestPasswordResetRequestBuilder> {
  @BuiltValueField(wireName: r'email')
  String get email;

  RequestPasswordResetRequest._();

  factory RequestPasswordResetRequest([void updates(RequestPasswordResetRequestBuilder b)]) = _$RequestPasswordResetRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RequestPasswordResetRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RequestPasswordResetRequest> get serializer => _$RequestPasswordResetRequestSerializer();
}

class _$RequestPasswordResetRequestSerializer implements PrimitiveSerializer<RequestPasswordResetRequest> {
  @override
  final Iterable<Type> types = const [RequestPasswordResetRequest, _$RequestPasswordResetRequest];

  @override
  final String wireName = r'RequestPasswordResetRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RequestPasswordResetRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RequestPasswordResetRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RequestPasswordResetRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RequestPasswordResetRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RequestPasswordResetRequestBuilder();
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
