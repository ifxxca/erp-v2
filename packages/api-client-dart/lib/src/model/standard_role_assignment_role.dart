//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/role_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/role_assignment_scope.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'standard_role_assignment_role.g.dart';

/// StandardRoleAssignmentRole
///
/// Properties:
/// * [id]
/// * [code]
/// * [name]
/// * [assignmentScope]
/// * [isPrivileged]
@BuiltValue()
abstract class StandardRoleAssignmentRole implements RoleSummary, Built<StandardRoleAssignmentRole, StandardRoleAssignmentRoleBuilder> {
  @BuiltValueField(wireName: r'is_privileged')
  StandardRoleAssignmentRoleIsPrivilegedEnum get isPrivileged;
  // enum isPrivilegedEnum {  false,  };

  @BuiltValueField(wireName: r'assignment_scope')
  RoleAssignmentScope get assignmentScope;
  // enum assignmentScopeEnum {  global,  company,  department,  location,  };

  StandardRoleAssignmentRole._();

  factory StandardRoleAssignmentRole([void updates(StandardRoleAssignmentRoleBuilder b)]) = _$StandardRoleAssignmentRole;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StandardRoleAssignmentRoleBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StandardRoleAssignmentRole> get serializer => _$StandardRoleAssignmentRoleSerializer();
}

class _$StandardRoleAssignmentRoleSerializer implements PrimitiveSerializer<StandardRoleAssignmentRole> {
  @override
  final Iterable<Type> types = const [StandardRoleAssignmentRole, _$StandardRoleAssignmentRole];

  @override
  final String wireName = r'StandardRoleAssignmentRole';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StandardRoleAssignmentRole object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'is_privileged';
    yield serializers.serialize(
      object.isPrivileged,
      specifiedType: const FullType(StandardRoleAssignmentRoleIsPrivilegedEnum),
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
      specifiedType: const FullType(RoleAssignmentScope),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StandardRoleAssignmentRole object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StandardRoleAssignmentRoleBuilder result,
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
        case r'is_privileged':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StandardRoleAssignmentRoleIsPrivilegedEnum),
          ) as StandardRoleAssignmentRoleIsPrivilegedEnum;
          result.isPrivileged = valueDes;
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
            specifiedType: const FullType(RoleAssignmentScope),
          ) as RoleAssignmentScope;
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
  StandardRoleAssignmentRole deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StandardRoleAssignmentRoleBuilder();
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

class StandardRoleAssignmentRoleIsPrivilegedEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'false')
  static const StandardRoleAssignmentRoleIsPrivilegedEnum false_ = _$standardRoleAssignmentRoleIsPrivilegedEnum_false_;
  @BuiltValueEnumConst(wireName: r'11184809', fallback: true)
  static const StandardRoleAssignmentRoleIsPrivilegedEnum unknownDefaultOpenApi = _$standardRoleAssignmentRoleIsPrivilegedEnum_unknownDefaultOpenApi;

  static Serializer<StandardRoleAssignmentRoleIsPrivilegedEnum> get serializer => _$standardRoleAssignmentRoleIsPrivilegedEnumSerializer;

  const StandardRoleAssignmentRoleIsPrivilegedEnum._(String name): super(name);

  static BuiltSet<StandardRoleAssignmentRoleIsPrivilegedEnum> get values => _$standardRoleAssignmentRoleIsPrivilegedEnumValues;
  static StandardRoleAssignmentRoleIsPrivilegedEnum valueOf(String name) => _$standardRoleAssignmentRoleIsPrivilegedEnumValueOf(name);
}
