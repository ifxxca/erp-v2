//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/date.dart';
import 'package:rajawali_api_client/src/model/employment_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'company_membership.g.dart';

/// CompanyMembership
///
/// Properties:
/// * [id]
/// * [employeeNo]
/// * [employmentStatus]
/// * [isPrimary]
/// * [validFrom]
/// * [validUntil]
@BuiltValue()
abstract class CompanyMembership implements Built<CompanyMembership, CompanyMembershipBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'employee_no')
  String? get employeeNo;

  @BuiltValueField(wireName: r'employment_status')
  EmploymentStatus get employmentStatus;
  // enum employmentStatusEnum {  invited,  active,  leave,  terminated,  };

  @BuiltValueField(wireName: r'is_primary')
  bool get isPrimary;

  @BuiltValueField(wireName: r'valid_from')
  Date get validFrom;

  @BuiltValueField(wireName: r'valid_until')
  Date? get validUntil;

  CompanyMembership._();

  factory CompanyMembership([void updates(CompanyMembershipBuilder b)]) = _$CompanyMembership;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CompanyMembershipBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CompanyMembership> get serializer => _$CompanyMembershipSerializer();
}

class _$CompanyMembershipSerializer implements PrimitiveSerializer<CompanyMembership> {
  @override
  final Iterable<Type> types = const [CompanyMembership, _$CompanyMembership];

  @override
  final String wireName = r'CompanyMembership';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CompanyMembership object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'employee_no';
    yield object.employeeNo == null ? null : serializers.serialize(
      object.employeeNo,
      specifiedType: const FullType.nullable(String),
    );
    yield r'employment_status';
    yield serializers.serialize(
      object.employmentStatus,
      specifiedType: const FullType(EmploymentStatus),
    );
    yield r'is_primary';
    yield serializers.serialize(
      object.isPrimary,
      specifiedType: const FullType(bool),
    );
    yield r'valid_from';
    yield serializers.serialize(
      object.validFrom,
      specifiedType: const FullType(Date),
    );
    yield r'valid_until';
    yield object.validUntil == null ? null : serializers.serialize(
      object.validUntil,
      specifiedType: const FullType.nullable(Date),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CompanyMembership object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CompanyMembershipBuilder result,
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
        case r'employee_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.employeeNo = valueDes;
          break;
        case r'employment_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EmploymentStatus),
          ) as EmploymentStatus;
          result.employmentStatus = valueDes;
          break;
        case r'is_primary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isPrimary = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CompanyMembership deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CompanyMembershipBuilder();
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
