//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/role_summary.dart';
import 'package:rajawali_api_client/src/model/user_summary.dart';
import 'package:rajawali_api_client/src/model/access_request_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'privileged_access_request.g.dart';

/// PrivilegedAccessRequest
///
/// Properties:
/// * [id]
/// * [status]
/// * [targetUser]
/// * [targetMfaEnabled] - Current MFA readiness snapshot for approval UX; the approval mutation revalidates server-side.
/// * [role]
/// * [companyId]
/// * [departmentId]
/// * [locationId]
/// * [reason]
/// * [validUntil]
/// * [requestedBy]
/// * [decidedBy]
/// * [decidedAt]
/// * [decisionNote]
@BuiltValue()
abstract class PrivilegedAccessRequest implements Built<PrivilegedAccessRequest, PrivilegedAccessRequestBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'status')
  AccessRequestStatus get status;
  // enum statusEnum {  pending,  approved,  rejected,  cancelled,  };

  @BuiltValueField(wireName: r'target_user')
  UserSummary get targetUser;

  /// Current MFA readiness snapshot for approval UX; the approval mutation revalidates server-side.
  @BuiltValueField(wireName: r'target_mfa_enabled')
  bool get targetMfaEnabled;

  @BuiltValueField(wireName: r'role')
  RoleSummary get role;

  @BuiltValueField(wireName: r'company_id')
  String get companyId;

  @BuiltValueField(wireName: r'department_id')
  String? get departmentId;

  @BuiltValueField(wireName: r'location_id')
  String? get locationId;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  @BuiltValueField(wireName: r'requested_by')
  UserSummary get requestedBy;

  @BuiltValueField(wireName: r'decided_by')
  UserSummary? get decidedBy;

  @BuiltValueField(wireName: r'decided_at')
  DateTime? get decidedAt;

  @BuiltValueField(wireName: r'decision_note')
  String? get decisionNote;

  PrivilegedAccessRequest._();

  factory PrivilegedAccessRequest([void updates(PrivilegedAccessRequestBuilder b)]) = _$PrivilegedAccessRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrivilegedAccessRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrivilegedAccessRequest> get serializer => _$PrivilegedAccessRequestSerializer();
}

class _$PrivilegedAccessRequestSerializer implements PrimitiveSerializer<PrivilegedAccessRequest> {
  @override
  final Iterable<Type> types = const [PrivilegedAccessRequest, _$PrivilegedAccessRequest];

  @override
  final String wireName = r'PrivilegedAccessRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrivilegedAccessRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(AccessRequestStatus),
    );
    yield r'target_user';
    yield serializers.serialize(
      object.targetUser,
      specifiedType: const FullType(UserSummary),
    );
    yield r'target_mfa_enabled';
    yield serializers.serialize(
      object.targetMfaEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(RoleSummary),
    );
    yield r'company_id';
    yield serializers.serialize(
      object.companyId,
      specifiedType: const FullType(String),
    );
    if (object.departmentId != null) {
      yield r'department_id';
      yield serializers.serialize(
        object.departmentId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.locationId != null) {
      yield r'location_id';
      yield serializers.serialize(
        object.locationId,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    yield r'valid_until';
    yield serializers.serialize(
      object.validUntil,
      specifiedType: const FullType(DateTime),
    );
    yield r'requested_by';
    yield serializers.serialize(
      object.requestedBy,
      specifiedType: const FullType(UserSummary),
    );
    if (object.decidedBy != null) {
      yield r'decided_by';
      yield serializers.serialize(
        object.decidedBy,
        specifiedType: const FullType.nullable(UserSummary),
      );
    }
    if (object.decidedAt != null) {
      yield r'decided_at';
      yield serializers.serialize(
        object.decidedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.decisionNote != null) {
      yield r'decision_note';
      yield serializers.serialize(
        object.decisionNote,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PrivilegedAccessRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PrivilegedAccessRequestBuilder result,
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccessRequestStatus),
          ) as AccessRequestStatus;
          result.status = valueDes;
          break;
        case r'target_user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserSummary),
          ) as UserSummary;
          result.targetUser = valueDes;
          break;
        case r'target_mfa_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.targetMfaEnabled = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RoleSummary),
          ) as RoleSummary;
          result.role = valueDes;
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
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validUntil = valueDes;
          break;
        case r'requested_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserSummary),
          ) as UserSummary;
          result.requestedBy = valueDes;
          break;
        case r'decided_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UserSummary),
          ) as UserSummary?;
          if (valueDes == null) continue;
          result.decidedBy = valueDes;
          break;
        case r'decided_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.decidedAt = valueDes;
          break;
        case r'decision_note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.decisionNote = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrivilegedAccessRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrivilegedAccessRequestBuilder();
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
