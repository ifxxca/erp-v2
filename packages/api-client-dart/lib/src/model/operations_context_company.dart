//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'operations_context_company.g.dart';

/// OperationsContextCompany
///
/// Properties:
/// * [id]
/// * [code]
/// * [legalName]
@BuiltValue()
abstract class OperationsContextCompany implements Built<OperationsContextCompany, OperationsContextCompanyBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'legal_name')
  String get legalName;

  OperationsContextCompany._();

  factory OperationsContextCompany([void updates(OperationsContextCompanyBuilder b)]) = _$OperationsContextCompany;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OperationsContextCompanyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OperationsContextCompany> get serializer => _$OperationsContextCompanySerializer();
}

class _$OperationsContextCompanySerializer implements PrimitiveSerializer<OperationsContextCompany> {
  @override
  final Iterable<Type> types = const [OperationsContextCompany, _$OperationsContextCompany];

  @override
  final String wireName = r'OperationsContextCompany';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OperationsContextCompany object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'legal_name';
    yield serializers.serialize(
      object.legalName,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OperationsContextCompany object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OperationsContextCompanyBuilder result,
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
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'legal_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.legalName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OperationsContextCompany deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OperationsContextCompanyBuilder();
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
