//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'custom_role_profile.g.dart';

/// CustomRoleProfile
///
/// Properties:
/// * [name]
/// * [description]
/// * [isPrivileged]
/// * [assignmentScope]
/// * [reason]
@BuiltValue(instantiable: false)
abstract class CustomRoleProfile  {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'is_privileged')
  bool get isPrivileged;

  @BuiltValueField(wireName: r'assignment_scope')
  CustomRoleProfileAssignmentScopeEnum get assignmentScope;
  // enum assignmentScopeEnum {  company,  department,  location,  };

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueSerializer(custom: true)
  static Serializer<CustomRoleProfile> get serializer => _$CustomRoleProfileSerializer();
}

class _$CustomRoleProfileSerializer implements PrimitiveSerializer<CustomRoleProfile> {
  @override
  final Iterable<Type> types = const [CustomRoleProfile];

  @override
  final String wireName = r'CustomRoleProfile';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CustomRoleProfile object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    yield r'is_privileged';
    yield serializers.serialize(
      object.isPrivileged,
      specifiedType: const FullType(bool),
    );
    yield r'assignment_scope';
    yield serializers.serialize(
      object.assignmentScope,
      specifiedType: const FullType(CustomRoleProfileAssignmentScopeEnum),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CustomRoleProfile object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  CustomRoleProfile deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($CustomRoleProfile)) as $CustomRoleProfile;
  }
}

/// a concrete implementation of [CustomRoleProfile], since [CustomRoleProfile] is not instantiable
@BuiltValue(instantiable: true)
abstract class $CustomRoleProfile implements CustomRoleProfile, Built<$CustomRoleProfile, $CustomRoleProfileBuilder> {
  $CustomRoleProfile._();

  factory $CustomRoleProfile([void Function($CustomRoleProfileBuilder)? updates]) = _$$CustomRoleProfile;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($CustomRoleProfileBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$CustomRoleProfile> get serializer => _$$CustomRoleProfileSerializer();
}

class _$$CustomRoleProfileSerializer implements PrimitiveSerializer<$CustomRoleProfile> {
  @override
  final Iterable<Type> types = const [$CustomRoleProfile, _$$CustomRoleProfile];

  @override
  final String wireName = r'$CustomRoleProfile';

  @override
  Object serialize(
    Serializers serializers,
    $CustomRoleProfile object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(CustomRoleProfile))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CustomRoleProfileBuilder result,
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
            specifiedType: const FullType(CustomRoleProfileAssignmentScopeEnum),
          ) as CustomRoleProfileAssignmentScopeEnum;
          result.assignmentScope = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $CustomRoleProfile deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $CustomRoleProfileBuilder();
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

class CustomRoleProfileAssignmentScopeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'company')
  static const CustomRoleProfileAssignmentScopeEnum company = _$customRoleProfileAssignmentScopeEnum_company;
  @BuiltValueEnumConst(wireName: r'department')
  static const CustomRoleProfileAssignmentScopeEnum department = _$customRoleProfileAssignmentScopeEnum_department;
  @BuiltValueEnumConst(wireName: r'location')
  static const CustomRoleProfileAssignmentScopeEnum location = _$customRoleProfileAssignmentScopeEnum_location;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CustomRoleProfileAssignmentScopeEnum unknownDefaultOpenApi = _$customRoleProfileAssignmentScopeEnum_unknownDefaultOpenApi;

  static Serializer<CustomRoleProfileAssignmentScopeEnum> get serializer => _$customRoleProfileAssignmentScopeEnumSerializer;

  const CustomRoleProfileAssignmentScopeEnum._(String name): super(name);

  static BuiltSet<CustomRoleProfileAssignmentScopeEnum> get values => _$customRoleProfileAssignmentScopeEnumValues;
  static CustomRoleProfileAssignmentScopeEnum valueOf(String name) => _$customRoleProfileAssignmentScopeEnumValueOf(name);
}
