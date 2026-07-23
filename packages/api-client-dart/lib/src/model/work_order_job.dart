//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'work_order_job.g.dart';

/// WorkOrderJob
///
/// Properties:
/// * [id]
/// * [lineNumber]
/// * [description]
/// * [status]
/// * [laborCost]
/// * [note]
@BuiltValue()
abstract class WorkOrderJob implements Built<WorkOrderJob, WorkOrderJobBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'line_number')
  int get lineNumber;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'status')
  WorkOrderJobStatusEnum get status;
  // enum statusEnum {  pending,  in_progress,  completed,  cancelled,  };

  @BuiltValueField(wireName: r'labor_cost')
  String get laborCost;

  @BuiltValueField(wireName: r'note')
  String? get note;

  WorkOrderJob._();

  factory WorkOrderJob([void updates(WorkOrderJobBuilder b)]) = _$WorkOrderJob;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkOrderJobBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkOrderJob> get serializer => _$WorkOrderJobSerializer();
}

class _$WorkOrderJobSerializer implements PrimitiveSerializer<WorkOrderJob> {
  @override
  final Iterable<Type> types = const [WorkOrderJob, _$WorkOrderJob];

  @override
  final String wireName = r'WorkOrderJob';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkOrderJob object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'line_number';
    yield serializers.serialize(
      object.lineNumber,
      specifiedType: const FullType(int),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(WorkOrderJobStatusEnum),
    );
    yield r'labor_cost';
    yield serializers.serialize(
      object.laborCost,
      specifiedType: const FullType(String),
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
    WorkOrderJob object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WorkOrderJobBuilder result,
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
        case r'line_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lineNumber = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WorkOrderJobStatusEnum),
          ) as WorkOrderJobStatusEnum;
          result.status = valueDes;
          break;
        case r'labor_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.laborCost = valueDes;
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
  WorkOrderJob deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkOrderJobBuilder();
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

class WorkOrderJobStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const WorkOrderJobStatusEnum pending = _$workOrderJobStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'in_progress')
  static const WorkOrderJobStatusEnum inProgress = _$workOrderJobStatusEnum_inProgress;
  @BuiltValueEnumConst(wireName: r'completed')
  static const WorkOrderJobStatusEnum completed = _$workOrderJobStatusEnum_completed;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const WorkOrderJobStatusEnum cancelled = _$workOrderJobStatusEnum_cancelled;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WorkOrderJobStatusEnum unknownDefaultOpenApi = _$workOrderJobStatusEnum_unknownDefaultOpenApi;

  static Serializer<WorkOrderJobStatusEnum> get serializer => _$workOrderJobStatusEnumSerializer;

  const WorkOrderJobStatusEnum._(String name): super(name);

  static BuiltSet<WorkOrderJobStatusEnum> get values => _$workOrderJobStatusEnumValues;
  static WorkOrderJobStatusEnum valueOf(String name) => _$workOrderJobStatusEnumValueOf(name);
}
