//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'readiness_response_checks_value.g.dart';

/// ReadinessResponseChecksValue
///
/// Properties:
/// * [status]
/// * [latencyMs]
@BuiltValue()
abstract class ReadinessResponseChecksValue implements Built<ReadinessResponseChecksValue, ReadinessResponseChecksValueBuilder> {
  @BuiltValueField(wireName: r'status')
  ReadinessResponseChecksValueStatusEnum get status;
  // enum statusEnum {  up,  down,  };

  @BuiltValueField(wireName: r'latency_ms')
  num get latencyMs;

  ReadinessResponseChecksValue._();

  factory ReadinessResponseChecksValue([void updates(ReadinessResponseChecksValueBuilder b)]) = _$ReadinessResponseChecksValue;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReadinessResponseChecksValueBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReadinessResponseChecksValue> get serializer => _$ReadinessResponseChecksValueSerializer();
}

class _$ReadinessResponseChecksValueSerializer implements PrimitiveSerializer<ReadinessResponseChecksValue> {
  @override
  final Iterable<Type> types = const [ReadinessResponseChecksValue, _$ReadinessResponseChecksValue];

  @override
  final String wireName = r'ReadinessResponseChecksValue';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReadinessResponseChecksValue object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(ReadinessResponseChecksValueStatusEnum),
    );
    yield r'latency_ms';
    yield serializers.serialize(
      object.latencyMs,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReadinessResponseChecksValue object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReadinessResponseChecksValueBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ReadinessResponseChecksValueStatusEnum),
          ) as ReadinessResponseChecksValueStatusEnum;
          result.status = valueDes;
          break;
        case r'latency_ms':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.latencyMs = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReadinessResponseChecksValue deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReadinessResponseChecksValueBuilder();
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

class ReadinessResponseChecksValueStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'up')
  static const ReadinessResponseChecksValueStatusEnum up = _$readinessResponseChecksValueStatusEnum_up;
  @BuiltValueEnumConst(wireName: r'down')
  static const ReadinessResponseChecksValueStatusEnum down = _$readinessResponseChecksValueStatusEnum_down;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ReadinessResponseChecksValueStatusEnum unknownDefaultOpenApi = _$readinessResponseChecksValueStatusEnum_unknownDefaultOpenApi;

  static Serializer<ReadinessResponseChecksValueStatusEnum> get serializer => _$readinessResponseChecksValueStatusEnumSerializer;

  const ReadinessResponseChecksValueStatusEnum._(String name): super(name);

  static BuiltSet<ReadinessResponseChecksValueStatusEnum> get values => _$readinessResponseChecksValueStatusEnumValues;
  static ReadinessResponseChecksValueStatusEnum valueOf(String name) => _$readinessResponseChecksValueStatusEnumValueOf(name);
}
