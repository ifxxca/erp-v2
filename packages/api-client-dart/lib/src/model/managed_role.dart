//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/role_assignment_scope.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'managed_role.g.dart';

/// ManagedRole
///
/// Properties:
/// * [id]
/// * [code]
/// * [name]
/// * [description]
/// * [isSystem]
/// * [isPrivileged]
/// * [assignmentScope]
/// * [permissionIds]
/// * [permissionCount]
/// * [assignmentCount]
/// * [activeAssignmentCount]
/// * [hasHistory]
/// * [canEdit]
@BuiltValue()
abstract class ManagedRole implements Built<ManagedRole, ManagedRoleBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'is_system')
  bool get isSystem;

  @BuiltValueField(wireName: r'is_privileged')
  bool get isPrivileged;

  @BuiltValueField(wireName: r'assignment_scope')
  RoleAssignmentScope get assignmentScope;
  // enum assignmentScopeEnum {  global,  company,  department,  location,  };

  @BuiltValueField(wireName: r'permission_ids')
  BuiltSet<String> get permissionIds;

  @BuiltValueField(wireName: r'permission_count')
  int get permissionCount;

  @BuiltValueField(wireName: r'assignment_count')
  int get assignmentCount;

  @BuiltValueField(wireName: r'active_assignment_count')
  int get activeAssignmentCount;

  @BuiltValueField(wireName: r'has_history')
  bool get hasHistory;

  @BuiltValueField(wireName: r'can_edit')
  bool get canEdit;

  ManagedRole._();

  factory ManagedRole([void updates(ManagedRoleBuilder b)]) = _$ManagedRole;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ManagedRoleBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ManagedRole> get serializer => _$ManagedRoleSerializer();
}

class _$ManagedRoleSerializer implements PrimitiveSerializer<ManagedRole> {
  @override
  final Iterable<Type> types = const [ManagedRole, _$ManagedRole];

  @override
  final String wireName = r'ManagedRole';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ManagedRole object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
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
    yield r'is_system';
    yield serializers.serialize(
      object.isSystem,
      specifiedType: const FullType(bool),
    );
    yield r'is_privileged';
    yield serializers.serialize(
      object.isPrivileged,
      specifiedType: const FullType(bool),
    );
    yield r'assignment_scope';
    yield serializers.serialize(
      object.assignmentScope,
      specifiedType: const FullType(RoleAssignmentScope),
    );
    yield r'permission_ids';
    yield serializers.serialize(
      object.permissionIds,
      specifiedType: const FullType(BuiltSet, [FullType(String)]),
    );
    yield r'permission_count';
    yield serializers.serialize(
      object.permissionCount,
      specifiedType: const FullType(int),
    );
    yield r'assignment_count';
    yield serializers.serialize(
      object.assignmentCount,
      specifiedType: const FullType(int),
    );
    yield r'active_assignment_count';
    yield serializers.serialize(
      object.activeAssignmentCount,
      specifiedType: const FullType(int),
    );
    yield r'has_history';
    yield serializers.serialize(
      object.hasHistory,
      specifiedType: const FullType(bool),
    );
    yield r'can_edit';
    yield serializers.serialize(
      object.canEdit,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ManagedRole object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ManagedRoleBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
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
        case r'is_system':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isSystem = valueDes;
          break;
        case r'is_privileged':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isPrivileged = valueDes;
          break;
        case r'assignment_scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RoleAssignmentScope),
          ) as RoleAssignmentScope;
          result.assignmentScope = valueDes;
          break;
        case r'permission_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>;
          result.permissionIds.replace(valueDes);
          break;
        case r'permission_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.permissionCount = valueDes;
          break;
        case r'assignment_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.assignmentCount = valueDes;
          break;
        case r'active_assignment_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.activeAssignmentCount = valueDes;
          break;
        case r'has_history':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasHistory = valueDes;
          break;
        case r'can_edit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canEdit = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ManagedRole deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ManagedRoleBuilder();
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
