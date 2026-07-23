//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/custom_role_profile.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_role_request.g.dart';

/// CreateRoleRequest
///
/// Properties:
/// * [name]
/// * [description]
/// * [isPrivileged]
/// * [assignmentScope]
/// * [reason]
/// * [code]
/// * [permissionIds]
@BuiltValue()
abstract class CreateRoleRequest implements CustomRoleProfile, Built<CreateRoleRequest, CreateRoleRequestBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'permission_ids')
  BuiltSet<String> get permissionIds;

  CreateRoleRequest._();

  factory CreateRoleRequest([void updates(CreateRoleRequestBuilder b)]) = _$CreateRoleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateRoleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateRoleRequest> get serializer => _$CreateRoleRequestSerializer();
}

class _$CreateRoleRequestSerializer implements PrimitiveSerializer<CreateRoleRequest> {
  @override
  final Iterable<Type> types = const [CreateRoleRequest, _$CreateRoleRequest];

  @override
  final String wireName = r'CreateRoleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'is_privileged';
    yield serializers.serialize(
      object.isPrivileged,
      specifiedType: const FullType(bool),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'permission_ids';
    yield serializers.serialize(
      object.permissionIds,
      specifiedType: const FullType(BuiltSet, [FullType(String)]),
    );
    yield r'assignment_scope';
    yield serializers.serialize(
      object.assignmentScope,
      specifiedType: const FullType(CustomRoleProfileAssignmentScopeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateRoleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateRoleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'is_privileged':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isPrivileged = valueDes;
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
        case r'permission_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>;
          result.permissionIds.replace(valueDes);
          break;
        case r'assignment_scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CustomRoleProfileAssignmentScopeEnum),
          ) as CustomRoleProfileAssignmentScopeEnum;
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
  CreateRoleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateRoleRequestBuilder();
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

class CreateRoleRequestAssignmentScopeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'company')
  static const CreateRoleRequestAssignmentScopeEnum company = _$createRoleRequestAssignmentScopeEnum_company;
  @BuiltValueEnumConst(wireName: r'department')
  static const CreateRoleRequestAssignmentScopeEnum department = _$createRoleRequestAssignmentScopeEnum_department;
  @BuiltValueEnumConst(wireName: r'location')
  static const CreateRoleRequestAssignmentScopeEnum location = _$createRoleRequestAssignmentScopeEnum_location;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateRoleRequestAssignmentScopeEnum unknownDefaultOpenApi = _$createRoleRequestAssignmentScopeEnum_unknownDefaultOpenApi;

  static Serializer<CreateRoleRequestAssignmentScopeEnum> get serializer => _$createRoleRequestAssignmentScopeEnumSerializer;

  const CreateRoleRequestAssignmentScopeEnum._(String name): super(name);

  static BuiltSet<CreateRoleRequestAssignmentScopeEnum> get values => _$createRoleRequestAssignmentScopeEnumValues;
  static CreateRoleRequestAssignmentScopeEnum valueOf(String name) => _$createRoleRequestAssignmentScopeEnumValueOf(name);
}
