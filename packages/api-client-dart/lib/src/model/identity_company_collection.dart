//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/identity_company.dart';
import 'package:rajawali_api_client/src/model/identity_company_collection_meta.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'identity_company_collection.g.dart';

/// IdentityCompanyCollection
///
/// Properties:
/// * [data]
/// * [meta]
@BuiltValue()
abstract class IdentityCompanyCollection implements Built<IdentityCompanyCollection, IdentityCompanyCollectionBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<IdentityCompany> get data;

  @BuiltValueField(wireName: r'meta')
  IdentityCompanyCollectionMeta get meta;

  IdentityCompanyCollection._();

  factory IdentityCompanyCollection([void updates(IdentityCompanyCollectionBuilder b)]) = _$IdentityCompanyCollection;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IdentityCompanyCollectionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IdentityCompanyCollection> get serializer => _$IdentityCompanyCollectionSerializer();
}

class _$IdentityCompanyCollectionSerializer implements PrimitiveSerializer<IdentityCompanyCollection> {
  @override
  final Iterable<Type> types = const [IdentityCompanyCollection, _$IdentityCompanyCollection];

  @override
  final String wireName = r'IdentityCompanyCollection';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IdentityCompanyCollection object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(IdentityCompany)]),
    );
    yield r'meta';
    yield serializers.serialize(
      object.meta,
      specifiedType: const FullType(IdentityCompanyCollectionMeta),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    IdentityCompanyCollection object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IdentityCompanyCollectionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(IdentityCompany)]),
          ) as BuiltList<IdentityCompany>;
          result.data.replace(valueDes);
          break;
        case r'meta':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IdentityCompanyCollectionMeta),
          ) as IdentityCompanyCollectionMeta;
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
  IdentityCompanyCollection deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IdentityCompanyCollectionBuilder();
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
