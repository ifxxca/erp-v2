//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'check_in_vehicle_request.g.dart';

/// CheckInVehicleRequest
///
/// Properties:
/// * [endOdometer]
/// * [arrivedAt]
/// * [note]
@BuiltValue()
abstract class CheckInVehicleRequest implements Built<CheckInVehicleRequest, CheckInVehicleRequestBuilder> {
  @BuiltValueField(wireName: r'end_odometer')
  int get endOdometer;

  @BuiltValueField(wireName: r'arrived_at')
  DateTime? get arrivedAt;

  @BuiltValueField(wireName: r'note')
  String? get note;

  CheckInVehicleRequest._();

  factory CheckInVehicleRequest([void updates(CheckInVehicleRequestBuilder b)]) = _$CheckInVehicleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CheckInVehicleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CheckInVehicleRequest> get serializer => _$CheckInVehicleRequestSerializer();
}

class _$CheckInVehicleRequestSerializer implements PrimitiveSerializer<CheckInVehicleRequest> {
  @override
  final Iterable<Type> types = const [CheckInVehicleRequest, _$CheckInVehicleRequest];

  @override
  final String wireName = r'CheckInVehicleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CheckInVehicleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'end_odometer';
    yield serializers.serialize(
      object.endOdometer,
      specifiedType: const FullType(int),
    );
    if (object.arrivedAt != null) {
      yield r'arrived_at';
      yield serializers.serialize(
        object.arrivedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CheckInVehicleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CheckInVehicleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'end_odometer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.endOdometer = valueDes;
          break;
        case r'arrived_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.arrivedAt = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CheckInVehicleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CheckInVehicleRequestBuilder();
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
