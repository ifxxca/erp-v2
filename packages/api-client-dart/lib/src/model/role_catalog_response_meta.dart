//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_catalog_response_meta.g.dart';

/// RoleCatalogResponseMeta
///
/// Properties:
/// * [canManage]
@BuiltValue()
abstract class RoleCatalogResponseMeta implements Built<RoleCatalogResponseMeta, RoleCatalogResponseMetaBuilder> {
  @BuiltValueField(wireName: r'can_manage')
  bool get canManage;

  RoleCatalogResponseMeta._();

  factory RoleCatalogResponseMeta([void updates(RoleCatalogResponseMetaBuilder b)]) = _$RoleCatalogResponseMeta;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleCatalogResponseMetaBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleCatalogResponseMeta> get serializer => _$RoleCatalogResponseMetaSerializer();
}

class _$RoleCatalogResponseMetaSerializer implements PrimitiveSerializer<RoleCatalogResponseMeta> {
  @override
  final Iterable<Type> types = const [RoleCatalogResponseMeta, _$RoleCatalogResponseMeta];

  @override
  final String wireName = r'RoleCatalogResponseMeta';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleCatalogResponseMeta object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'can_manage';
    yield serializers.serialize(
      object.canManage,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleCatalogResponseMeta object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RoleCatalogResponseMetaBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'can_manage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canManage = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RoleCatalogResponseMeta deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleCatalogResponseMetaBuilder();
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
