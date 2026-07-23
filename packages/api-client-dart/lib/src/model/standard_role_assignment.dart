//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/user_summary.dart';
import 'package:rajawali_api_client/src/model/standard_role_assignment_role.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/location_summary.dart';
import 'package:rajawali_api_client/src/model/department_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'standard_role_assignment.g.dart';

/// StandardRoleAssignment
///
/// Properties:
/// * [id]
/// * [role]
/// * [companyId]
/// * [department]
/// * [location]
/// * [validFrom]
/// * [validUntil]
/// * [assignedBy]
/// * [revokedAt]
/// * [revokedBy]
/// * [revocationReason]
/// * [status]
/// * [canRevoke]
@BuiltValue()
abstract class StandardRoleAssignment implements Built<StandardRoleAssignment, StandardRoleAssignmentBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'role')
  StandardRoleAssignmentRole get role;

  @BuiltValueField(wireName: r'company_id')
  String get companyId;

  @BuiltValueField(wireName: r'department')
  DepartmentSummary? get department;

  @BuiltValueField(wireName: r'location')
  LocationSummary? get location;

  @BuiltValueField(wireName: r'valid_from')
  DateTime get validFrom;

  @BuiltValueField(wireName: r'valid_until')
  DateTime? get validUntil;

  @BuiltValueField(wireName: r'assigned_by')
  UserSummary get assignedBy;

  @BuiltValueField(wireName: r'revoked_at')
  DateTime? get revokedAt;

  @BuiltValueField(wireName: r'revoked_by')
  UserSummary? get revokedBy;

  @BuiltValueField(wireName: r'revocation_reason')
  String? get revocationReason;

  @BuiltValueField(wireName: r'status')
  StandardRoleAssignmentStatusEnum get status;
  // enum statusEnum {  scheduled,  active,  expired,  revoked,  };

  @BuiltValueField(wireName: r'can_revoke')
  bool get canRevoke;

  StandardRoleAssignment._();

  factory StandardRoleAssignment([void updates(StandardRoleAssignmentBuilder b)]) = _$StandardRoleAssignment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StandardRoleAssignmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StandardRoleAssignment> get serializer => _$StandardRoleAssignmentSerializer();
}

class _$StandardRoleAssignmentSerializer implements PrimitiveSerializer<StandardRoleAssignment> {
  @override
  final Iterable<Type> types = const [StandardRoleAssignment, _$StandardRoleAssignment];

  @override
  final String wireName = r'StandardRoleAssignment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StandardRoleAssignment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(StandardRoleAssignmentRole),
    );
    yield r'company_id';
    yield serializers.serialize(
      object.companyId,
      specifiedType: const FullType(String),
    );
    yield r'department';
    yield object.department == null ? null : serializers.serialize(
      object.department,
      specifiedType: const FullType.nullable(DepartmentSummary),
    );
    yield r'location';
    yield object.location == null ? null : serializers.serialize(
      object.location,
      specifiedType: const FullType.nullable(LocationSummary),
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
    yield r'assigned_by';
    yield serializers.serialize(
      object.assignedBy,
      specifiedType: const FullType(UserSummary),
    );
    yield r'revoked_at';
    yield object.revokedAt == null ? null : serializers.serialize(
      object.revokedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'revoked_by';
    yield object.revokedBy == null ? null : serializers.serialize(
      object.revokedBy,
      specifiedType: const FullType.nullable(UserSummary),
    );
    yield r'revocation_reason';
    yield object.revocationReason == null ? null : serializers.serialize(
      object.revocationReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(StandardRoleAssignmentStatusEnum),
    );
    yield r'can_revoke';
    yield serializers.serialize(
      object.canRevoke,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StandardRoleAssignment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StandardRoleAssignmentBuilder result,
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
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StandardRoleAssignmentRole),
          ) as StandardRoleAssignmentRole;
          result.role.replace(valueDes);
          break;
        case r'company_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.companyId = valueDes;
          break;
        case r'department':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DepartmentSummary),
          ) as DepartmentSummary?;
          if (valueDes == null) continue;
          result.department.replace(valueDes);
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LocationSummary),
          ) as LocationSummary?;
          if (valueDes == null) continue;
          result.location.replace(valueDes);
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
        case r'assigned_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserSummary),
          ) as UserSummary;
          result.assignedBy = valueDes;
          break;
        case r'revoked_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.revokedAt = valueDes;
          break;
        case r'revoked_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UserSummary),
          ) as UserSummary?;
          if (valueDes == null) continue;
          result.revokedBy = valueDes;
          break;
        case r'revocation_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.revocationReason = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StandardRoleAssignmentStatusEnum),
          ) as StandardRoleAssignmentStatusEnum;
          result.status = valueDes;
          break;
        case r'can_revoke':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canRevoke = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StandardRoleAssignment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StandardRoleAssignmentBuilder();
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

class StandardRoleAssignmentStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'scheduled')
  static const StandardRoleAssignmentStatusEnum scheduled = _$standardRoleAssignmentStatusEnum_scheduled;
  @BuiltValueEnumConst(wireName: r'active')
  static const StandardRoleAssignmentStatusEnum active = _$standardRoleAssignmentStatusEnum_active;
  @BuiltValueEnumConst(wireName: r'expired')
  static const StandardRoleAssignmentStatusEnum expired = _$standardRoleAssignmentStatusEnum_expired;
  @BuiltValueEnumConst(wireName: r'revoked')
  static const StandardRoleAssignmentStatusEnum revoked = _$standardRoleAssignmentStatusEnum_revoked;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const StandardRoleAssignmentStatusEnum unknownDefaultOpenApi = _$standardRoleAssignmentStatusEnum_unknownDefaultOpenApi;

  static Serializer<StandardRoleAssignmentStatusEnum> get serializer => _$standardRoleAssignmentStatusEnumSerializer;

  const StandardRoleAssignmentStatusEnum._(String name): super(name);

  static BuiltSet<StandardRoleAssignmentStatusEnum> get values => _$standardRoleAssignmentStatusEnumValues;
  static StandardRoleAssignmentStatusEnum valueOf(String name) => _$standardRoleAssignmentStatusEnumValueOf(name);
}
