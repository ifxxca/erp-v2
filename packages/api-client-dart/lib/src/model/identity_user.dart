//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/identity_summary.dart';
import 'package:rajawali_api_client/src/model/identity_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/location_membership.dart';
import 'package:rajawali_api_client/src/model/department_membership.dart';
import 'package:rajawali_api_client/src/model/company_membership.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'identity_user.g.dart';

/// IdentityUser
///
/// Properties:
/// * [id]
/// * [name]
/// * [email]
/// * [status]
/// * [lastLoginAt]
/// * [companyMemberships]
/// * [departmentMemberships]
/// * [locationMemberships]
@BuiltValue()
abstract class IdentityUser implements IdentitySummary, Built<IdentityUser, IdentityUserBuilder> {
  @BuiltValueField(wireName: r'last_login_at')
  DateTime? get lastLoginAt;

  @BuiltValueField(wireName: r'company_memberships')
  BuiltList<CompanyMembership> get companyMemberships;

  @BuiltValueField(wireName: r'department_memberships')
  BuiltList<DepartmentMembership> get departmentMemberships;

  @BuiltValueField(wireName: r'location_memberships')
  BuiltList<LocationMembership> get locationMemberships;

  IdentityUser._();

  factory IdentityUser([void updates(IdentityUserBuilder b)]) = _$IdentityUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IdentityUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IdentityUser> get serializer => _$IdentityUserSerializer();
}

class _$IdentityUserSerializer implements PrimitiveSerializer<IdentityUser> {
  @override
  final Iterable<Type> types = const [IdentityUser, _$IdentityUser];

  @override
  final String wireName = r'IdentityUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IdentityUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'last_login_at';
    yield object.lastLoginAt == null ? null : serializers.serialize(
      object.lastLoginAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'company_memberships';
    yield serializers.serialize(
      object.companyMemberships,
      specifiedType: const FullType(BuiltList, [FullType(CompanyMembership)]),
    );
    yield r'department_memberships';
    yield serializers.serialize(
      object.departmentMemberships,
      specifiedType: const FullType(BuiltList, [FullType(DepartmentMembership)]),
    );
    yield r'location_memberships';
    yield serializers.serialize(
      object.locationMemberships,
      specifiedType: const FullType(BuiltList, [FullType(LocationMembership)]),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(IdentityStatus),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    IdentityUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IdentityUserBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'last_login_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastLoginAt = valueDes;
          break;
        case r'company_memberships':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(CompanyMembership)]),
          ) as BuiltList<CompanyMembership>;
          result.companyMemberships.replace(valueDes);
          break;
        case r'department_memberships':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DepartmentMembership)]),
          ) as BuiltList<DepartmentMembership>;
          result.departmentMemberships.replace(valueDes);
          break;
        case r'location_memberships':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(LocationMembership)]),
          ) as BuiltList<LocationMembership>;
          result.locationMemberships.replace(valueDes);
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IdentityStatus),
          ) as IdentityStatus;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IdentityUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IdentityUserBuilder();
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
