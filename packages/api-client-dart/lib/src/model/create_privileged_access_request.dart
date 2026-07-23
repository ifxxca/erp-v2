//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_privileged_access_request.g.dart';

/// CreatePrivilegedAccessRequest
///
/// Properties:
/// * [targetUserId]
/// * [roleId] - Must identify a privileged role whose assignment_scope is company, department, or location; global-only roles are rejected.
/// * [departmentId]
/// * [locationId]
/// * [reason]
/// * [validUntil] - Must be in the future and no more than 90 days from request time.
@BuiltValue()
abstract class CreatePrivilegedAccessRequest implements Built<CreatePrivilegedAccessRequest, CreatePrivilegedAccessRequestBuilder> {
  @BuiltValueField(wireName: r'target_user_id')
  String get targetUserId;

  /// Must identify a privileged role whose assignment_scope is company, department, or location; global-only roles are rejected.
  @BuiltValueField(wireName: r'role_id')
  String get roleId;

  @BuiltValueField(wireName: r'department_id')
  String? get departmentId;

  @BuiltValueField(wireName: r'location_id')
  String? get locationId;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  /// Must be in the future and no more than 90 days from request time.
  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  CreatePrivilegedAccessRequest._();

  factory CreatePrivilegedAccessRequest([void updates(CreatePrivilegedAccessRequestBuilder b)]) = _$CreatePrivilegedAccessRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatePrivilegedAccessRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatePrivilegedAccessRequest> get serializer => _$CreatePrivilegedAccessRequestSerializer();
}

class _$CreatePrivilegedAccessRequestSerializer implements PrimitiveSerializer<CreatePrivilegedAccessRequest> {
  @override
  final Iterable<Type> types = const [CreatePrivilegedAccessRequest, _$CreatePrivilegedAccessRequest];

  @override
  final String wireName = r'CreatePrivilegedAccessRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatePrivilegedAccessRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'target_user_id';
    yield serializers.serialize(
      object.targetUserId,
      specifiedType: const FullType(String),
    );
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CreatePrivilegedAccessRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatePrivilegedAccessRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'target_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.targetUserId = valueDes;
          break;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreatePrivilegedAccessRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatePrivilegedAccessRequestBuilder();
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
