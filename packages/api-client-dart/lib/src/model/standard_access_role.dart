//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/role_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'standard_access_role.g.dart';

/// StandardAccessRole
///
/// Properties:
/// * [id]
/// * [code]
/// * [name]
/// * [description]
/// * [assignmentScope]
@BuiltValue()
abstract class StandardAccessRole implements RoleSummary, Built<StandardAccessRole, StandardAccessRoleBuilder> {
  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'assignment_scope')
  StandardAccessRoleAssignmentScopeEnum get assignmentScope;
  // enum assignmentScopeEnum {  company,  department,  location,  };

  StandardAccessRole._();

  factory StandardAccessRole([void updates(StandardAccessRoleBuilder b)]) = _$StandardAccessRole;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StandardAccessRoleBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StandardAccessRole> get serializer => _$StandardAccessRoleSerializer();
}

class _$StandardAccessRoleSerializer implements PrimitiveSerializer<StandardAccessRole> {
  @override
  final Iterable<Type> types = const [StandardAccessRole, _$StandardAccessRole];

  @override
  final String wireName = r'StandardAccessRole';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StandardAccessRole object, {
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
      specifiedType: const FullType(StandardAccessRoleAssignmentScopeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StandardAccessRole object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StandardAccessRoleBuilder result,
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
            specifiedType: const FullType(StandardAccessRoleAssignmentScopeEnum),
          ) as StandardAccessRoleAssignmentScopeEnum;
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
  StandardAccessRole deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StandardAccessRoleBuilder();
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

class StandardAccessRoleAssignmentScopeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'company')
  static const StandardAccessRoleAssignmentScopeEnum company = _$standardAccessRoleAssignmentScopeEnum_company;
  @BuiltValueEnumConst(wireName: r'department')
  static const StandardAccessRoleAssignmentScopeEnum department = _$standardAccessRoleAssignmentScopeEnum_department;
  @BuiltValueEnumConst(wireName: r'location')
  static const StandardAccessRoleAssignmentScopeEnum location = _$standardAccessRoleAssignmentScopeEnum_location;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const StandardAccessRoleAssignmentScopeEnum unknownDefaultOpenApi = _$standardAccessRoleAssignmentScopeEnum_unknownDefaultOpenApi;

  static Serializer<StandardAccessRoleAssignmentScopeEnum> get serializer => _$standardAccessRoleAssignmentScopeEnumSerializer;

  const StandardAccessRoleAssignmentScopeEnum._(String name): super(name);

  static BuiltSet<StandardAccessRoleAssignmentScopeEnum> get values => _$standardAccessRoleAssignmentScopeEnumValues;
  static StandardAccessRoleAssignmentScopeEnum valueOf(String name) => _$standardAccessRoleAssignmentScopeEnumValueOf(name);
}
