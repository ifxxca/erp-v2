//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/date.dart';
import 'package:rajawali_api_client/src/model/create_work_order_request_jobs_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_work_order_request.g.dart';

/// CreateWorkOrderRequest
///
/// Properties:
/// * [vehicleId]
/// * [workOrderDate]
/// * [priority]
/// * [problemDescription]
/// * [partsCost]
/// * [jobs]
@BuiltValue()
abstract class CreateWorkOrderRequest implements Built<CreateWorkOrderRequest, CreateWorkOrderRequestBuilder> {
  @BuiltValueField(wireName: r'vehicle_id')
  String get vehicleId;

  @BuiltValueField(wireName: r'work_order_date')
  Date get workOrderDate;

  @BuiltValueField(wireName: r'priority')
  CreateWorkOrderRequestPriorityEnum get priority;
  // enum priorityEnum {  low,  normal,  high,  urgent,  };

  @BuiltValueField(wireName: r'problem_description')
  String get problemDescription;

  @BuiltValueField(wireName: r'parts_cost')
  num? get partsCost;

  @BuiltValueField(wireName: r'jobs')
  BuiltList<CreateWorkOrderRequestJobsInner> get jobs;

  CreateWorkOrderRequest._();

  factory CreateWorkOrderRequest([void updates(CreateWorkOrderRequestBuilder b)]) = _$CreateWorkOrderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateWorkOrderRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateWorkOrderRequest> get serializer => _$CreateWorkOrderRequestSerializer();
}

class _$CreateWorkOrderRequestSerializer implements PrimitiveSerializer<CreateWorkOrderRequest> {
  @override
  final Iterable<Type> types = const [CreateWorkOrderRequest, _$CreateWorkOrderRequest];

  @override
  final String wireName = r'CreateWorkOrderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateWorkOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'vehicle_id';
    yield serializers.serialize(
      object.vehicleId,
      specifiedType: const FullType(String),
    );
    yield r'work_order_date';
    yield serializers.serialize(
      object.workOrderDate,
      specifiedType: const FullType(Date),
    );
    yield r'priority';
    yield serializers.serialize(
      object.priority,
      specifiedType: const FullType(CreateWorkOrderRequestPriorityEnum),
    );
    yield r'problem_description';
    yield serializers.serialize(
      object.problemDescription,
      specifiedType: const FullType(String),
    );
    if (object.partsCost != null) {
      yield r'parts_cost';
      yield serializers.serialize(
        object.partsCost,
        specifiedType: const FullType(num),
      );
    }
    yield r'jobs';
    yield serializers.serialize(
      object.jobs,
      specifiedType: const FullType(BuiltList, [FullType(CreateWorkOrderRequestJobsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateWorkOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateWorkOrderRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'vehicle_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.vehicleId = valueDes;
          break;
        case r'work_order_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.workOrderDate = valueDes;
          break;
        case r'priority':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateWorkOrderRequestPriorityEnum),
          ) as CreateWorkOrderRequestPriorityEnum;
          result.priority = valueDes;
          break;
        case r'problem_description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.problemDescription = valueDes;
          break;
        case r'parts_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.partsCost = valueDes;
          break;
        case r'jobs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(CreateWorkOrderRequestJobsInner)]),
          ) as BuiltList<CreateWorkOrderRequestJobsInner>;
          result.jobs.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateWorkOrderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateWorkOrderRequestBuilder();
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

class CreateWorkOrderRequestPriorityEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'low')
  static const CreateWorkOrderRequestPriorityEnum low = _$createWorkOrderRequestPriorityEnum_low;
  @BuiltValueEnumConst(wireName: r'normal')
  static const CreateWorkOrderRequestPriorityEnum normal = _$createWorkOrderRequestPriorityEnum_normal;
  @BuiltValueEnumConst(wireName: r'high')
  static const CreateWorkOrderRequestPriorityEnum high = _$createWorkOrderRequestPriorityEnum_high;
  @BuiltValueEnumConst(wireName: r'urgent')
  static const CreateWorkOrderRequestPriorityEnum urgent = _$createWorkOrderRequestPriorityEnum_urgent;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateWorkOrderRequestPriorityEnum unknownDefaultOpenApi = _$createWorkOrderRequestPriorityEnum_unknownDefaultOpenApi;

  static Serializer<CreateWorkOrderRequestPriorityEnum> get serializer => _$createWorkOrderRequestPriorityEnumSerializer;

  const CreateWorkOrderRequestPriorityEnum._(String name): super(name);

  static BuiltSet<CreateWorkOrderRequestPriorityEnum> get values => _$createWorkOrderRequestPriorityEnumValues;
  static CreateWorkOrderRequestPriorityEnum valueOf(String name) => _$createWorkOrderRequestPriorityEnumValueOf(name);
}
