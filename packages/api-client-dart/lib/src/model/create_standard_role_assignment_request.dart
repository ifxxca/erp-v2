//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_standard_role_assignment_request.g.dart';

/// CreateStandardRoleAssignmentRequest
///
/// Properties:
/// * [roleId] - Must identify a non-privileged company, department, or location role.
/// * [departmentId]
/// * [locationId]
/// * [validFrom]
/// * [validUntil]
/// * [reason]
@BuiltValue()
abstract class CreateStandardRoleAssignmentRequest implements Built<CreateStandardRoleAssignmentRequest, CreateStandardRoleAssignmentRequestBuilder> {
  /// Must identify a non-privileged company, department, or location role.
  @BuiltValueField(wireName: r'role_id')
  String get roleId;

  @BuiltValueField(wireName: r'department_id')
  String? get departmentId;

  @BuiltValueField(wireName: r'location_id')
  String? get locationId;

  @BuiltValueField(wireName: r'valid_from')
  Date get validFrom;

  @BuiltValueField(wireName: r'valid_until')
  Date? get validUntil;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  CreateStandardRoleAssignmentRequest._();

  factory CreateStandardRoleAssignmentRequest([void updates(CreateStandardRoleAssignmentRequestBuilder b)]) = _$CreateStandardRoleAssignmentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateStandardRoleAssignmentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateStandardRoleAssignmentRequest> get serializer => _$CreateStandardRoleAssignmentRequestSerializer();
}

class _$CreateStandardRoleAssignmentRequestSerializer implements PrimitiveSerializer<CreateStandardRoleAssignmentRequest> {
  @override
  final Iterable<Type> types = const [CreateStandardRoleAssignmentRequest, _$CreateStandardRoleAssignmentRequest];

  @override
  final String wireName = r'CreateStandardRoleAssignmentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateStandardRoleAssignmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'role_id';
    yield serializers.serialize(
      object.roleId,
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
    yield r'valid_from';
    yield serializers.serialize(
      object.validFrom,
      specifiedType: const FullType(Date),
    );
    if (object.validUntil != null) {
      yield r'valid_until';
      yield serializers.serialize(
        object.validUntil,
        specifiedType: const FullType.nullable(Date),
      );
    }
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateStandardRoleAssignmentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateStandardRoleAssignmentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.roleId = valueDes;
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
        case r'valid_from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.validFrom = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.validUntil = valueDes;
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
  CreateStandardRoleAssignmentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateStandardRoleAssignmentRequestBuilder();
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
