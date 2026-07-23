//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/vehicle_type.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_vehicle_types200_response.g.dart';

/// ListVehicleTypes200Response
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class ListVehicleTypes200Response implements Built<ListVehicleTypes200Response, ListVehicleTypes200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<VehicleType> get data;

  ListVehicleTypes200Response._();

  factory ListVehicleTypes200Response([void updates(ListVehicleTypes200ResponseBuilder b)]) = _$ListVehicleTypes200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListVehicleTypes200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListVehicleTypes200Response> get serializer => _$ListVehicleTypes200ResponseSerializer();
}

class _$ListVehicleTypes200ResponseSerializer implements PrimitiveSerializer<ListVehicleTypes200Response> {
  @override
  final Iterable<Type> types = const [ListVehicleTypes200Response, _$ListVehicleTypes200Response];

  @override
  final String wireName = r'ListVehicleTypes200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListVehicleTypes200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(VehicleType)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ListVehicleTypes200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListVehicleTypes200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(VehicleType)]),
          ) as BuiltList<VehicleType>;
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
  ListVehicleTypes200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListVehicleTypes200ResponseBuilder();
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
