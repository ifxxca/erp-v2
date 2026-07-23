//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/access_catalog_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'access_catalog_response.g.dart';

/// AccessCatalogResponse
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class AccessCatalogResponse implements Built<AccessCatalogResponse, AccessCatalogResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  AccessCatalogResponseData get data;

  AccessCatalogResponse._();

  factory AccessCatalogResponse([void updates(AccessCatalogResponseBuilder b)]) = _$AccessCatalogResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccessCatalogResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccessCatalogResponse> get serializer => _$AccessCatalogResponseSerializer();
}

class _$AccessCatalogResponseSerializer implements PrimitiveSerializer<AccessCatalogResponse> {
  @override
  final Iterable<Type> types = const [AccessCatalogResponse, _$AccessCatalogResponse];

  @override
  final String wireName = r'AccessCatalogResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccessCatalogResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(AccessCatalogResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccessCatalogResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccessCatalogResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccessCatalogResponseData),
          ) as AccessCatalogResponseData;
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
  AccessCatalogResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccessCatalogResponseBuilder();
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
