//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/operations_context_location.dart';
import 'package:rajawali_api_client/src/model/operations_context_company.dart';
import 'package:rajawali_api_client/src/model/operations_capabilities.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'operations_context.g.dart';

/// OperationsContext
///
/// Properties:
/// * [company]
/// * [location]
/// * [capabilities]
@BuiltValue()
abstract class OperationsContext implements Built<OperationsContext, OperationsContextBuilder> {
  @BuiltValueField(wireName: r'company')
  OperationsContextCompany get company;

  @BuiltValueField(wireName: r'location')
  OperationsContextLocation get location;

  @BuiltValueField(wireName: r'capabilities')
  OperationsCapabilities get capabilities;

  OperationsContext._();

  factory OperationsContext([void updates(OperationsContextBuilder b)]) = _$OperationsContext;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OperationsContextBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OperationsContext> get serializer => _$OperationsContextSerializer();
}

class _$OperationsContextSerializer implements PrimitiveSerializer<OperationsContext> {
  @override
  final Iterable<Type> types = const [OperationsContext, _$OperationsContext];

  @override
  final String wireName = r'OperationsContext';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OperationsContext object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'company';
    yield serializers.serialize(
      object.company,
      specifiedType: const FullType(OperationsContextCompany),
    );
    yield r'location';
    yield serializers.serialize(
      object.location,
      specifiedType: const FullType(OperationsContextLocation),
    );
    yield r'capabilities';
    yield serializers.serialize(
      object.capabilities,
      specifiedType: const FullType(OperationsCapabilities),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OperationsContext object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OperationsContextBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'company':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OperationsContextCompany),
          ) as OperationsContextCompany;
          result.company.replace(valueDes);
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OperationsContextLocation),
          ) as OperationsContextLocation;
          result.location.replace(valueDes);
          break;
        case r'capabilities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OperationsCapabilities),
          ) as OperationsCapabilities;
          result.capabilities.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OperationsContext deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OperationsContextBuilder();
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
