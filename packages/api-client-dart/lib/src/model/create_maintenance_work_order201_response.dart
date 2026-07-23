//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/maintenance_work_order.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_maintenance_work_order201_response.g.dart';

/// CreateMaintenanceWorkOrder201Response
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class CreateMaintenanceWorkOrder201Response implements Built<CreateMaintenanceWorkOrder201Response, CreateMaintenanceWorkOrder201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  MaintenanceWorkOrder? get data;

  CreateMaintenanceWorkOrder201Response._();

  factory CreateMaintenanceWorkOrder201Response([void updates(CreateMaintenanceWorkOrder201ResponseBuilder b)]) = _$CreateMaintenanceWorkOrder201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateMaintenanceWorkOrder201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateMaintenanceWorkOrder201Response> get serializer => _$CreateMaintenanceWorkOrder201ResponseSerializer();
}

class _$CreateMaintenanceWorkOrder201ResponseSerializer implements PrimitiveSerializer<CreateMaintenanceWorkOrder201Response> {
  @override
  final Iterable<Type> types = const [CreateMaintenanceWorkOrder201Response, _$CreateMaintenanceWorkOrder201Response];

  @override
  final String wireName = r'CreateMaintenanceWorkOrder201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateMaintenanceWorkOrder201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(MaintenanceWorkOrder),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateMaintenanceWorkOrder201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateMaintenanceWorkOrder201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MaintenanceWorkOrder),
          ) as MaintenanceWorkOrder;
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
  CreateMaintenanceWorkOrder201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateMaintenanceWorkOrder201ResponseBuilder();
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
