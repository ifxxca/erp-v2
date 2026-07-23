//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_organization_memberships_request.g.dart';

/// UpdateOrganizationMembershipsRequest
///
/// Properties:
/// * [departmentIds]
/// * [primaryDepartmentId] - Must be included in department_ids.
/// * [locationIds]
/// * [effectiveFrom] - Today or a future date; must not conflict with an existing scheduled change.
/// * [reason]
@BuiltValue()
abstract class UpdateOrganizationMembershipsRequest implements Built<UpdateOrganizationMembershipsRequest, UpdateOrganizationMembershipsRequestBuilder> {
  @BuiltValueField(wireName: r'department_ids')
  BuiltSet<String> get departmentIds;

  /// Must be included in department_ids.
  @BuiltValueField(wireName: r'primary_department_id')
  String get primaryDepartmentId;

  @BuiltValueField(wireName: r'location_ids')
  BuiltSet<String> get locationIds;

  /// Today or a future date; must not conflict with an existing scheduled change.
  @BuiltValueField(wireName: r'effective_from')
  Date get effectiveFrom;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  UpdateOrganizationMembershipsRequest._();

  factory UpdateOrganizationMembershipsRequest([void updates(UpdateOrganizationMembershipsRequestBuilder b)]) = _$UpdateOrganizationMembershipsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateOrganizationMembershipsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateOrganizationMembershipsRequest> get serializer => _$UpdateOrganizationMembershipsRequestSerializer();
}

class _$UpdateOrganizationMembershipsRequestSerializer implements PrimitiveSerializer<UpdateOrganizationMembershipsRequest> {
  @override
  final Iterable<Type> types = const [UpdateOrganizationMembershipsRequest, _$UpdateOrganizationMembershipsRequest];

  @override
  final String wireName = r'UpdateOrganizationMembershipsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateOrganizationMembershipsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    yield r'location_ids';
    yield serializers.serialize(
      object.locationIds,
      specifiedType: const FullType(BuiltSet, [FullType(String)]),
    );
    yield r'effective_from';
    yield serializers.serialize(
      object.effectiveFrom,
      specifiedType: const FullType(Date),
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
    UpdateOrganizationMembershipsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateOrganizationMembershipsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'effective_from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.effectiveFrom = valueDes;
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
  UpdateOrganizationMembershipsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateOrganizationMembershipsRequestBuilder();
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
