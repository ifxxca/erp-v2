//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_invitation_request.g.dart';

/// CreateInvitationRequest
///
/// Properties:
/// * [name]
/// * [email]
/// * [companyId]
/// * [employeeNo]
/// * [departmentIds]
/// * [primaryDepartmentId] - Must be included in department_ids.
/// * [locationIds]
/// * [validFrom]
@BuiltValue()
abstract class CreateInvitationRequest implements Built<CreateInvitationRequest, CreateInvitationRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'company_id')
  String get companyId;

  @BuiltValueField(wireName: r'employee_no')
  String? get employeeNo;

  @BuiltValueField(wireName: r'department_ids')
  BuiltSet<String> get departmentIds;

  /// Must be included in department_ids.
  @BuiltValueField(wireName: r'primary_department_id')
  String get primaryDepartmentId;

  @BuiltValueField(wireName: r'location_ids')
  BuiltSet<String>? get locationIds;

  @BuiltValueField(wireName: r'valid_from')
  Date get validFrom;

  CreateInvitationRequest._();

  factory CreateInvitationRequest([void updates(CreateInvitationRequestBuilder b)]) = _$CreateInvitationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateInvitationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateInvitationRequest> get serializer => _$CreateInvitationRequestSerializer();
}

class _$CreateInvitationRequestSerializer implements PrimitiveSerializer<CreateInvitationRequest> {
  @override
  final Iterable<Type> types = const [CreateInvitationRequest, _$CreateInvitationRequest];

  @override
  final String wireName = r'CreateInvitationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateInvitationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'company_id';
    yield serializers.serialize(
      object.companyId,
      specifiedType: const FullType(String),
    );
    if (object.employeeNo != null) {
      yield r'employee_no';
      yield serializers.serialize(
        object.employeeNo,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'department_ids';
    yield serializers.serialize(
      object.departmentIds,
      specifiedType: const FullType(BuiltSet, [FullType(String)]),
    );
    yield r'primary_department_id';
    yield serializers.serialize(
      object.primaryDepartmentId,
      specifiedType: const FullType(String),
    );
    if (object.locationIds != null) {
      yield r'location_ids';
      yield serializers.serialize(
        object.locationIds,
        specifiedType: const FullType(BuiltSet, [FullType(String)]),
      );
    }
    yield r'valid_from';
    yield serializers.serialize(
      object.validFrom,
      specifiedType: const FullType(Date),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateInvitationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateInvitationRequestBuilder result,
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
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'company_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.companyId = valueDes;
          break;
        case r'employee_no':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.employeeNo = valueDes;
          break;
        case r'department_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>;
          result.departmentIds.replace(valueDes);
          break;
        case r'primary_department_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.primaryDepartmentId = valueDes;
          break;
        case r'location_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>;
          result.locationIds.replace(valueDes);
          break;
        case r'valid_from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.validFrom = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateInvitationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateInvitationRequestBuilder();
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
