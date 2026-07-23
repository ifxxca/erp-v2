//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/access_catalog_role.dart';
import 'package:rajawali_api_client/src/model/access_catalog_user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'access_catalog_response_data.g.dart';

/// AccessCatalogResponseData
///
/// Properties:
/// * [users]
/// * [roles]
@BuiltValue()
abstract class AccessCatalogResponseData implements Built<AccessCatalogResponseData, AccessCatalogResponseDataBuilder> {
  @BuiltValueField(wireName: r'users')
  BuiltList<AccessCatalogUser> get users;

  @BuiltValueField(wireName: r'roles')
  BuiltList<AccessCatalogRole> get roles;

  AccessCatalogResponseData._();

  factory AccessCatalogResponseData([void updates(AccessCatalogResponseDataBuilder b)]) = _$AccessCatalogResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccessCatalogResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccessCatalogResponseData> get serializer => _$AccessCatalogResponseDataSerializer();
}

class _$AccessCatalogResponseDataSerializer implements PrimitiveSerializer<AccessCatalogResponseData> {
  @override
  final Iterable<Type> types = const [AccessCatalogResponseData, _$AccessCatalogResponseData];

  @override
  final String wireName = r'AccessCatalogResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccessCatalogResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'users';
    yield serializers.serialize(
      object.users,
      specifiedType: const FullType(BuiltList, [FullType(AccessCatalogUser)]),
    );
    yield r'roles';
    yield serializers.serialize(
      object.roles,
      specifiedType: const FullType(BuiltList, [FullType(AccessCatalogRole)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccessCatalogResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccessCatalogResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'users':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AccessCatalogUser)]),
          ) as BuiltList<AccessCatalogUser>;
          result.users.replace(valueDes);
          break;
        case r'roles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AccessCatalogRole)]),
          ) as BuiltList<AccessCatalogRole>;
          result.roles.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccessCatalogResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccessCatalogResponseDataBuilder();
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
