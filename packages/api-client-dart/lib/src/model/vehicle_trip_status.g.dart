// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_trip_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const VehicleTripStatus _$active = const VehicleTripStatus._('active');
const VehicleTripStatus _$completed = const VehicleTripStatus._('completed');
const VehicleTripStatus _$cancelled = const VehicleTripStatus._('cancelled');
const VehicleTripStatus _$unknownDefaultOpenApi =
    const VehicleTripStatus._('unknownDefaultOpenApi');

VehicleTripStatus _$valueOf(String name) {
  switch (name) {
    case 'active':
      return _$active;
    case 'completed':
      return _$completed;
    case 'cancelled':
      return _$cancelled;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<VehicleTripStatus> _$values =
    BuiltSet<VehicleTripStatus>(const <VehicleTripStatus>[
  _$active,
  _$completed,
  _$cancelled,
  _$unknownDefaultOpenApi,
]);

class _$VehicleTripStatusMeta {
  const _$VehicleTripStatusMeta();
  VehicleTripStatus get active => _$active;
  VehicleTripStatus get completed => _$completed;
  VehicleTripStatus get cancelled => _$cancelled;
  VehicleTripStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  VehicleTripStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<VehicleTripStatus> get values => _$values;
}

abstract class _$VehicleTripStatusMixin {
  // ignore: non_constant_identifier_names
  _$VehicleTripStatusMeta get VehicleTripStatus =>
      const _$VehicleTripStatusMeta();
}

Serializer<VehicleTripStatus> _$vehicleTripStatusSerializer =
    _$VehicleTripStatusSerializer();

class _$VehicleTripStatusSerializer
    implements PrimitiveSerializer<VehicleTripStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'active': 'active',
    'completed': 'completed',
    'cancelled': 'cancelled',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'active': 'active',
    'completed': 'completed',
    'cancelled': 'cancelled',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[VehicleTripStatus];
  @override
  final String wireName = 'VehicleTripStatus';

  @override
  Object serialize(Serializers serializers, VehicleTripStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  VehicleTripStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      VehicleTripStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
