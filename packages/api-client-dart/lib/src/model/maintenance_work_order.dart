//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/date.dart';
import 'package:rajawali_api_client/src/model/work_order_job.dart';
import 'package:rajawali_api_client/src/model/work_order_status.dart';
import 'package:rajawali_api_client/src/model/vehicle.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'maintenance_work_order.g.dart';

/// MaintenanceWorkOrder
///
/// Properties:
/// * [id]
/// * [documentNumber]
/// * [workOrderDate]
/// * [priority]
/// * [status]
/// * [problemDescription]
/// * [completionNote]
/// * [laborCost]
/// * [partsCost]
/// * [totalCost]
/// * [vehicle]
/// * [jobs]
@BuiltValue()
abstract class MaintenanceWorkOrder implements Built<MaintenanceWorkOrder, MaintenanceWorkOrderBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'document_number')
  String? get documentNumber;

  @BuiltValueField(wireName: r'work_order_date')
  Date get workOrderDate;

  @BuiltValueField(wireName: r'priority')
  MaintenanceWorkOrderPriorityEnum get priority;
  // enum priorityEnum {  low,  normal,  high,  urgent,  };

  @BuiltValueField(wireName: r'status')
  WorkOrderStatus get status;
  // enum statusEnum {  draft,  scheduled,  in_progress,  completed,  cancelled,  };

  @BuiltValueField(wireName: r'problem_description')
  String get problemDescription;

  @BuiltValueField(wireName: r'completion_note')
  String? get completionNote;

  @BuiltValueField(wireName: r'labor_cost')
  String? get laborCost;

  @BuiltValueField(wireName: r'parts_cost')
  String? get partsCost;

  @BuiltValueField(wireName: r'total_cost')
  String get totalCost;

  @BuiltValueField(wireName: r'vehicle')
  Vehicle get vehicle;

  @BuiltValueField(wireName: r'jobs')
  BuiltList<WorkOrderJob> get jobs;

  MaintenanceWorkOrder._();

  factory MaintenanceWorkOrder([void updates(MaintenanceWorkOrderBuilder b)]) = _$MaintenanceWorkOrder;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MaintenanceWorkOrderBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MaintenanceWorkOrder> get serializer => _$MaintenanceWorkOrderSerializer();
}

class _$MaintenanceWorkOrderSerializer implements PrimitiveSerializer<MaintenanceWorkOrder> {
  @override
  final Iterable<Type> types = const [MaintenanceWorkOrder, _$MaintenanceWorkOrder];

  @override
  final String wireName = r'MaintenanceWorkOrder';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MaintenanceWorkOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    if (object.documentNumber != null) {
      yield r'document_number';
      yield serializers.serialize(
        object.documentNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'work_order_date';
    yield serializers.serialize(
      object.workOrderDate,
      specifiedType: const FullType(Date),
    );
    yield r'priority';
    yield serializers.serialize(
      object.priority,
      specifiedType: const FullType(MaintenanceWorkOrderPriorityEnum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(WorkOrderStatus),
    );
    yield r'problem_description';
    yield serializers.serialize(
      object.problemDescription,
      specifiedType: const FullType(String),
    );
    if (object.completionNote != null) {
      yield r'completion_note';
      yield serializers.serialize(
        object.completionNote,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.laborCost != null) {
      yield r'labor_cost';
      yield serializers.serialize(
        object.laborCost,
        specifiedType: const FullType(String),
      );
    }
    if (object.partsCost != null) {
      yield r'parts_cost';
      yield serializers.serialize(
        object.partsCost,
        specifiedType: const FullType(String),
      );
    }
    yield r'total_cost';
    yield serializers.serialize(
      object.totalCost,
      specifiedType: const FullType(String),
    );
    yield r'vehicle';
    yield serializers.serialize(
      object.vehicle,
      specifiedType: const FullType(Vehicle),
    );
    yield r'jobs';
    yield serializers.serialize(
      object.jobs,
      specifiedType: const FullType(BuiltList, [FullType(WorkOrderJob)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MaintenanceWorkOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MaintenanceWorkOrderBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'document_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.documentNumber = valueDes;
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
            specifiedType: const FullType(MaintenanceWorkOrderPriorityEnum),
          ) as MaintenanceWorkOrderPriorityEnum;
          result.priority = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WorkOrderStatus),
          ) as WorkOrderStatus;
          result.status = valueDes;
          break;
        case r'problem_description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.problemDescription = valueDes;
          break;
        case r'completion_note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.completionNote = valueDes;
          break;
        case r'labor_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.laborCost = valueDes;
          break;
        case r'parts_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.partsCost = valueDes;
          break;
        case r'total_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalCost = valueDes;
          break;
        case r'vehicle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Vehicle),
          ) as Vehicle;
          result.vehicle.replace(valueDes);
          break;
        case r'jobs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(WorkOrderJob)]),
          ) as BuiltList<WorkOrderJob>;
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
  MaintenanceWorkOrder deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MaintenanceWorkOrderBuilder();
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

class MaintenanceWorkOrderPriorityEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'low')
  static const MaintenanceWorkOrderPriorityEnum low = _$maintenanceWorkOrderPriorityEnum_low;
  @BuiltValueEnumConst(wireName: r'normal')
  static const MaintenanceWorkOrderPriorityEnum normal = _$maintenanceWorkOrderPriorityEnum_normal;
  @BuiltValueEnumConst(wireName: r'high')
  static const MaintenanceWorkOrderPriorityEnum high = _$maintenanceWorkOrderPriorityEnum_high;
  @BuiltValueEnumConst(wireName: r'urgent')
  static const MaintenanceWorkOrderPriorityEnum urgent = _$maintenanceWorkOrderPriorityEnum_urgent;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MaintenanceWorkOrderPriorityEnum unknownDefaultOpenApi = _$maintenanceWorkOrderPriorityEnum_unknownDefaultOpenApi;

  static Serializer<MaintenanceWorkOrderPriorityEnum> get serializer => _$maintenanceWorkOrderPriorityEnumSerializer;

  const MaintenanceWorkOrderPriorityEnum._(String name): super(name);

  static BuiltSet<MaintenanceWorkOrderPriorityEnum> get values => _$maintenanceWorkOrderPriorityEnumValues;
  static MaintenanceWorkOrderPriorityEnum valueOf(String name) => _$maintenanceWorkOrderPriorityEnumValueOf(name);
}
