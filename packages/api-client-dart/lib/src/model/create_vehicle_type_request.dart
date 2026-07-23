//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_vehicle_type_request.g.dart';

/// CreateVehicleTypeRequest
///
/// Properties:
/// * [code]
/// * [name]
@BuiltValue()
abstract class CreateVehicleTypeRequest implements Built<CreateVehicleTypeRequest, CreateVehicleTypeRequestBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'name')
  String get name;

  CreateVehicleTypeRequest._();

  factory CreateVehicleTypeRequest([void updates(CreateVehicleTypeRequestBuilder b)]) = _$CreateVehicleTypeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateVehicleTypeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateVehicleTypeRequest> get serializer => _$CreateVehicleTypeRequestSerializer();
}

class _$CreateVehicleTypeRequestSerializer implements PrimitiveSerializer<CreateVehicleTypeRequest> {
  @override
  final Iterable<Type> types = const [CreateVehicleTypeRequest, _$CreateVehicleTypeRequest];

  @override
  final String wireName = r'CreateVehicleTypeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateVehicleTypeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateVehicleTypeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateVehicleTypeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateVehicleTypeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateVehicleTypeRequestBuilder();
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
