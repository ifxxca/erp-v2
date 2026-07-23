//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/location_summary.dart';
import 'package:rajawali_api_client/src/model/department_summary.dart';
import 'package:rajawali_api_client/src/model/company_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'organization_catalog.g.dart';

/// OrganizationCatalog
///
/// Properties:
/// * [company]
/// * [departments]
/// * [locations]
@BuiltValue()
abstract class OrganizationCatalog implements Built<OrganizationCatalog, OrganizationCatalogBuilder> {
  @BuiltValueField(wireName: r'company')
  CompanySummary get company;

  @BuiltValueField(wireName: r'departments')
  BuiltList<DepartmentSummary> get departments;

  @BuiltValueField(wireName: r'locations')
  BuiltList<LocationSummary> get locations;

  OrganizationCatalog._();

  factory OrganizationCatalog([void updates(OrganizationCatalogBuilder b)]) = _$OrganizationCatalog;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrganizationCatalogBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrganizationCatalog> get serializer => _$OrganizationCatalogSerializer();
}

class _$OrganizationCatalogSerializer implements PrimitiveSerializer<OrganizationCatalog> {
  @override
  final Iterable<Type> types = const [OrganizationCatalog, _$OrganizationCatalog];

  @override
  final String wireName = r'OrganizationCatalog';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrganizationCatalog object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'company';
    yield serializers.serialize(
      object.company,
      specifiedType: const FullType(CompanySummary),
    );
    yield r'departments';
    yield serializers.serialize(
      object.departments,
      specifiedType: const FullType(BuiltList, [FullType(DepartmentSummary)]),
    );
    yield r'locations';
    yield serializers.serialize(
      object.locations,
      specifiedType: const FullType(BuiltList, [FullType(LocationSummary)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrganizationCatalog object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrganizationCatalogBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'company':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CompanySummary),
          ) as CompanySummary;
          result.company = valueDes;
          break;
        case r'departments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DepartmentSummary)]),
          ) as BuiltList<DepartmentSummary>;
          result.departments.replace(valueDes);
          break;
        case r'locations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(LocationSummary)]),
          ) as BuiltList<LocationSummary>;
          result.locations.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrganizationCatalog deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrganizationCatalogBuilder();
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
