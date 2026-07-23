//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/standard_access_role.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/standard_role_assignment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'standard_access_catalog_response_data.g.dart';

/// StandardAccessCatalogResponseData
///
/// Properties:
/// * [roles]
/// * [assignments]
@BuiltValue()
abstract class StandardAccessCatalogResponseData implements Built<StandardAccessCatalogResponseData, StandardAccessCatalogResponseDataBuilder> {
  @BuiltValueField(wireName: r'roles')
  BuiltList<StandardAccessRole> get roles;

  @BuiltValueField(wireName: r'assignments')
  BuiltList<StandardRoleAssignment> get assignments;

  StandardAccessCatalogResponseData._();

  factory StandardAccessCatalogResponseData([void updates(StandardAccessCatalogResponseDataBuilder b)]) = _$StandardAccessCatalogResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StandardAccessCatalogResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StandardAccessCatalogResponseData> get serializer => _$StandardAccessCatalogResponseDataSerializer();
}

class _$StandardAccessCatalogResponseDataSerializer implements PrimitiveSerializer<StandardAccessCatalogResponseData> {
  @override
  final Iterable<Type> types = const [StandardAccessCatalogResponseData, _$StandardAccessCatalogResponseData];

  @override
  final String wireName = r'StandardAccessCatalogResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StandardAccessCatalogResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'roles';
    yield serializers.serialize(
      object.roles,
      specifiedType: const FullType(BuiltList, [FullType(StandardAccessRole)]),
    );
    yield r'assignments';
    yield serializers.serialize(
      object.assignments,
      specifiedType: const FullType(BuiltList, [FullType(StandardRoleAssignment)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StandardAccessCatalogResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StandardAccessCatalogResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'roles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(StandardAccessRole)]),
          ) as BuiltList<StandardAccessRole>;
          result.roles.replace(valueDes);
          break;
        case r'assignments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(StandardRoleAssignment)]),
          ) as BuiltList<StandardRoleAssignment>;
          result.assignments.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StandardAccessCatalogResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StandardAccessCatalogResponseDataBuilder();
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
