// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WorkOrderStatus _$draft = const WorkOrderStatus._('draft');
const WorkOrderStatus _$scheduled = const WorkOrderStatus._('scheduled');
const WorkOrderStatus _$inProgress = const WorkOrderStatus._('inProgress');
const WorkOrderStatus _$completed = const WorkOrderStatus._('completed');
const WorkOrderStatus _$cancelled = const WorkOrderStatus._('cancelled');
const WorkOrderStatus _$unknownDefaultOpenApi =
    const WorkOrderStatus._('unknownDefaultOpenApi');

WorkOrderStatus _$valueOf(String name) {
  switch (name) {
    case 'draft':
      return _$draft;
    case 'scheduled':
      return _$scheduled;
    case 'inProgress':
      return _$inProgress;
    case 'completed':
      return _$completed;
    case 'cancelled':
      return _$cancelled;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<WorkOrderStatus> _$values =
    BuiltSet<WorkOrderStatus>(const <WorkOrderStatus>[
  _$draft,
  _$scheduled,
  _$inProgress,
  _$completed,
  _$cancelled,
  _$unknownDefaultOpenApi,
]);

class _$WorkOrderStatusMeta {
  const _$WorkOrderStatusMeta();
  WorkOrderStatus get draft => _$draft;
  WorkOrderStatus get scheduled => _$scheduled;
  WorkOrderStatus get inProgress => _$inProgress;
  WorkOrderStatus get completed => _$completed;
  WorkOrderStatus get cancelled => _$cancelled;
  WorkOrderStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  WorkOrderStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<WorkOrderStatus> get values => _$values;
}

abstract class _$WorkOrderStatusMixin {
  // ignore: non_constant_identifier_names
  _$WorkOrderStatusMeta get WorkOrderStatus => const _$WorkOrderStatusMeta();
}

Serializer<WorkOrderStatus> _$workOrderStatusSerializer =
    _$WorkOrderStatusSerializer();

class _$WorkOrderStatusSerializer
    implements PrimitiveSerializer<WorkOrderStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'draft': 'draft',
    'scheduled': 'scheduled',
    'inProgress': 'in_progress',
    'completed': 'completed',
    'cancelled': 'cancelled',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'draft': 'draft',
    'scheduled': 'scheduled',
    'in_progress': 'inProgress',
    'completed': 'completed',
    'cancelled': 'cancelled',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WorkOrderStatus];
  @override
  final String wireName = 'WorkOrderStatus';

  @override
  Object serialize(Serializers serializers, WorkOrderStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WorkOrderStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WorkOrderStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
