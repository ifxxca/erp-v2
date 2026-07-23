//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/role_summary.dart';
import 'package:rajawali_api_client/src/model/role_assignment_scope.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'privileged_role_assignment_role.g.dart';

/// PrivilegedRoleAssignmentRole
///
/// Properties:
/// * [id]
/// * [code]
/// * [name]
/// * [assignmentScope]
@BuiltValue()
abstract class PrivilegedRoleAssignmentRole implements RoleSummary, Built<PrivilegedRoleAssignmentRole, PrivilegedRoleAssignmentRoleBuilder> {
  @BuiltValueField(wireName: r'assignment_scope')
  RoleAssignmentScope get assignmentScope;
  // enum assignmentScopeEnum {  global,  company,  department,  location,  };

  PrivilegedRoleAssignmentRole._();

  factory PrivilegedRoleAssignmentRole([void updates(PrivilegedRoleAssignmentRoleBuilder b)]) = _$PrivilegedRoleAssignmentRole;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrivilegedRoleAssignmentRoleBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrivilegedRoleAssignmentRole> get serializer => _$PrivilegedRoleAssignmentRoleSerializer();
}

class _$PrivilegedRoleAssignmentRoleSerializer implements PrimitiveSerializer<PrivilegedRoleAssignmentRole> {
  @override
  final Iterable<Type> types = const [PrivilegedRoleAssignmentRole, _$PrivilegedRoleAssignmentRole];

  @override
  final String wireName = r'PrivilegedRoleAssignmentRole';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrivilegedRoleAssignmentRole object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
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
    PrivilegedRoleAssignmentRole object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PrivilegedRoleAssignmentRoleBuilder result,
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
  PrivilegedRoleAssignmentRole deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrivilegedRoleAssignmentRoleBuilder();
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
