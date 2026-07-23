//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/checklist_answer_input.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checkout_vehicle_request.g.dart';

/// CheckoutVehicleRequest
///
/// Properties:
/// * [vehicleId]
/// * [purpose]
/// * [destination]
/// * [startOdometer]
/// * [departedAt]
/// * [answers]
@BuiltValue()
abstract class CheckoutVehicleRequest implements Built<CheckoutVehicleRequest, CheckoutVehicleRequestBuilder> {
  @BuiltValueField(wireName: r'vehicle_id')
  String get vehicleId;

  @BuiltValueField(wireName: r'purpose')
  String get purpose;

  @BuiltValueField(wireName: r'destination')
  String? get destination;

  @BuiltValueField(wireName: r'start_odometer')
  int get startOdometer;

  @BuiltValueField(wireName: r'departed_at')
  DateTime? get departedAt;

  @BuiltValueField(wireName: r'answers')
  BuiltList<ChecklistAnswerInput> get answers;

  CheckoutVehicleRequest._();

  factory CheckoutVehicleRequest([void updates(CheckoutVehicleRequestBuilder b)]) = _$CheckoutVehicleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CheckoutVehicleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CheckoutVehicleRequest> get serializer => _$CheckoutVehicleRequestSerializer();
}

class _$CheckoutVehicleRequestSerializer implements PrimitiveSerializer<CheckoutVehicleRequest> {
  @override
  final Iterable<Type> types = const [CheckoutVehicleRequest, _$CheckoutVehicleRequest];

  @override
  final String wireName = r'CheckoutVehicleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CheckoutVehicleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'vehicle_id';
    yield serializers.serialize(
      object.vehicleId,
      specifiedType: const FullType(String),
    );
    yield r'purpose';
    yield serializers.serialize(
      object.purpose,
      specifiedType: const FullType(String),
    );
    if (object.destination != null) {
      yield r'destination';
      yield serializers.serialize(
        object.destination,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'start_odometer';
    yield serializers.serialize(
      object.startOdometer,
      specifiedType: const FullType(int),
    );
    if (object.departedAt != null) {
      yield r'departed_at';
      yield serializers.serialize(
        object.departedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'answers';
    yield serializers.serialize(
      object.answers,
      specifiedType: const FullType(BuiltList, [FullType(ChecklistAnswerInput)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CheckoutVehicleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CheckoutVehicleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'vehicle_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.vehicleId = valueDes;
          break;
        case r'purpose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.purpose = valueDes;
          break;
        case r'destination':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.destination = valueDes;
          break;
        case r'start_odometer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.startOdometer = valueDes;
          break;
        case r'departed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.departedAt = valueDes;
          break;
        case r'answers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ChecklistAnswerInput)]),
          ) as BuiltList<ChecklistAnswerInput>;
          result.answers.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CheckoutVehicleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CheckoutVehicleRequestBuilder();
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
