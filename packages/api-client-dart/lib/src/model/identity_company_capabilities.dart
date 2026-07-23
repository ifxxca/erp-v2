//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'identity_company_capabilities.g.dart';

/// IdentityCompanyCapabilities
///
/// Properties:
/// * [canViewUsers]
/// * [canInviteUsers]
/// * [canManageEmployment]
/// * [canAssignAccess]
/// * [canRequestAccess]
/// * [canApproveAccess]
/// * [canRevokeAccess]
@BuiltValue()
abstract class IdentityCompanyCapabilities implements Built<IdentityCompanyCapabilities, IdentityCompanyCapabilitiesBuilder> {
  @BuiltValueField(wireName: r'can_view_users')
  bool get canViewUsers;

  @BuiltValueField(wireName: r'can_invite_users')
  bool get canInviteUsers;

  @BuiltValueField(wireName: r'can_manage_employment')
  bool get canManageEmployment;

  @BuiltValueField(wireName: r'can_assign_access')
  bool get canAssignAccess;

  @BuiltValueField(wireName: r'can_request_access')
  bool get canRequestAccess;

  @BuiltValueField(wireName: r'can_approve_access')
  bool get canApproveAccess;

  @BuiltValueField(wireName: r'can_revoke_access')
  bool get canRevokeAccess;

  IdentityCompanyCapabilities._();

  factory IdentityCompanyCapabilities([void updates(IdentityCompanyCapabilitiesBuilder b)]) = _$IdentityCompanyCapabilities;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IdentityCompanyCapabilitiesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IdentityCompanyCapabilities> get serializer => _$IdentityCompanyCapabilitiesSerializer();
}

class _$IdentityCompanyCapabilitiesSerializer implements PrimitiveSerializer<IdentityCompanyCapabilities> {
  @override
  final Iterable<Type> types = const [IdentityCompanyCapabilities, _$IdentityCompanyCapabilities];

  @override
  final String wireName = r'IdentityCompanyCapabilities';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IdentityCompanyCapabilities object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'can_view_users';
    yield serializers.serialize(
      object.canViewUsers,
      specifiedType: const FullType(bool),
    );
    yield r'can_invite_users';
    yield serializers.serialize(
      object.canInviteUsers,
      specifiedType: const FullType(bool),
    );
    yield r'can_manage_employment';
    yield serializers.serialize(
      object.canManageEmployment,
      specifiedType: const FullType(bool),
    );
    yield r'can_assign_access';
    yield serializers.serialize(
      object.canAssignAccess,
      specifiedType: const FullType(bool),
    );
    yield r'can_request_access';
    yield serializers.serialize(
      object.canRequestAccess,
      specifiedType: const FullType(bool),
    );
    yield r'can_approve_access';
    yield serializers.serialize(
      object.canApproveAccess,
      specifiedType: const FullType(bool),
    );
    yield r'can_revoke_access';
    yield serializers.serialize(
      object.canRevokeAccess,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    IdentityCompanyCapabilities object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IdentityCompanyCapabilitiesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'can_view_users':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canViewUsers = valueDes;
          break;
        case r'can_invite_users':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canInviteUsers = valueDes;
          break;
        case r'can_manage_employment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canManageEmployment = valueDes;
          break;
        case r'can_assign_access':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canAssignAccess = valueDes;
          break;
        case r'can_request_access':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canRequestAccess = valueDes;
          break;
        case r'can_approve_access':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canApproveAccess = valueDes;
          break;
        case r'can_revoke_access':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canRevokeAccess = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IdentityCompanyCapabilities deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IdentityCompanyCapabilitiesBuilder();
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
