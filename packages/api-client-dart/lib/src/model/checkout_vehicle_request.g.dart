// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_vehicle_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CheckoutVehicleRequest extends CheckoutVehicleRequest {
  @override
  final String vehicleId;
  @override
  final String purpose;
  @override
  final String? destination;
  @override
  final int startOdometer;
  @override
  final DateTime? departedAt;
  @override
  final BuiltList<ChecklistAnswerInput> answers;

  factory _$CheckoutVehicleRequest(
          [void Function(CheckoutVehicleRequestBuilder)? updates]) =>
      (CheckoutVehicleRequestBuilder()..update(updates))._build();

  _$CheckoutVehicleRequest._(
      {required this.vehicleId,
      required this.purpose,
      this.destination,
      required this.startOdometer,
      this.departedAt,
      required this.answers})
      : super._();
  @override
  CheckoutVehicleRequest rebuild(
          void Function(CheckoutVehicleRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CheckoutVehicleRequestBuilder toBuilder() =>
      CheckoutVehicleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckoutVehicleRequest &&
        vehicleId == other.vehicleId &&
        purpose == other.purpose &&
        destination == other.destination &&
        startOdometer == other.startOdometer &&
        departedAt == other.departedAt &&
        answers == other.answers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vehicleId.hashCode);
    _$hash = $jc(_$hash, purpose.hashCode);
    _$hash = $jc(_$hash, destination.hashCode);
    _$hash = $jc(_$hash, startOdometer.hashCode);
    _$hash = $jc(_$hash, departedAt.hashCode);
    _$hash = $jc(_$hash, answers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CheckoutVehicleRequest')
          ..add('vehicleId', vehicleId)
          ..add('purpose', purpose)
          ..add('destination', destination)
          ..add('startOdometer', startOdometer)
          ..add('departedAt', departedAt)
          ..add('answers', answers))
        .toString();
  }
}

class CheckoutVehicleRequestBuilder
    implements Builder<CheckoutVehicleRequest, CheckoutVehicleRequestBuilder> {
  _$CheckoutVehicleRequest? _$v;

  String? _vehicleId;
  String? get vehicleId => _$this._vehicleId;
  set vehicleId(String? vehicleId) => _$this._vehicleId = vehicleId;

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

  DateTime? _departedAt;
  DateTime? get departedAt => _$this._departedAt;
  set departedAt(DateTime? departedAt) => _$this._departedAt = departedAt;

  ListBuilder<ChecklistAnswerInput>? _answers;
  ListBuilder<ChecklistAnswerInput> get answers =>
      _$this._answers ??= ListBuilder<ChecklistAnswerInput>();
  set answers(ListBuilder<ChecklistAnswerInput>? answers) =>
      _$this._answers = answers;

  CheckoutVehicleRequestBuilder() {
    CheckoutVehicleRequest._defaults(this);
  }

  CheckoutVehicleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vehicleId = $v.vehicleId;
      _purpose = $v.purpose;
      _destination = $v.destination;
      _startOdometer = $v.startOdometer;
      _departedAt = $v.departedAt;
      _answers = $v.answers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckoutVehicleRequest other) {
    _$v = other as _$CheckoutVehicleRequest;
  }

  @override
  void update(void Function(CheckoutVehicleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckoutVehicleRequest build() => _build();

  _$CheckoutVehicleRequest _build() {
    _$CheckoutVehicleRequest _$result;
    try {
      _$result = _$v ??
          _$CheckoutVehicleRequest._(
            vehicleId: BuiltValueNullFieldError.checkNotNull(
                vehicleId, r'CheckoutVehicleRequest', 'vehicleId'),
            purpose: BuiltValueNullFieldError.checkNotNull(
                purpose, r'CheckoutVehicleRequest', 'purpose'),
            destination: destination,
            startOdometer: BuiltValueNullFieldError.checkNotNull(
                startOdometer, r'CheckoutVehicleRequest', 'startOdometer'),
            departedAt: departedAt,
            answers: answers.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'answers';
        answers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CheckoutVehicleRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
