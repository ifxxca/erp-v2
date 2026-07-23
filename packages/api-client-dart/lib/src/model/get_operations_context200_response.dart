//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/operations_context.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_operations_context200_response.g.dart';

/// GetOperationsContext200Response
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class GetOperationsContext200Response implements Built<GetOperationsContext200Response, GetOperationsContext200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<OperationsContext> get data;

  GetOperationsContext200Response._();

  factory GetOperationsContext200Response([void updates(GetOperationsContext200ResponseBuilder b)]) = _$GetOperationsContext200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetOperationsContext200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetOperationsContext200Response> get serializer => _$GetOperationsContext200ResponseSerializer();
}

class _$GetOperationsContext200ResponseSerializer implements PrimitiveSerializer<GetOperationsContext200Response> {
  @override
  final Iterable<Type> types = const [GetOperationsContext200Response, _$GetOperationsContext200Response];

  @override
  final String wireName = r'GetOperationsContext200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetOperationsContext200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(OperationsContext)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GetOperationsContext200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetOperationsContext200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(OperationsContext)]),
          ) as BuiltList<OperationsContext>;
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
  GetOperationsContext200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetOperationsContext200ResponseBuilder();
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
