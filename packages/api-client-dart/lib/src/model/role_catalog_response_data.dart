//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/managed_role.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/role_catalog_permission.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_catalog_response_data.g.dart';

/// RoleCatalogResponseData
///
/// Properties:
/// * [roles]
/// * [permissions]
@BuiltValue()
abstract class RoleCatalogResponseData implements Built<RoleCatalogResponseData, RoleCatalogResponseDataBuilder> {
  @BuiltValueField(wireName: r'roles')
  BuiltList<ManagedRole> get roles;

  @BuiltValueField(wireName: r'permissions')
  BuiltList<RoleCatalogPermission> get permissions;

  RoleCatalogResponseData._();

  factory RoleCatalogResponseData([void updates(RoleCatalogResponseDataBuilder b)]) = _$RoleCatalogResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleCatalogResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleCatalogResponseData> get serializer => _$RoleCatalogResponseDataSerializer();
}

class _$RoleCatalogResponseDataSerializer implements PrimitiveSerializer<RoleCatalogResponseData> {
  @override
  final Iterable<Type> types = const [RoleCatalogResponseData, _$RoleCatalogResponseData];

  @override
  final String wireName = r'RoleCatalogResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleCatalogResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'roles';
    yield serializers.serialize(
      object.roles,
      specifiedType: const FullType(BuiltList, [FullType(ManagedRole)]),
    );
    yield r'permissions';
    yield serializers.serialize(
      object.permissions,
      specifiedType: const FullType(BuiltList, [FullType(RoleCatalogPermission)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleCatalogResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RoleCatalogResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'roles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ManagedRole)]),
          ) as BuiltList<ManagedRole>;
          result.roles.replace(valueDes);
          break;
        case r'permissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(RoleCatalogPermission)]),
          ) as BuiltList<RoleCatalogPermission>;
          result.permissions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RoleCatalogResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleCatalogResponseDataBuilder();
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
