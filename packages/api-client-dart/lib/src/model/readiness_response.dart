//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/readiness_response_checks_value.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'readiness_response.g.dart';

/// ReadinessResponse
///
/// Properties:
/// * [status]
/// * [checks]
/// * [checkedAt]
@BuiltValue()
abstract class ReadinessResponse implements Built<ReadinessResponse, ReadinessResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  ReadinessResponseStatusEnum get status;
  // enum statusEnum {  ready,  unavailable,  };

  @BuiltValueField(wireName: r'checks')
  BuiltMap<String, ReadinessResponseChecksValue> get checks;

  @BuiltValueField(wireName: r'checked_at')
  DateTime get checkedAt;

  ReadinessResponse._();

  factory ReadinessResponse([void updates(ReadinessResponseBuilder b)]) = _$ReadinessResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReadinessResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReadinessResponse> get serializer => _$ReadinessResponseSerializer();
}

class _$ReadinessResponseSerializer implements PrimitiveSerializer<ReadinessResponse> {
  @override
  final Iterable<Type> types = const [ReadinessResponse, _$ReadinessResponse];

  @override
  final String wireName = r'ReadinessResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReadinessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(ReadinessResponseStatusEnum),
    );
    yield r'checks';
    yield serializers.serialize(
      object.checks,
      specifiedType: const FullType(BuiltMap, [FullType(String), FullType(ReadinessResponseChecksValue)]),
    );
    yield r'checked_at';
    yield serializers.serialize(
      object.checkedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReadinessResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReadinessResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ReadinessResponseStatusEnum),
          ) as ReadinessResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'checks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType(ReadinessResponseChecksValue)]),
          ) as BuiltMap<String, ReadinessResponseChecksValue>;
          result.checks.replace(valueDes);
          break;
        case r'checked_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.checkedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReadinessResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReadinessResponseBuilder();
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

class ReadinessResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ready')
  static const ReadinessResponseStatusEnum ready = _$readinessResponseStatusEnum_ready;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const ReadinessResponseStatusEnum unavailable = _$readinessResponseStatusEnum_unavailable;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ReadinessResponseStatusEnum unknownDefaultOpenApi = _$readinessResponseStatusEnum_unknownDefaultOpenApi;

  static Serializer<ReadinessResponseStatusEnum> get serializer => _$readinessResponseStatusEnumSerializer;

  const ReadinessResponseStatusEnum._(String name): super(name);

  static BuiltSet<ReadinessResponseStatusEnum> get values => _$readinessResponseStatusEnumValues;
  static ReadinessResponseStatusEnum valueOf(String name) => _$readinessResponseStatusEnumValueOf(name);
}
