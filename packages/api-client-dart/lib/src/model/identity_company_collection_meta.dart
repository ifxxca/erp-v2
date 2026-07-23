//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'identity_company_collection_meta.g.dart';

/// IdentityCompanyCollectionMeta
///
/// Properties:
/// * [canManageIdentityStatus]
/// * [canViewRoles]
/// * [canManageRoles]
@BuiltValue()
abstract class IdentityCompanyCollectionMeta implements Built<IdentityCompanyCollectionMeta, IdentityCompanyCollectionMetaBuilder> {
  @BuiltValueField(wireName: r'can_manage_identity_status')
  bool get canManageIdentityStatus;

  @BuiltValueField(wireName: r'can_view_roles')
  bool get canViewRoles;

  @BuiltValueField(wireName: r'can_manage_roles')
  bool get canManageRoles;

  IdentityCompanyCollectionMeta._();

  factory IdentityCompanyCollectionMeta([void updates(IdentityCompanyCollectionMetaBuilder b)]) = _$IdentityCompanyCollectionMeta;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IdentityCompanyCollectionMetaBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IdentityCompanyCollectionMeta> get serializer => _$IdentityCompanyCollectionMetaSerializer();
}

class _$IdentityCompanyCollectionMetaSerializer implements PrimitiveSerializer<IdentityCompanyCollectionMeta> {
  @override
  final Iterable<Type> types = const [IdentityCompanyCollectionMeta, _$IdentityCompanyCollectionMeta];

  @override
  final String wireName = r'IdentityCompanyCollectionMeta';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IdentityCompanyCollectionMeta object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'can_manage_identity_status';
    yield serializers.serialize(
      object.canManageIdentityStatus,
      specifiedType: const FullType(bool),
    );
    yield r'can_view_roles';
    yield serializers.serialize(
      object.canViewRoles,
      specifiedType: const FullType(bool),
    );
    yield r'can_manage_roles';
    yield serializers.serialize(
      object.canManageRoles,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    IdentityCompanyCollectionMeta object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IdentityCompanyCollectionMetaBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'can_manage_identity_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canManageIdentityStatus = valueDes;
          break;
        case r'can_view_roles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canViewRoles = valueDes;
          break;
        case r'can_manage_roles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canManageRoles = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IdentityCompanyCollectionMeta deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IdentityCompanyCollectionMetaBuilder();
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
