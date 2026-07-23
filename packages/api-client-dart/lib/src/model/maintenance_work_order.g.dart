// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_work_order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MaintenanceWorkOrderPriorityEnum _$maintenanceWorkOrderPriorityEnum_low =
    const MaintenanceWorkOrderPriorityEnum._('low');
const MaintenanceWorkOrderPriorityEnum
    _$maintenanceWorkOrderPriorityEnum_normal =
    const MaintenanceWorkOrderPriorityEnum._('normal');
const MaintenanceWorkOrderPriorityEnum _$maintenanceWorkOrderPriorityEnum_high =
    const MaintenanceWorkOrderPriorityEnum._('high');
const MaintenanceWorkOrderPriorityEnum
    _$maintenanceWorkOrderPriorityEnum_urgent =
    const MaintenanceWorkOrderPriorityEnum._('urgent');
const MaintenanceWorkOrderPriorityEnum
    _$maintenanceWorkOrderPriorityEnum_unknownDefaultOpenApi =
    const MaintenanceWorkOrderPriorityEnum._('unknownDefaultOpenApi');

MaintenanceWorkOrderPriorityEnum _$maintenanceWorkOrderPriorityEnumValueOf(
    String name) {
  switch (name) {
    case 'low':
      return _$maintenanceWorkOrderPriorityEnum_low;
    case 'normal':
      return _$maintenanceWorkOrderPriorityEnum_normal;
    case 'high':
      return _$maintenanceWorkOrderPriorityEnum_high;
    case 'urgent':
      return _$maintenanceWorkOrderPriorityEnum_urgent;
    case 'unknownDefaultOpenApi':
      return _$maintenanceWorkOrderPriorityEnum_unknownDefaultOpenApi;
    default:
      return _$maintenanceWorkOrderPriorityEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MaintenanceWorkOrderPriorityEnum>
    _$maintenanceWorkOrderPriorityEnumValues = BuiltSet<
        MaintenanceWorkOrderPriorityEnum>(const <MaintenanceWorkOrderPriorityEnum>[
  _$maintenanceWorkOrderPriorityEnum_low,
  _$maintenanceWorkOrderPriorityEnum_normal,
  _$maintenanceWorkOrderPriorityEnum_high,
  _$maintenanceWorkOrderPriorityEnum_urgent,
  _$maintenanceWorkOrderPriorityEnum_unknownDefaultOpenApi,
]);

Serializer<MaintenanceWorkOrderPriorityEnum>
    _$maintenanceWorkOrderPriorityEnumSerializer =
    _$MaintenanceWorkOrderPriorityEnumSerializer();

class _$MaintenanceWorkOrderPriorityEnumSerializer
    implements PrimitiveSerializer<MaintenanceWorkOrderPriorityEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'low': 'low',
    'normal': 'normal',
    'high': 'high',
    'urgent': 'urgent',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'low': 'low',
    'normal': 'normal',
    'high': 'high',
    'urgent': 'urgent',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[MaintenanceWorkOrderPriorityEnum];
  @override
  final String wireName = 'MaintenanceWorkOrderPriorityEnum';

  @override
  Object serialize(
          Serializers serializers, MaintenanceWorkOrderPriorityEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MaintenanceWorkOrderPriorityEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MaintenanceWorkOrderPriorityEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MaintenanceWorkOrder extends MaintenanceWorkOrder {
  @override
  final String id;
  @override
  final String? documentNumber;
  @override
  final Date workOrderDate;
  @override
  final MaintenanceWorkOrderPriorityEnum priority;
  @override
  final WorkOrderStatus status;
  @override
  final String problemDescription;
  @override
  final String? completionNote;
  @override
  final String? laborCost;
  @override
  final String? partsCost;
  @override
  final String totalCost;
  @override
  final Vehicle vehicle;
  @override
  final BuiltList<WorkOrderJob> jobs;

  factory _$MaintenanceWorkOrder(
          [void Function(MaintenanceWorkOrderBuilder)? updates]) =>
      (MaintenanceWorkOrderBuilder()..update(updates))._build();

  _$MaintenanceWorkOrder._(
      {required this.id,
      this.documentNumber,
      required this.workOrderDate,
      required this.priority,
      required this.status,
      required this.problemDescription,
      this.completionNote,
      this.laborCost,
      this.partsCost,
      required this.totalCost,
      required this.vehicle,
      required this.jobs})
      : super._();
  @override
  MaintenanceWorkOrder rebuild(
          void Function(MaintenanceWorkOrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MaintenanceWorkOrderBuilder toBuilder() =>
      MaintenanceWorkOrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MaintenanceWorkOrder &&
        id == other.id &&
        documentNumber == other.documentNumber &&
        workOrderDate == other.workOrderDate &&
        priority == other.priority &&
        status == other.status &&
        problemDescription == other.problemDescription &&
        completionNote == other.completionNote &&
        laborCost == other.laborCost &&
        partsCost == other.partsCost &&
        totalCost == other.totalCost &&
        vehicle == other.vehicle &&
        jobs == other.jobs;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, documentNumber.hashCode);
    _$hash = $jc(_$hash, workOrderDate.hashCode);
    _$hash = $jc(_$hash, priority.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, problemDescription.hashCode);
    _$hash = $jc(_$hash, completionNote.hashCode);
    _$hash = $jc(_$hash, laborCost.hashCode);
    _$hash = $jc(_$hash, partsCost.hashCode);
    _$hash = $jc(_$hash, totalCost.hashCode);
    _$hash = $jc(_$hash, vehicle.hashCode);
    _$hash = $jc(_$hash, jobs.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MaintenanceWorkOrder')
          ..add('id', id)
          ..add('documentNumber', documentNumber)
          ..add('workOrderDate', workOrderDate)
          ..add('priority', priority)
          ..add('status', status)
          ..add('problemDescription', problemDescription)
          ..add('completionNote', completionNote)
          ..add('laborCost', laborCost)
          ..add('partsCost', partsCost)
          ..add('totalCost', totalCost)
          ..add('vehicle', vehicle)
          ..add('jobs', jobs))
        .toString();
  }
}

class MaintenanceWorkOrderBuilder
    implements Builder<MaintenanceWorkOrder, MaintenanceWorkOrderBuilder> {
  _$MaintenanceWorkOrder? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _documentNumber;
  String? get documentNumber => _$this._documentNumber;
  set documentNumber(String? documentNumber) =>
      _$this._documentNumber = documentNumber;

  Date? _workOrderDate;
  Date? get workOrderDate => _$this._workOrderDate;
  set workOrderDate(Date? workOrderDate) =>
      _$this._workOrderDate = workOrderDate;

  MaintenanceWorkOrderPriorityEnum? _priority;
  MaintenanceWorkOrderPriorityEnum? get priority => _$this._priority;
  set priority(MaintenanceWorkOrderPriorityEnum? priority) =>
      _$this._priority = priority;

  WorkOrderStatus? _status;
  WorkOrderStatus? get status => _$this._status;
  set status(WorkOrderStatus? status) => _$this._status = status;

  String? _problemDescription;
  String? get problemDescription => _$this._problemDescription;
  set problemDescription(String? problemDescription) =>
      _$this._problemDescription = problemDescription;

  String? _completionNote;
  String? get completionNote => _$this._completionNote;
  set completionNote(String? completionNote) =>
      _$this._completionNote = completionNote;

  String? _laborCost;
  String? get laborCost => _$this._laborCost;
  set laborCost(String? laborCost) => _$this._laborCost = laborCost;

  String? _partsCost;
  String? get partsCost => _$this._partsCost;
  set partsCost(String? partsCost) => _$this._partsCost = partsCost;

  String? _totalCost;
  String? get totalCost => _$this._totalCost;
  set totalCost(String? totalCost) => _$this._totalCost = totalCost;

  VehicleBuilder? _vehicle;
  VehicleBuilder get vehicle => _$this._vehicle ??= VehicleBuilder();
  set vehicle(VehicleBuilder? vehicle) => _$this._vehicle = vehicle;

  ListBuilder<WorkOrderJob>? _jobs;
  ListBuilder<WorkOrderJob> get jobs =>
      _$this._jobs ??= ListBuilder<WorkOrderJob>();
  set jobs(ListBuilder<WorkOrderJob>? jobs) => _$this._jobs = jobs;

  MaintenanceWorkOrderBuilder() {
    MaintenanceWorkOrder._defaults(this);
  }

  MaintenanceWorkOrderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _documentNumber = $v.documentNumber;
      _workOrderDate = $v.workOrderDate;
      _priority = $v.priority;
      _status = $v.status;
      _problemDescription = $v.problemDescription;
      _completionNote = $v.completionNote;
      _laborCost = $v.laborCost;
      _partsCost = $v.partsCost;
      _totalCost = $v.totalCost;
      _vehicle = $v.vehicle.toBuilder();
      _jobs = $v.jobs.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MaintenanceWorkOrder other) {
    _$v = other as _$MaintenanceWorkOrder;
  }

  @override
  void update(void Function(MaintenanceWorkOrderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MaintenanceWorkOrder build() => _build();

  _$MaintenanceWorkOrder _build() {
    _$MaintenanceWorkOrder _$result;
    try {
      _$result = _$v ??
          _$MaintenanceWorkOrder._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'MaintenanceWorkOrder', 'id'),
            documentNumber: documentNumber,
            workOrderDate: BuiltValueNullFieldError.checkNotNull(
                workOrderDate, r'MaintenanceWorkOrder', 'workOrderDate'),
            priority: BuiltValueNullFieldError.checkNotNull(
                priority, r'MaintenanceWorkOrder', 'priority'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'MaintenanceWorkOrder', 'status'),
            problemDescription: BuiltValueNullFieldError.checkNotNull(
                problemDescription,
                r'MaintenanceWorkOrder',
                'problemDescription'),
            completionNote: completionNote,
            laborCost: laborCost,
            partsCost: partsCost,
            totalCost: BuiltValueNullFieldError.checkNotNull(
                totalCost, r'MaintenanceWorkOrder', 'totalCost'),
            vehicle: vehicle.build(),
            jobs: jobs.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vehicle';
        vehicle.build();
        _$failedField = 'jobs';
        jobs.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MaintenanceWorkOrder', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
