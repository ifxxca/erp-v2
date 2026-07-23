//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'operations_capabilities.g.dart';

/// OperationsCapabilities
///
/// Properties:
/// * [canViewVehicles]
/// * [canManageVehicles]
/// * [canViewWorkOrders]
/// * [canManageWorkOrders]
/// * [canViewTrips]
/// * [canOperateTrips]
/// * [canManageTrips]
@BuiltValue()
abstract class OperationsCapabilities implements Built<OperationsCapabilities, OperationsCapabilitiesBuilder> {
  @BuiltValueField(wireName: r'can_view_vehicles')
  bool get canViewVehicles;

  @BuiltValueField(wireName: r'can_manage_vehicles')
  bool get canManageVehicles;

  @BuiltValueField(wireName: r'can_view_work_orders')
  bool get canViewWorkOrders;

  @BuiltValueField(wireName: r'can_manage_work_orders')
  bool get canManageWorkOrders;

  @BuiltValueField(wireName: r'can_view_trips')
  bool get canViewTrips;

  @BuiltValueField(wireName: r'can_operate_trips')
  bool get canOperateTrips;

  @BuiltValueField(wireName: r'can_manage_trips')
  bool get canManageTrips;

  OperationsCapabilities._();

  factory OperationsCapabilities([void updates(OperationsCapabilitiesBuilder b)]) = _$OperationsCapabilities;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OperationsCapabilitiesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OperationsCapabilities> get serializer => _$OperationsCapabilitiesSerializer();
}

class _$OperationsCapabilitiesSerializer implements PrimitiveSerializer<OperationsCapabilities> {
  @override
  final Iterable<Type> types = const [OperationsCapabilities, _$OperationsCapabilities];

  @override
  final String wireName = r'OperationsCapabilities';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OperationsCapabilities object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'can_view_vehicles';
    yield serializers.serialize(
      object.canViewVehicles,
      specifiedType: const FullType(bool),
    );
    yield r'can_manage_vehicles';
    yield serializers.serialize(
      object.canManageVehicles,
      specifiedType: const FullType(bool),
    );
    yield r'can_view_work_orders';
    yield serializers.serialize(
      object.canViewWorkOrders,
      specifiedType: const FullType(bool),
    );
    yield r'can_manage_work_orders';
    yield serializers.serialize(
      object.canManageWorkOrders,
      specifiedType: const FullType(bool),
    );
    yield r'can_view_trips';
    yield serializers.serialize(
      object.canViewTrips,
      specifiedType: const FullType(bool),
    );
    yield r'can_operate_trips';
    yield serializers.serialize(
      object.canOperateTrips,
      specifiedType: const FullType(bool),
    );
    yield r'can_manage_trips';
    yield serializers.serialize(
      object.canManageTrips,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OperationsCapabilities object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OperationsCapabilitiesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'can_view_vehicles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canViewVehicles = valueDes;
          break;
        case r'can_manage_vehicles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canManageVehicles = valueDes;
          break;
        case r'can_view_work_orders':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canViewWorkOrders = valueDes;
          break;
        case r'can_manage_work_orders':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canManageWorkOrders = valueDes;
          break;
        case r'can_view_trips':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canViewTrips = valueDes;
          break;
        case r'can_operate_trips':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canOperateTrips = valueDes;
          break;
        case r'can_manage_trips':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canManageTrips = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OperationsCapabilities deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OperationsCapabilitiesBuilder();
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
