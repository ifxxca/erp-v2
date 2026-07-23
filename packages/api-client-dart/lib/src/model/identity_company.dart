//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/identity_company_capabilities.dart';
import 'package:rajawali_api_client/src/model/company_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'identity_company.g.dart';

/// IdentityCompany
///
/// Properties:
/// * [id]
/// * [code]
/// * [legalName]
/// * [capabilities]
@BuiltValue()
abstract class IdentityCompany implements CompanySummary, Built<IdentityCompany, IdentityCompanyBuilder> {
  @BuiltValueField(wireName: r'capabilities')
  IdentityCompanyCapabilities get capabilities;

  IdentityCompany._();

  factory IdentityCompany([void updates(IdentityCompanyBuilder b)]) = _$IdentityCompany;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IdentityCompanyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IdentityCompany> get serializer => _$IdentityCompanySerializer();
}

class _$IdentityCompanySerializer implements PrimitiveSerializer<IdentityCompany> {
  @override
  final Iterable<Type> types = const [IdentityCompany, _$IdentityCompany];

  @override
  final String wireName = r'IdentityCompany';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IdentityCompany object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'legal_name';
    yield serializers.serialize(
      object.legalName,
      specifiedType: const FullType(String),
    );
    yield r'capabilities';
    yield serializers.serialize(
      object.capabilities,
      specifiedType: const FullType(IdentityCompanyCapabilities),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    IdentityCompany object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IdentityCompanyBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'legal_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.legalName = valueDes;
          break;
        case r'capabilities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IdentityCompanyCapabilities),
          ) as IdentityCompanyCapabilities;
          result.capabilities.replace(valueDes);
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IdentityCompany deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IdentityCompanyBuilder();
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
