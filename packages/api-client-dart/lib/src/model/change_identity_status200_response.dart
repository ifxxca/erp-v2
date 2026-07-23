//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/identity_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'change_identity_status200_response.g.dart';

/// ChangeIdentityStatus200Response
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class ChangeIdentityStatus200Response implements Built<ChangeIdentityStatus200Response, ChangeIdentityStatus200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  IdentitySummary get data;

  ChangeIdentityStatus200Response._();

  factory ChangeIdentityStatus200Response([void updates(ChangeIdentityStatus200ResponseBuilder b)]) = _$ChangeIdentityStatus200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChangeIdentityStatus200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChangeIdentityStatus200Response> get serializer => _$ChangeIdentityStatus200ResponseSerializer();
}

class _$ChangeIdentityStatus200ResponseSerializer implements PrimitiveSerializer<ChangeIdentityStatus200Response> {
  @override
  final Iterable<Type> types = const [ChangeIdentityStatus200Response, _$ChangeIdentityStatus200Response];

  @override
  final String wireName = r'ChangeIdentityStatus200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChangeIdentityStatus200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(IdentitySummary),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChangeIdentityStatus200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChangeIdentityStatus200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IdentitySummary),
          ) as IdentitySummary;
          result.data = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChangeIdentityStatus200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChangeIdentityStatus200ResponseBuilder();
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
