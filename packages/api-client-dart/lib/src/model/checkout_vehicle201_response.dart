//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/vehicle_trip.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checkout_vehicle201_response.g.dart';

/// CheckoutVehicle201Response
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class CheckoutVehicle201Response implements Built<CheckoutVehicle201Response, CheckoutVehicle201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  VehicleTrip? get data;

  CheckoutVehicle201Response._();

  factory CheckoutVehicle201Response([void updates(CheckoutVehicle201ResponseBuilder b)]) = _$CheckoutVehicle201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CheckoutVehicle201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CheckoutVehicle201Response> get serializer => _$CheckoutVehicle201ResponseSerializer();
}

class _$CheckoutVehicle201ResponseSerializer implements PrimitiveSerializer<CheckoutVehicle201Response> {
  @override
  final Iterable<Type> types = const [CheckoutVehicle201Response, _$CheckoutVehicle201Response];

  @override
  final String wireName = r'CheckoutVehicle201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CheckoutVehicle201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(VehicleTrip),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CheckoutVehicle201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CheckoutVehicle201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(VehicleTrip),
          ) as VehicleTrip;
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
  CheckoutVehicle201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CheckoutVehicle201ResponseBuilder();
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
