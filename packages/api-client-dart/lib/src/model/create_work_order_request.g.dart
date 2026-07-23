// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_work_order_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateWorkOrderRequestPriorityEnum
    _$createWorkOrderRequestPriorityEnum_low =
    const CreateWorkOrderRequestPriorityEnum._('low');
const CreateWorkOrderRequestPriorityEnum
    _$createWorkOrderRequestPriorityEnum_normal =
    const CreateWorkOrderRequestPriorityEnum._('normal');
const CreateWorkOrderRequestPriorityEnum
    _$createWorkOrderRequestPriorityEnum_high =
    const CreateWorkOrderRequestPriorityEnum._('high');
const CreateWorkOrderRequestPriorityEnum
    _$createWorkOrderRequestPriorityEnum_urgent =
    const CreateWorkOrderRequestPriorityEnum._('urgent');
const CreateWorkOrderRequestPriorityEnum
    _$createWorkOrderRequestPriorityEnum_unknownDefaultOpenApi =
    const CreateWorkOrderRequestPriorityEnum._('unknownDefaultOpenApi');

CreateWorkOrderRequestPriorityEnum _$createWorkOrderRequestPriorityEnumValueOf(
    String name) {
  switch (name) {
    case 'low':
      return _$createWorkOrderRequestPriorityEnum_low;
    case 'normal':
      return _$createWorkOrderRequestPriorityEnum_normal;
    case 'high':
      return _$createWorkOrderRequestPriorityEnum_high;
    case 'urgent':
      return _$createWorkOrderRequestPriorityEnum_urgent;
    case 'unknownDefaultOpenApi':
      return _$createWorkOrderRequestPriorityEnum_unknownDefaultOpenApi;
    default:
      return _$createWorkOrderRequestPriorityEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateWorkOrderRequestPriorityEnum>
    _$createWorkOrderRequestPriorityEnumValues = BuiltSet<
        CreateWorkOrderRequestPriorityEnum>(const <CreateWorkOrderRequestPriorityEnum>[
  _$createWorkOrderRequestPriorityEnum_low,
  _$createWorkOrderRequestPriorityEnum_normal,
  _$createWorkOrderRequestPriorityEnum_high,
  _$createWorkOrderRequestPriorityEnum_urgent,
  _$createWorkOrderRequestPriorityEnum_unknownDefaultOpenApi,
]);

Serializer<CreateWorkOrderRequestPriorityEnum>
    _$createWorkOrderRequestPriorityEnumSerializer =
    _$CreateWorkOrderRequestPriorityEnumSerializer();

class _$CreateWorkOrderRequestPriorityEnumSerializer
    implements PrimitiveSerializer<CreateWorkOrderRequestPriorityEnum> {
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
  final Iterable<Type> types = const <Type>[CreateWorkOrderRequestPriorityEnum];
  @override
  final String wireName = 'CreateWorkOrderRequestPriorityEnum';

  @override
  Object serialize(
          Serializers serializers, CreateWorkOrderRequestPriorityEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateWorkOrderRequestPriorityEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateWorkOrderRequestPriorityEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateWorkOrderRequest extends CreateWorkOrderRequest {
  @override
  final String vehicleId;
  @override
  final Date workOrderDate;
  @override
  final CreateWorkOrderRequestPriorityEnum priority;
  @override
  final String problemDescription;
  @override
  final num? partsCost;
  @override
  final BuiltList<CreateWorkOrderRequestJobsInner> jobs;

  factory _$CreateWorkOrderRequest(
          [void Function(CreateWorkOrderRequestBuilder)? updates]) =>
      (CreateWorkOrderRequestBuilder()..update(updates))._build();

  _$CreateWorkOrderRequest._(
      {required this.vehicleId,
      required this.workOrderDate,
      required this.priority,
      required this.problemDescription,
      this.partsCost,
      required this.jobs})
      : super._();
  @override
  CreateWorkOrderRequest rebuild(
          void Function(CreateWorkOrderRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateWorkOrderRequestBuilder toBuilder() =>
      CreateWorkOrderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateWorkOrderRequest &&
        vehicleId == other.vehicleId &&
        workOrderDate == other.workOrderDate &&
        priority == other.priority &&
        problemDescription == other.problemDescription &&
        partsCost == other.partsCost &&
        jobs == other.jobs;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vehicleId.hashCode);
    _$hash = $jc(_$hash, workOrderDate.hashCode);
    _$hash = $jc(_$hash, priority.hashCode);
    _$hash = $jc(_$hash, problemDescription.hashCode);
    _$hash = $jc(_$hash, partsCost.hashCode);
    _$hash = $jc(_$hash, jobs.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateWorkOrderRequest')
          ..add('vehicleId', vehicleId)
          ..add('workOrderDate', workOrderDate)
          ..add('priority', priority)
          ..add('problemDescription', problemDescription)
          ..add('partsCost', partsCost)
          ..add('jobs', jobs))
        .toString();
  }
}

class CreateWorkOrderRequestBuilder
    implements Builder<CreateWorkOrderRequest, CreateWorkOrderRequestBuilder> {
  _$CreateWorkOrderRequest? _$v;

  String? _vehicleId;
  String? get vehicleId => _$this._vehicleId;
  set vehicleId(String? vehicleId) => _$this._vehicleId = vehicleId;

  Date? _workOrderDate;
  Date? get workOrderDate => _$this._workOrderDate;
  set workOrderDate(Date? workOrderDate) =>
      _$this._workOrderDate = workOrderDate;

  CreateWorkOrderRequestPriorityEnum? _priority;
  CreateWorkOrderRequestPriorityEnum? get priority => _$this._priority;
  set priority(CreateWorkOrderRequestPriorityEnum? priority) =>
      _$this._priority = priority;

  String? _problemDescription;
  String? get problemDescription => _$this._problemDescription;
  set problemDescription(String? problemDescription) =>
      _$this._problemDescription = problemDescription;

  num? _partsCost;
  num? get partsCost => _$this._partsCost;
  set partsCost(num? partsCost) => _$this._partsCost = partsCost;

  ListBuilder<CreateWorkOrderRequestJobsInner>? _jobs;
  ListBuilder<CreateWorkOrderRequestJobsInner> get jobs =>
      _$this._jobs ??= ListBuilder<CreateWorkOrderRequestJobsInner>();
  set jobs(ListBuilder<CreateWorkOrderRequestJobsInner>? jobs) =>
      _$this._jobs = jobs;

  CreateWorkOrderRequestBuilder() {
    CreateWorkOrderRequest._defaults(this);
  }

  CreateWorkOrderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vehicleId = $v.vehicleId;
      _workOrderDate = $v.workOrderDate;
      _priority = $v.priority;
      _problemDescription = $v.problemDescription;
      _partsCost = $v.partsCost;
      _jobs = $v.jobs.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateWorkOrderRequest other) {
    _$v = other as _$CreateWorkOrderRequest;
  }

  @override
  void update(void Function(CreateWorkOrderRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateWorkOrderRequest build() => _build();

  _$CreateWorkOrderRequest _build() {
    _$CreateWorkOrderRequest _$result;
    try {
      _$result = _$v ??
          _$CreateWorkOrderRequest._(
            vehicleId: BuiltValueNullFieldError.checkNotNull(
                vehicleId, r'CreateWorkOrderRequest', 'vehicleId'),
            workOrderDate: BuiltValueNullFieldError.checkNotNull(
                workOrderDate, r'CreateWorkOrderRequest', 'workOrderDate'),
            priority: BuiltValueNullFieldError.checkNotNull(
                priority, r'CreateWorkOrderRequest', 'priority'),
            problemDescription: BuiltValueNullFieldError.checkNotNull(
                problemDescription,
                r'CreateWorkOrderRequest',
                'problemDescription'),
            partsCost: partsCost,
            jobs: jobs.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'jobs';
        jobs.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateWorkOrderRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
