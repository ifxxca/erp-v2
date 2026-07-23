//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transition_work_order_request.g.dart';

/// TransitionWorkOrderRequest
///
/// Properties:
/// * [status]
/// * [note]
@BuiltValue()
abstract class TransitionWorkOrderRequest implements Built<TransitionWorkOrderRequest, TransitionWorkOrderRequestBuilder> {
  @BuiltValueField(wireName: r'status')
  TransitionWorkOrderRequestStatusEnum get status;
  // enum statusEnum {  scheduled,  in_progress,  completed,  cancelled,  };

  @BuiltValueField(wireName: r'note')
  String? get note;

  TransitionWorkOrderRequest._();

  factory TransitionWorkOrderRequest([void updates(TransitionWorkOrderRequestBuilder b)]) = _$TransitionWorkOrderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransitionWorkOrderRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransitionWorkOrderRequest> get serializer => _$TransitionWorkOrderRequestSerializer();
}

class _$TransitionWorkOrderRequestSerializer implements PrimitiveSerializer<TransitionWorkOrderRequest> {
  @override
  final Iterable<Type> types = const [TransitionWorkOrderRequest, _$TransitionWorkOrderRequest];

  @override
  final String wireName = r'TransitionWorkOrderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransitionWorkOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(TransitionWorkOrderRequestStatusEnum),
    );
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TransitionWorkOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransitionWorkOrderRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransitionWorkOrderRequestStatusEnum),
          ) as TransitionWorkOrderRequestStatusEnum;
          result.status = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransitionWorkOrderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransitionWorkOrderRequestBuilder();
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

class TransitionWorkOrderRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'scheduled')
  static const TransitionWorkOrderRequestStatusEnum scheduled = _$transitionWorkOrderRequestStatusEnum_scheduled;
  @BuiltValueEnumConst(wireName: r'in_progress')
  static const TransitionWorkOrderRequestStatusEnum inProgress = _$transitionWorkOrderRequestStatusEnum_inProgress;
  @BuiltValueEnumConst(wireName: r'completed')
  static const TransitionWorkOrderRequestStatusEnum completed = _$transitionWorkOrderRequestStatusEnum_completed;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const TransitionWorkOrderRequestStatusEnum cancelled = _$transitionWorkOrderRequestStatusEnum_cancelled;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TransitionWorkOrderRequestStatusEnum unknownDefaultOpenApi = _$transitionWorkOrderRequestStatusEnum_unknownDefaultOpenApi;

  static Serializer<TransitionWorkOrderRequestStatusEnum> get serializer => _$transitionWorkOrderRequestStatusEnumSerializer;

  const TransitionWorkOrderRequestStatusEnum._(String name): super(name);

  static BuiltSet<TransitionWorkOrderRequestStatusEnum> get values => _$transitionWorkOrderRequestStatusEnumValues;
  static TransitionWorkOrderRequestStatusEnum valueOf(String name) => _$transitionWorkOrderRequestStatusEnumValueOf(name);
}
