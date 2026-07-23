//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/vehicle_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_vehicle_type201_response.g.dart';

/// CreateVehicleType201Response
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class CreateVehicleType201Response implements Built<CreateVehicleType201Response, CreateVehicleType201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  VehicleType? get data;

  CreateVehicleType201Response._();

  factory CreateVehicleType201Response([void updates(CreateVehicleType201ResponseBuilder b)]) = _$CreateVehicleType201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateVehicleType201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateVehicleType201Response> get serializer => _$CreateVehicleType201ResponseSerializer();
}

class _$CreateVehicleType201ResponseSerializer implements PrimitiveSerializer<CreateVehicleType201Response> {
  @override
  final Iterable<Type> types = const [CreateVehicleType201Response, _$CreateVehicleType201Response];

  @override
  final String wireName = r'CreateVehicleType201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateVehicleType201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(VehicleType),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateVehicleType201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateVehicleType201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(VehicleType),
          ) as VehicleType;
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
  CreateVehicleType201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateVehicleType201ResponseBuilder();
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
