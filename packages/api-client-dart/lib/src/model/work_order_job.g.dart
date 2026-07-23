// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_job.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WorkOrderJobStatusEnum _$workOrderJobStatusEnum_pending =
    const WorkOrderJobStatusEnum._('pending');
const WorkOrderJobStatusEnum _$workOrderJobStatusEnum_inProgress =
    const WorkOrderJobStatusEnum._('inProgress');
const WorkOrderJobStatusEnum _$workOrderJobStatusEnum_completed =
    const WorkOrderJobStatusEnum._('completed');
const WorkOrderJobStatusEnum _$workOrderJobStatusEnum_cancelled =
    const WorkOrderJobStatusEnum._('cancelled');
const WorkOrderJobStatusEnum _$workOrderJobStatusEnum_unknownDefaultOpenApi =
    const WorkOrderJobStatusEnum._('unknownDefaultOpenApi');

WorkOrderJobStatusEnum _$workOrderJobStatusEnumValueOf(String name) {
  switch (name) {
    case 'pending':
      return _$workOrderJobStatusEnum_pending;
    case 'inProgress':
      return _$workOrderJobStatusEnum_inProgress;
    case 'completed':
      return _$workOrderJobStatusEnum_completed;
    case 'cancelled':
      return _$workOrderJobStatusEnum_cancelled;
    case 'unknownDefaultOpenApi':
      return _$workOrderJobStatusEnum_unknownDefaultOpenApi;
    default:
      return _$workOrderJobStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<WorkOrderJobStatusEnum> _$workOrderJobStatusEnumValues =
    BuiltSet<WorkOrderJobStatusEnum>(const <WorkOrderJobStatusEnum>[
  _$workOrderJobStatusEnum_pending,
  _$workOrderJobStatusEnum_inProgress,
  _$workOrderJobStatusEnum_completed,
  _$workOrderJobStatusEnum_cancelled,
  _$workOrderJobStatusEnum_unknownDefaultOpenApi,
]);

Serializer<WorkOrderJobStatusEnum> _$workOrderJobStatusEnumSerializer =
    _$WorkOrderJobStatusEnumSerializer();

class _$WorkOrderJobStatusEnumSerializer
    implements PrimitiveSerializer<WorkOrderJobStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'inProgress': 'in_progress',
    'completed': 'completed',
    'cancelled': 'cancelled',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'in_progress': 'inProgress',
    'completed': 'completed',
    'cancelled': 'cancelled',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WorkOrderJobStatusEnum];
  @override
  final String wireName = 'WorkOrderJobStatusEnum';

  @override
  Object serialize(Serializers serializers, WorkOrderJobStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WorkOrderJobStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WorkOrderJobStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$WorkOrderJob extends WorkOrderJob {
  @override
  final String id;
  @override
  final int lineNumber;
  @override
  final String description;
  @override
  final WorkOrderJobStatusEnum status;
  @override
  final String laborCost;
  @override
  final String? note;

  factory _$WorkOrderJob([void Function(WorkOrderJobBuilder)? updates]) =>
      (WorkOrderJobBuilder()..update(updates))._build();

  _$WorkOrderJob._(
      {required this.id,
      required this.lineNumber,
      required this.description,
      required this.status,
      required this.laborCost,
      this.note})
      : super._();
  @override
  WorkOrderJob rebuild(void Function(WorkOrderJobBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkOrderJobBuilder toBuilder() => WorkOrderJobBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkOrderJob &&
        id == other.id &&
        lineNumber == other.lineNumber &&
        description == other.description &&
        status == other.status &&
        laborCost == other.laborCost &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, lineNumber.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, laborCost.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkOrderJob')
          ..add('id', id)
          ..add('lineNumber', lineNumber)
          ..add('description', description)
          ..add('status', status)
          ..add('laborCost', laborCost)
          ..add('note', note))
        .toString();
  }
}

class WorkOrderJobBuilder
    implements Builder<WorkOrderJob, WorkOrderJobBuilder> {
  _$WorkOrderJob? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  int? _lineNumber;
  int? get lineNumber => _$this._lineNumber;
  set lineNumber(int? lineNumber) => _$this._lineNumber = lineNumber;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  WorkOrderJobStatusEnum? _status;
  WorkOrderJobStatusEnum? get status => _$this._status;
  set status(WorkOrderJobStatusEnum? status) => _$this._status = status;

  String? _laborCost;
  String? get laborCost => _$this._laborCost;
  set laborCost(String? laborCost) => _$this._laborCost = laborCost;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  WorkOrderJobBuilder() {
    WorkOrderJob._defaults(this);
  }

  WorkOrderJobBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _lineNumber = $v.lineNumber;
      _description = $v.description;
      _status = $v.status;
      _laborCost = $v.laborCost;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkOrderJob other) {
    _$v = other as _$WorkOrderJob;
  }

  @override
  void update(void Function(WorkOrderJobBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkOrderJob build() => _build();

  _$WorkOrderJob _build() {
    final _$result = _$v ??
        _$WorkOrderJob._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'WorkOrderJob', 'id'),
          lineNumber: BuiltValueNullFieldError.checkNotNull(
              lineNumber, r'WorkOrderJob', 'lineNumber'),
          description: BuiltValueNullFieldError.checkNotNull(
              description, r'WorkOrderJob', 'description'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'WorkOrderJob', 'status'),
          laborCost: BuiltValueNullFieldError.checkNotNull(
              laborCost, r'WorkOrderJob', 'laborCost'),
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
