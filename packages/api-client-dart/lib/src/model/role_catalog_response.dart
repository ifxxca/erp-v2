//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/role_catalog_response_data.dart';
import 'package:rajawali_api_client/src/model/role_catalog_response_meta.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_catalog_response.g.dart';

/// RoleCatalogResponse
///
/// Properties:
/// * [data]
/// * [meta]
@BuiltValue()
abstract class RoleCatalogResponse implements Built<RoleCatalogResponse, RoleCatalogResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  RoleCatalogResponseData get data;

  @BuiltValueField(wireName: r'meta')
  RoleCatalogResponseMeta get meta;

  RoleCatalogResponse._();

  factory RoleCatalogResponse([void updates(RoleCatalogResponseBuilder b)]) = _$RoleCatalogResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleCatalogResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleCatalogResponse> get serializer => _$RoleCatalogResponseSerializer();
}

class _$RoleCatalogResponseSerializer implements PrimitiveSerializer<RoleCatalogResponse> {
  @override
  final Iterable<Type> types = const [RoleCatalogResponse, _$RoleCatalogResponse];

  @override
  final String wireName = r'RoleCatalogResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleCatalogResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(RoleCatalogResponseData),
    );
    yield r'meta';
    yield serializers.serialize(
      object.meta,
      specifiedType: const FullType(RoleCatalogResponseMeta),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleCatalogResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RoleCatalogResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RoleCatalogResponseData),
          ) as RoleCatalogResponseData;
          result.data.replace(valueDes);
          break;
        case r'meta':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RoleCatalogResponseMeta),
          ) as RoleCatalogResponseMeta;
          result.meta.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RoleCatalogResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleCatalogResponseBuilder();
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
