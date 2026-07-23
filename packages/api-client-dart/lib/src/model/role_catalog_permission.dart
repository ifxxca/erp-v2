//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/role_permission_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_catalog_permission.g.dart';

/// RoleCatalogPermission
///
/// Properties:
/// * [id]
/// * [code]
/// * [module]
/// * [resource]
/// * [action]
/// * [description]
/// * [globalOnly]
@BuiltValue()
abstract class RoleCatalogPermission implements RolePermissionSummary, Built<RoleCatalogPermission, RoleCatalogPermissionBuilder> {
  @BuiltValueField(wireName: r'global_only')
  bool get globalOnly;

  RoleCatalogPermission._();

  factory RoleCatalogPermission([void updates(RoleCatalogPermissionBuilder b)]) = _$RoleCatalogPermission;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleCatalogPermissionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleCatalogPermission> get serializer => _$RoleCatalogPermissionSerializer();
}

class _$RoleCatalogPermissionSerializer implements PrimitiveSerializer<RoleCatalogPermission> {
  @override
  final Iterable<Type> types = const [RoleCatalogPermission, _$RoleCatalogPermission];

  @override
  final String wireName = r'RoleCatalogPermission';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleCatalogPermission object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'global_only';
    yield serializers.serialize(
      object.globalOnly,
      specifiedType: const FullType(bool),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'resource';
    yield serializers.serialize(
      object.resource,
      specifiedType: const FullType(String),
    );
    yield r'module';
    yield serializers.serialize(
      object.module,
      specifiedType: const FullType(String),
    );
    yield r'action';
    yield serializers.serialize(
      object.action,
      specifiedType: const FullType(String),
    );
    yield r'description';
    yield object.description == null ? null : serializers.serialize(
      object.description,
      specifiedType: const FullType.nullable(String),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleCatalogPermission object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RoleCatalogPermissionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'global_only':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.globalOnly = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'resource':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.resource = valueDes;
          break;
        case r'module':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.module = valueDes;
          break;
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.action = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RoleCatalogPermission deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleCatalogPermissionBuilder();
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
