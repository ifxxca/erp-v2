//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/role_permission_summary.dart';
import 'package:rajawali_api_client/src/model/role_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/role_assignment_scope.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_mutation_response_data.g.dart';

/// RoleMutationResponseData
///
/// Properties:
/// * [id]
/// * [code]
/// * [name]
/// * [description]
/// * [isSystem]
/// * [isPrivileged]
/// * [assignmentScope]
/// * [permissions]
@BuiltValue()
abstract class RoleMutationResponseData implements RoleSummary, Built<RoleMutationResponseData, RoleMutationResponseDataBuilder> {
  @BuiltValueField(wireName: r'is_system')
  bool get isSystem;

  @BuiltValueField(wireName: r'is_privileged')
  bool get isPrivileged;

  @BuiltValueField(wireName: r'permissions')
  BuiltList<RolePermissionSummary> get permissions;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'assignment_scope')
  RoleAssignmentScope get assignmentScope;
  // enum assignmentScopeEnum {  global,  company,  department,  location,  };

  RoleMutationResponseData._();

  factory RoleMutationResponseData([void updates(RoleMutationResponseDataBuilder b)]) = _$RoleMutationResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleMutationResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleMutationResponseData> get serializer => _$RoleMutationResponseDataSerializer();
}

class _$RoleMutationResponseDataSerializer implements PrimitiveSerializer<RoleMutationResponseData> {
  @override
  final Iterable<Type> types = const [RoleMutationResponseData, _$RoleMutationResponseData];

  @override
  final String wireName = r'RoleMutationResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleMutationResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'permissions';
    yield serializers.serialize(
      object.permissions,
      specifiedType: const FullType(BuiltList, [FullType(RolePermissionSummary)]),
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
    RoleMutationResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RoleMutationResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'permissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(RolePermissionSummary)]),
          ) as BuiltList<RolePermissionSummary>;
          result.permissions.replace(valueDes);
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
  RoleMutationResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleMutationResponseDataBuilder();
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
