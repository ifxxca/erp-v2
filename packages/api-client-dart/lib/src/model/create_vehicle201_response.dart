//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/vehicle.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_vehicle201_response.g.dart';

/// CreateVehicle201Response
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class CreateVehicle201Response implements Built<CreateVehicle201Response, CreateVehicle201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  Vehicle? get data;

  CreateVehicle201Response._();

  factory CreateVehicle201Response([void updates(CreateVehicle201ResponseBuilder b)]) = _$CreateVehicle201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateVehicle201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateVehicle201Response> get serializer => _$CreateVehicle201ResponseSerializer();
}

class _$CreateVehicle201ResponseSerializer implements PrimitiveSerializer<CreateVehicle201Response> {
  @override
  final Iterable<Type> types = const [CreateVehicle201Response, _$CreateVehicle201Response];

  @override
  final String wireName = r'CreateVehicle201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateVehicle201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(Vehicle),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateVehicle201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateVehicle201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Vehicle),
          ) as Vehicle;
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
  CreateVehicle201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateVehicle201ResponseBuilder();
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
