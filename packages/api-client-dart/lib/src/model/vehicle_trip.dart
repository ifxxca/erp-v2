//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/user_summary.dart';
import 'package:rajawali_api_client/src/model/checklist_submission.dart';
import 'package:rajawali_api_client/src/model/vehicle_trip_status.dart';
import 'package:rajawali_api_client/src/model/vehicle.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'vehicle_trip.g.dart';

/// VehicleTrip
///
/// Properties:
/// * [id]
/// * [status]
/// * [purpose]
/// * [destination]
/// * [startOdometer]
/// * [endOdometer]
/// * [departedAt]
/// * [arrivedAt]
/// * [cancelledAt]
/// * [completionNote]
/// * [cancelReason]
/// * [vehicle]
/// * [driver]
/// * [checklist]
@BuiltValue()
abstract class VehicleTrip implements Built<VehicleTrip, VehicleTripBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'status')
  VehicleTripStatus get status;
  // enum statusEnum {  active,  completed,  cancelled,  };

  @BuiltValueField(wireName: r'purpose')
  String get purpose;

  @BuiltValueField(wireName: r'destination')
  String? get destination;

  @BuiltValueField(wireName: r'start_odometer')
  int get startOdometer;

  @BuiltValueField(wireName: r'end_odometer')
  int? get endOdometer;

  @BuiltValueField(wireName: r'departed_at')
  DateTime get departedAt;

  @BuiltValueField(wireName: r'arrived_at')
  DateTime? get arrivedAt;

  @BuiltValueField(wireName: r'cancelled_at')
  DateTime? get cancelledAt;

  @BuiltValueField(wireName: r'completion_note')
  String? get completionNote;

  @BuiltValueField(wireName: r'cancel_reason')
  String? get cancelReason;

  @BuiltValueField(wireName: r'vehicle')
  Vehicle get vehicle;

  @BuiltValueField(wireName: r'driver')
  UserSummary get driver;

  @BuiltValueField(wireName: r'checklist')
  ChecklistSubmission? get checklist;

  VehicleTrip._();

  factory VehicleTrip([void updates(VehicleTripBuilder b)]) = _$VehicleTrip;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VehicleTripBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VehicleTrip> get serializer => _$VehicleTripSerializer();
}

class _$VehicleTripSerializer implements PrimitiveSerializer<VehicleTrip> {
  @override
  final Iterable<Type> types = const [VehicleTrip, _$VehicleTrip];

  @override
  final String wireName = r'VehicleTrip';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VehicleTrip object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(VehicleTripStatus),
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
    if (object.endOdometer != null) {
      yield r'end_odometer';
      yield serializers.serialize(
        object.endOdometer,
        specifiedType: const FullType.nullable(int),
      );
    }
    yield r'departed_at';
    yield serializers.serialize(
      object.departedAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.arrivedAt != null) {
      yield r'arrived_at';
      yield serializers.serialize(
        object.arrivedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.cancelledAt != null) {
      yield r'cancelled_at';
      yield serializers.serialize(
        object.cancelledAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.completionNote != null) {
      yield r'completion_note';
      yield serializers.serialize(
        object.completionNote,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.cancelReason != null) {
      yield r'cancel_reason';
      yield serializers.serialize(
        object.cancelReason,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'vehicle';
    yield serializers.serialize(
      object.vehicle,
      specifiedType: const FullType(Vehicle),
    );
    yield r'driver';
    yield serializers.serialize(
      object.driver,
      specifiedType: const FullType(UserSummary),
    );
    if (object.checklist != null) {
      yield r'checklist';
      yield serializers.serialize(
        object.checklist,
        specifiedType: const FullType(ChecklistSubmission),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    VehicleTrip object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VehicleTripBuilder result,
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(VehicleTripStatus),
          ) as VehicleTripStatus;
          result.status = valueDes;
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
        case r'end_odometer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.endOdometer = valueDes;
          break;
        case r'departed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.departedAt = valueDes;
          break;
        case r'arrived_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.arrivedAt = valueDes;
          break;
        case r'cancelled_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.cancelledAt = valueDes;
          break;
        case r'completion_note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.completionNote = valueDes;
          break;
        case r'cancel_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.cancelReason = valueDes;
          break;
        case r'vehicle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Vehicle),
          ) as Vehicle;
          result.vehicle.replace(valueDes);
          break;
        case r'driver':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserSummary),
          ) as UserSummary;
          result.driver = valueDes;
          break;
        case r'checklist':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChecklistSubmission),
          ) as ChecklistSubmission;
          result.checklist.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  VehicleTrip deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VehicleTripBuilder();
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
