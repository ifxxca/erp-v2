//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/vehicle_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'change_vehicle_status_request.g.dart';

/// ChangeVehicleStatusRequest
///
/// Properties:
/// * [status]
/// * [reason]
@BuiltValue()
abstract class ChangeVehicleStatusRequest implements Built<ChangeVehicleStatusRequest, ChangeVehicleStatusRequestBuilder> {
  @BuiltValueField(wireName: r'status')
  VehicleStatus get status;
  // enum statusEnum {  available,  in_use,  maintenance,  blocked,  inactive,  };

  @BuiltValueField(wireName: r'reason')
  String get reason;

  ChangeVehicleStatusRequest._();

  factory ChangeVehicleStatusRequest([void updates(ChangeVehicleStatusRequestBuilder b)]) = _$ChangeVehicleStatusRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChangeVehicleStatusRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChangeVehicleStatusRequest> get serializer => _$ChangeVehicleStatusRequestSerializer();
}

class _$ChangeVehicleStatusRequestSerializer implements PrimitiveSerializer<ChangeVehicleStatusRequest> {
  @override
  final Iterable<Type> types = const [ChangeVehicleStatusRequest, _$ChangeVehicleStatusRequest];

  @override
  final String wireName = r'ChangeVehicleStatusRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChangeVehicleStatusRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(VehicleStatus),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChangeVehicleStatusRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChangeVehicleStatusRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(VehicleStatus),
          ) as VehicleStatus;
          result.status = valueDes;
          break;
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
  ChangeVehicleStatusRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChangeVehicleStatusRequestBuilder();
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
