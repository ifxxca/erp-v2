//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'vehicle_trip_status.g.dart';

class VehicleTripStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'active')
  static const VehicleTripStatus active = _$active;
  @BuiltValueEnumConst(wireName: r'completed')
  static const VehicleTripStatus completed = _$completed;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const VehicleTripStatus cancelled = _$cancelled;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const VehicleTripStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<VehicleTripStatus> get serializer => _$vehicleTripStatusSerializer;

  const VehicleTripStatus._(String name): super(name);

  static BuiltSet<VehicleTripStatus> get values => _$values;
  static VehicleTripStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class VehicleTripStatusMixin = Object with _$VehicleTripStatusMixin;
