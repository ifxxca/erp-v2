// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_trip.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VehicleTrip extends VehicleTrip {
  @override
  final String id;
  @override
  final VehicleTripStatus status;
  @override
  final String purpose;
  @override
  final String? destination;
  @override
  final int startOdometer;
  @override
  final int? endOdometer;
  @override
  final DateTime departedAt;
  @override
  final DateTime? arrivedAt;
  @override
  final DateTime? cancelledAt;
  @override
  final String? completionNote;
  @override
  final String? cancelReason;
  @override
  final Vehicle vehicle;
  @override
  final UserSummary driver;
  @override
  final ChecklistSubmission? checklist;

  factory _$VehicleTrip([void Function(VehicleTripBuilder)? updates]) =>
      (VehicleTripBuilder()..update(updates))._build();

  _$VehicleTrip._(
      {required this.id,
      required this.status,
      required this.purpose,
      this.destination,
      required this.startOdometer,
      this.endOdometer,
      required this.departedAt,
      this.arrivedAt,
      this.cancelledAt,
      this.completionNote,
      this.cancelReason,
      required this.vehicle,
      required this.driver,
      this.checklist})
      : super._();
  @override
  VehicleTrip rebuild(void Function(VehicleTripBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VehicleTripBuilder toBuilder() => VehicleTripBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VehicleTrip &&
        id == other.id &&
        status == other.status &&
        purpose == other.purpose &&
        destination == other.destination &&
        startOdometer == other.startOdometer &&
        endOdometer == other.endOdometer &&
        departedAt == other.departedAt &&
        arrivedAt == other.arrivedAt &&
        cancelledAt == other.cancelledAt &&
        completionNote == other.completionNote &&
        cancelReason == other.cancelReason &&
        vehicle == other.vehicle &&
        driver == other.driver &&
        checklist == other.checklist;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, purpose.hashCode);
    _$hash = $jc(_$hash, destination.hashCode);
    _$hash = $jc(_$hash, startOdometer.hashCode);
    _$hash = $jc(_$hash, endOdometer.hashCode);
    _$hash = $jc(_$hash, departedAt.hashCode);
    _$hash = $jc(_$hash, arrivedAt.hashCode);
    _$hash = $jc(_$hash, cancelledAt.hashCode);
    _$hash = $jc(_$hash, completionNote.hashCode);
    _$hash = $jc(_$hash, cancelReason.hashCode);
    _$hash = $jc(_$hash, vehicle.hashCode);
    _$hash = $jc(_$hash, driver.hashCode);
    _$hash = $jc(_$hash, checklist.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VehicleTrip')
          ..add('id', id)
          ..add('status', status)
          ..add('purpose', purpose)
          ..add('destination', destination)
          ..add('startOdometer', startOdometer)
          ..add('endOdometer', endOdometer)
          ..add('departedAt', departedAt)
          ..add('arrivedAt', arrivedAt)
          ..add('cancelledAt', cancelledAt)
          ..add('completionNote', completionNote)
          ..add('cancelReason', cancelReason)
          ..add('vehicle', vehicle)
          ..add('driver', driver)
          ..add('checklist', checklist))
        .toString();
  }
}

class VehicleTripBuilder implements Builder<VehicleTrip, VehicleTripBuilder> {
  _$VehicleTrip? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  VehicleTripStatus? _status;
  VehicleTripStatus? get status => _$this._status;
  set status(VehicleTripStatus? status) => _$this._status = status;

  String? _purpose;
  String? get purpose => _$this._purpose;
  set purpose(String? purpose) => _$this._purpose = purpose;

  String? _destination;
  String? get destination => _$this._destination;
  set destination(String? destination) => _$this._destination = destination;

  int? _startOdometer;
  int? get startOdometer => _$this._startOdometer;
  set startOdometer(int? startOdometer) =>
      _$this._startOdometer = startOdometer;

  int? _endOdometer;
  int? get endOdometer => _$this._endOdometer;
  set endOdometer(int? endOdometer) => _$this._endOdometer = endOdometer;

  DateTime? _departedAt;
  DateTime? get departedAt => _$this._departedAt;
  set departedAt(DateTime? departedAt) => _$this._departedAt = departedAt;

  DateTime? _arrivedAt;
  DateTime? get arrivedAt => _$this._arrivedAt;
  set arrivedAt(DateTime? arrivedAt) => _$this._arrivedAt = arrivedAt;

  DateTime? _cancelledAt;
  DateTime? get cancelledAt => _$this._cancelledAt;
  set cancelledAt(DateTime? cancelledAt) => _$this._cancelledAt = cancelledAt;

  String? _completionNote;
  String? get completionNote => _$this._completionNote;
  set completionNote(String? completionNote) =>
      _$this._completionNote = completionNote;

  String? _cancelReason;
  String? get cancelReason => _$this._cancelReason;
  set cancelReason(String? cancelReason) => _$this._cancelReason = cancelReason;

  VehicleBuilder? _vehicle;
  VehicleBuilder get vehicle => _$this._vehicle ??= VehicleBuilder();
  set vehicle(VehicleBuilder? vehicle) => _$this._vehicle = vehicle;

  UserSummary? _driver;
  UserSummary? get driver => _$this._driver;
  set driver(UserSummary? driver) => _$this._driver = driver;

  ChecklistSubmissionBuilder? _checklist;
  ChecklistSubmissionBuilder get checklist =>
      _$this._checklist ??= ChecklistSubmissionBuilder();
  set checklist(ChecklistSubmissionBuilder? checklist) =>
      _$this._checklist = checklist;

  VehicleTripBuilder() {
    VehicleTrip._defaults(this);
  }

  VehicleTripBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _status = $v.status;
      _purpose = $v.purpose;
      _destination = $v.destination;
      _startOdometer = $v.startOdometer;
      _endOdometer = $v.endOdometer;
      _departedAt = $v.departedAt;
      _arrivedAt = $v.arrivedAt;
      _cancelledAt = $v.cancelledAt;
      _completionNote = $v.completionNote;
      _cancelReason = $v.cancelReason;
      _vehicle = $v.vehicle.toBuilder();
      _driver = $v.driver;
      _checklist = $v.checklist?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VehicleTrip other) {
    _$v = other as _$VehicleTrip;
  }

  @override
  void update(void Function(VehicleTripBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VehicleTrip build() => _build();

  _$VehicleTrip _build() {
    _$VehicleTrip _$result;
    try {
      _$result = _$v ??
          _$VehicleTrip._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'VehicleTrip', 'id'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'VehicleTrip', 'status'),
            purpose: BuiltValueNullFieldError.checkNotNull(
                purpose, r'VehicleTrip', 'purpose'),
            destination: destination,
            startOdometer: BuiltValueNullFieldError.checkNotNull(
                startOdometer, r'VehicleTrip', 'startOdometer'),
            endOdometer: endOdometer,
            departedAt: BuiltValueNullFieldError.checkNotNull(
                departedAt, r'VehicleTrip', 'departedAt'),
            arrivedAt: arrivedAt,
            cancelledAt: cancelledAt,
            completionNote: completionNote,
            cancelReason: cancelReason,
            vehicle: vehicle.build(),
            driver: BuiltValueNullFieldError.checkNotNull(
                driver, r'VehicleTrip', 'driver'),
            checklist: _checklist?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'vehicle';
        vehicle.build();

        _$failedField = 'checklist';
        _checklist?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'VehicleTrip', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
