//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/role_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'access_catalog_role.g.dart';

/// AccessCatalogRole
///
/// Properties:
/// * [id]
/// * [code]
/// * [name]
/// * [description]
/// * [assignmentScope]
@BuiltValue()
abstract class AccessCatalogRole implements RoleSummary, Built<AccessCatalogRole, AccessCatalogRoleBuilder> {
  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'assignment_scope')
  AccessCatalogRoleAssignmentScopeEnum get assignmentScope;
  // enum assignmentScopeEnum {  company,  department,  location,  };

  AccessCatalogRole._();

  factory AccessCatalogRole([void updates(AccessCatalogRoleBuilder b)]) = _$AccessCatalogRole;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccessCatalogRoleBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccessCatalogRole> get serializer => _$AccessCatalogRoleSerializer();
}

class _$AccessCatalogRoleSerializer implements PrimitiveSerializer<AccessCatalogRole> {
  @override
  final Iterable<Type> types = const [AccessCatalogRole, _$AccessCatalogRole];

  @override
  final String wireName = r'AccessCatalogRole';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccessCatalogRole object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'description';
    yield object.description == null ? null : serializers.serialize(
      object.description,
      specifiedType: const FullType.nullable(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'assignment_scope';
    yield serializers.serialize(
      object.assignmentScope,
      specifiedType: const FullType(AccessCatalogRoleAssignmentScopeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccessCatalogRole object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccessCatalogRoleBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'assignment_scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccessCatalogRoleAssignmentScopeEnum),
          ) as AccessCatalogRoleAssignmentScopeEnum;
          result.assignmentScope = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccessCatalogRole deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccessCatalogRoleBuilder();
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

class AccessCatalogRoleAssignmentScopeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'company')
  static const AccessCatalogRoleAssignmentScopeEnum company = _$accessCatalogRoleAssignmentScopeEnum_company;
  @BuiltValueEnumConst(wireName: r'department')
  static const AccessCatalogRoleAssignmentScopeEnum department = _$accessCatalogRoleAssignmentScopeEnum_department;
  @BuiltValueEnumConst(wireName: r'location')
  static const AccessCatalogRoleAssignmentScopeEnum location = _$accessCatalogRoleAssignmentScopeEnum_location;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AccessCatalogRoleAssignmentScopeEnum unknownDefaultOpenApi = _$accessCatalogRoleAssignmentScopeEnum_unknownDefaultOpenApi;

  static Serializer<AccessCatalogRoleAssignmentScopeEnum> get serializer => _$accessCatalogRoleAssignmentScopeEnumSerializer;

  const AccessCatalogRoleAssignmentScopeEnum._(String name): super(name);

  static BuiltSet<AccessCatalogRoleAssignmentScopeEnum> get values => _$accessCatalogRoleAssignmentScopeEnumValues;
  static AccessCatalogRoleAssignmentScopeEnum valueOf(String name) => _$accessCatalogRoleAssignmentScopeEnumValueOf(name);
}
