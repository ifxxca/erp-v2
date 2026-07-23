//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'revoke_all_sessions_request.g.dart';

/// RevokeAllSessionsRequest
///
/// Properties:
/// * [password]
/// * [keepCurrent]
@BuiltValue()
abstract class RevokeAllSessionsRequest implements Built<RevokeAllSessionsRequest, RevokeAllSessionsRequestBuilder> {
  @BuiltValueField(wireName: r'password')
  String get password;

  @BuiltValueField(wireName: r'keep_current')
  bool? get keepCurrent;

  RevokeAllSessionsRequest._();

  factory RevokeAllSessionsRequest([void updates(RevokeAllSessionsRequestBuilder b)]) = _$RevokeAllSessionsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RevokeAllSessionsRequestBuilder b) => b
      ..keepCurrent = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<RevokeAllSessionsRequest> get serializer => _$RevokeAllSessionsRequestSerializer();
}

class _$RevokeAllSessionsRequestSerializer implements PrimitiveSerializer<RevokeAllSessionsRequest> {
  @override
  final Iterable<Type> types = const [RevokeAllSessionsRequest, _$RevokeAllSessionsRequest];

  @override
  final String wireName = r'RevokeAllSessionsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RevokeAllSessionsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    if (object.keepCurrent != null) {
      yield r'keep_current';
      yield serializers.serialize(
        object.keepCurrent,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RevokeAllSessionsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RevokeAllSessionsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'keep_current':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.keepCurrent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RevokeAllSessionsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RevokeAllSessionsRequestBuilder();
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
