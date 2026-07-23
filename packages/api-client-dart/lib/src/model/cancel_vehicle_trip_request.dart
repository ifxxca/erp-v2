//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'cancel_vehicle_trip_request.g.dart';

/// CancelVehicleTripRequest
///
/// Properties:
/// * [reason]
@BuiltValue()
abstract class CancelVehicleTripRequest implements Built<CancelVehicleTripRequest, CancelVehicleTripRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  String get reason;

  CancelVehicleTripRequest._();

  factory CancelVehicleTripRequest([void updates(CancelVehicleTripRequestBuilder b)]) = _$CancelVehicleTripRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CancelVehicleTripRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CancelVehicleTripRequest> get serializer => _$CancelVehicleTripRequestSerializer();
}

class _$CancelVehicleTripRequestSerializer implements PrimitiveSerializer<CancelVehicleTripRequest> {
  @override
  final Iterable<Type> types = const [CancelVehicleTripRequest, _$CancelVehicleTripRequest];

  @override
  final String wireName = r'CancelVehicleTripRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CancelVehicleTripRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CancelVehicleTripRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CancelVehicleTripRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  CancelVehicleTripRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CancelVehicleTripRequestBuilder();
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
