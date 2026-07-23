//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/privileged_role_assignment_role.dart';
import 'package:rajawali_api_client/src/model/user_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'privileged_role_assignment.g.dart';

/// PrivilegedRoleAssignment
///
/// Properties:
/// * [id]
/// * [user]
/// * [role]
/// * [companyId]
/// * [departmentId]
/// * [locationId]
/// * [accessRequestId]
/// * [validFrom]
/// * [validUntil]
@BuiltValue()
abstract class PrivilegedRoleAssignment implements Built<PrivilegedRoleAssignment, PrivilegedRoleAssignmentBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'user')
  UserSummary get user;

  @BuiltValueField(wireName: r'role')
  PrivilegedRoleAssignmentRole get role;

  @BuiltValueField(wireName: r'company_id')
  String get companyId;

  @BuiltValueField(wireName: r'department_id')
  String? get departmentId;

  @BuiltValueField(wireName: r'location_id')
  String? get locationId;

  @BuiltValueField(wireName: r'access_request_id')
  String? get accessRequestId;

  @BuiltValueField(wireName: r'valid_from')
  DateTime get validFrom;

  @BuiltValueField(wireName: r'valid_until')
  DateTime? get validUntil;

  PrivilegedRoleAssignment._();

  factory PrivilegedRoleAssignment([void updates(PrivilegedRoleAssignmentBuilder b)]) = _$PrivilegedRoleAssignment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrivilegedRoleAssignmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrivilegedRoleAssignment> get serializer => _$PrivilegedRoleAssignmentSerializer();
}

class _$PrivilegedRoleAssignmentSerializer implements PrimitiveSerializer<PrivilegedRoleAssignment> {
  @override
  final Iterable<Type> types = const [PrivilegedRoleAssignment, _$PrivilegedRoleAssignment];

  @override
  final String wireName = r'PrivilegedRoleAssignment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrivilegedRoleAssignment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(UserSummary),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(PrivilegedRoleAssignmentRole),
    );
    yield r'company_id';
    yield serializers.serialize(
      object.companyId,
      specifiedType: const FullType(String),
    );
    yield r'department_id';
    yield object.departmentId == null ? null : serializers.serialize(
      object.departmentId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'location_id';
    yield object.locationId == null ? null : serializers.serialize(
      object.locationId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'access_request_id';
    yield object.accessRequestId == null ? null : serializers.serialize(
      object.accessRequestId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'valid_from';
    yield serializers.serialize(
      object.validFrom,
      specifiedType: const FullType(DateTime),
    );
    yield r'valid_until';
    yield object.validUntil == null ? null : serializers.serialize(
      object.validUntil,
      specifiedType: const FullType.nullable(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PrivilegedRoleAssignment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PrivilegedRoleAssignmentBuilder result,
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
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserSummary),
          ) as UserSummary;
          result.user = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PrivilegedRoleAssignmentRole),
          ) as PrivilegedRoleAssignmentRole;
          result.role.replace(valueDes);
          break;
        case r'company_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.companyId = valueDes;
          break;
        case r'department_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.departmentId = valueDes;
          break;
        case r'location_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.locationId = valueDes;
          break;
        case r'access_request_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.accessRequestId = valueDes;
          break;
        case r'valid_from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validFrom = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.validUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrivilegedRoleAssignment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrivilegedRoleAssignmentBuilder();
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
