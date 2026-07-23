//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'work_order_status.g.dart';

class WorkOrderStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'draft')
  static const WorkOrderStatus draft = _$draft;
  @BuiltValueEnumConst(wireName: r'scheduled')
  static const WorkOrderStatus scheduled = _$scheduled;
  @BuiltValueEnumConst(wireName: r'in_progress')
  static const WorkOrderStatus inProgress = _$inProgress;
  @BuiltValueEnumConst(wireName: r'completed')
  static const WorkOrderStatus completed = _$completed;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const WorkOrderStatus cancelled = _$cancelled;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WorkOrderStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<WorkOrderStatus> get serializer => _$workOrderStatusSerializer;

  const WorkOrderStatus._(String name): super(name);

  static BuiltSet<WorkOrderStatus> get values => _$values;
  static WorkOrderStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class WorkOrderStatusMixin = Object with _$WorkOrderStatusMixin;
