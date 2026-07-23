// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const VehicleStatus _$available = const VehicleStatus._('available');
const VehicleStatus _$inUse = const VehicleStatus._('inUse');
const VehicleStatus _$maintenance = const VehicleStatus._('maintenance');
const VehicleStatus _$blocked = const VehicleStatus._('blocked');
const VehicleStatus _$inactive = const VehicleStatus._('inactive');
const VehicleStatus _$unknownDefaultOpenApi =
    const VehicleStatus._('unknownDefaultOpenApi');

VehicleStatus _$valueOf(String name) {
  switch (name) {
    case 'available':
      return _$available;
    case 'inUse':
      return _$inUse;
    case 'maintenance':
      return _$maintenance;
    case 'blocked':
      return _$blocked;
    case 'inactive':
      return _$inactive;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<VehicleStatus> _$values =
    BuiltSet<VehicleStatus>(const <VehicleStatus>[
  _$available,
  _$inUse,
  _$maintenance,
  _$blocked,
  _$inactive,
  _$unknownDefaultOpenApi,
]);

class _$VehicleStatusMeta {
  const _$VehicleStatusMeta();
  VehicleStatus get available => _$available;
  VehicleStatus get inUse => _$inUse;
  VehicleStatus get maintenance => _$maintenance;
  VehicleStatus get blocked => _$blocked;
  VehicleStatus get inactive => _$inactive;
  VehicleStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  VehicleStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<VehicleStatus> get values => _$values;
}

abstract class _$VehicleStatusMixin {
  // ignore: non_constant_identifier_names
  _$VehicleStatusMeta get VehicleStatus => const _$VehicleStatusMeta();
}

Serializer<VehicleStatus> _$vehicleStatusSerializer =
    _$VehicleStatusSerializer();

class _$VehicleStatusSerializer implements PrimitiveSerializer<VehicleStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'available': 'available',
    'inUse': 'in_use',
    'maintenance': 'maintenance',
    'blocked': 'blocked',
    'inactive': 'inactive',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'available': 'available',
    'in_use': 'inUse',
    'maintenance': 'maintenance',
    'blocked': 'blocked',
    'inactive': 'inactive',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[VehicleStatus];
  @override
  final String wireName = 'VehicleStatus';

  @override
  Object serialize(Serializers serializers, VehicleStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  VehicleStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      VehicleStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
