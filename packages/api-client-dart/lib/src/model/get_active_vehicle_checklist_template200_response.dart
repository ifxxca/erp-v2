//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/checklist_template.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'get_active_vehicle_checklist_template200_response.g.dart';

/// GetActiveVehicleChecklistTemplate200Response
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class GetActiveVehicleChecklistTemplate200Response implements Built<GetActiveVehicleChecklistTemplate200Response, GetActiveVehicleChecklistTemplate200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ChecklistTemplate? get data;

  GetActiveVehicleChecklistTemplate200Response._();

  factory GetActiveVehicleChecklistTemplate200Response([void updates(GetActiveVehicleChecklistTemplate200ResponseBuilder b)]) = _$GetActiveVehicleChecklistTemplate200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GetActiveVehicleChecklistTemplate200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GetActiveVehicleChecklistTemplate200Response> get serializer => _$GetActiveVehicleChecklistTemplate200ResponseSerializer();
}

class _$GetActiveVehicleChecklistTemplate200ResponseSerializer implements PrimitiveSerializer<GetActiveVehicleChecklistTemplate200Response> {
  @override
  final Iterable<Type> types = const [GetActiveVehicleChecklistTemplate200Response, _$GetActiveVehicleChecklistTemplate200Response];

  @override
  final String wireName = r'GetActiveVehicleChecklistTemplate200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GetActiveVehicleChecklistTemplate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(ChecklistTemplate),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GetActiveVehicleChecklistTemplate200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GetActiveVehicleChecklistTemplate200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChecklistTemplate),
          ) as ChecklistTemplate;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GetActiveVehicleChecklistTemplate200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GetActiveVehicleChecklistTemplate200ResponseBuilder();
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
