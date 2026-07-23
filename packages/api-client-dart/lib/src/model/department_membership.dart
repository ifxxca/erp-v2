//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/date.dart';
import 'package:rajawali_api_client/src/model/department_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'department_membership.g.dart';

/// DepartmentMembership
///
/// Properties:
/// * [id]
/// * [department]
/// * [isPrimary]
/// * [validFrom]
/// * [validUntil]
@BuiltValue()
abstract class DepartmentMembership implements Built<DepartmentMembership, DepartmentMembershipBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'department')
  DepartmentSummary get department;

  @BuiltValueField(wireName: r'is_primary')
  bool get isPrimary;

  @BuiltValueField(wireName: r'valid_from')
  Date get validFrom;

  @BuiltValueField(wireName: r'valid_until')
  Date? get validUntil;

  DepartmentMembership._();

  factory DepartmentMembership([void updates(DepartmentMembershipBuilder b)]) = _$DepartmentMembership;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepartmentMembershipBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepartmentMembership> get serializer => _$DepartmentMembershipSerializer();
}

class _$DepartmentMembershipSerializer implements PrimitiveSerializer<DepartmentMembership> {
  @override
  final Iterable<Type> types = const [DepartmentMembership, _$DepartmentMembership];

  @override
  final String wireName = r'DepartmentMembership';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepartmentMembership object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'department';
    yield serializers.serialize(
      object.department,
      specifiedType: const FullType(DepartmentSummary),
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
    DepartmentMembership object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepartmentMembershipBuilder result,
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
        case r'department':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepartmentSummary),
          ) as DepartmentSummary;
          result.department.replace(valueDes);
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
  DepartmentMembership deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepartmentMembershipBuilder();
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
