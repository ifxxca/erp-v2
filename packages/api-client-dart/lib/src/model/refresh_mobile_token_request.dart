//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'refresh_mobile_token_request.g.dart';

/// RefreshMobileTokenRequest
///
/// Properties:
/// * [refreshToken]
@BuiltValue()
abstract class RefreshMobileTokenRequest implements Built<RefreshMobileTokenRequest, RefreshMobileTokenRequestBuilder> {
  @BuiltValueField(wireName: r'refresh_token')
  String get refreshToken;

  RefreshMobileTokenRequest._();

  factory RefreshMobileTokenRequest([void updates(RefreshMobileTokenRequestBuilder b)]) = _$RefreshMobileTokenRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RefreshMobileTokenRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RefreshMobileTokenRequest> get serializer => _$RefreshMobileTokenRequestSerializer();
}

class _$RefreshMobileTokenRequestSerializer implements PrimitiveSerializer<RefreshMobileTokenRequest> {
  @override
  final Iterable<Type> types = const [RefreshMobileTokenRequest, _$RefreshMobileTokenRequest];

  @override
  final String wireName = r'RefreshMobileTokenRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RefreshMobileTokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'refresh_token';
    yield serializers.serialize(
      object.refreshToken,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RefreshMobileTokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RefreshMobileTokenRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'refresh_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.refreshToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RefreshMobileTokenRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RefreshMobileTokenRequestBuilder();
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
