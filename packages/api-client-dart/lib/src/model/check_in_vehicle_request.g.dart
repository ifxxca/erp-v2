// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_vehicle_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CheckInVehicleRequest extends CheckInVehicleRequest {
  @override
  final int endOdometer;
  @override
  final DateTime? arrivedAt;
  @override
  final String? note;

  factory _$CheckInVehicleRequest(
          [void Function(CheckInVehicleRequestBuilder)? updates]) =>
      (CheckInVehicleRequestBuilder()..update(updates))._build();

  _$CheckInVehicleRequest._(
      {required this.endOdometer, this.arrivedAt, this.note})
      : super._();
  @override
  CheckInVehicleRequest rebuild(
          void Function(CheckInVehicleRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CheckInVehicleRequestBuilder toBuilder() =>
      CheckInVehicleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckInVehicleRequest &&
        endOdometer == other.endOdometer &&
        arrivedAt == other.arrivedAt &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, endOdometer.hashCode);
    _$hash = $jc(_$hash, arrivedAt.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CheckInVehicleRequest')
          ..add('endOdometer', endOdometer)
          ..add('arrivedAt', arrivedAt)
          ..add('note', note))
        .toString();
  }
}

class CheckInVehicleRequestBuilder
    implements Builder<CheckInVehicleRequest, CheckInVehicleRequestBuilder> {
  _$CheckInVehicleRequest? _$v;

  int? _endOdometer;
  int? get endOdometer => _$this._endOdometer;
  set endOdometer(int? endOdometer) => _$this._endOdometer = endOdometer;

  DateTime? _arrivedAt;
  DateTime? get arrivedAt => _$this._arrivedAt;
  set arrivedAt(DateTime? arrivedAt) => _$this._arrivedAt = arrivedAt;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  CheckInVehicleRequestBuilder() {
    CheckInVehicleRequest._defaults(this);
  }

  CheckInVehicleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _endOdometer = $v.endOdometer;
      _arrivedAt = $v.arrivedAt;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckInVehicleRequest other) {
    _$v = other as _$CheckInVehicleRequest;
  }

  @override
  void update(void Function(CheckInVehicleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckInVehicleRequest build() => _build();

  _$CheckInVehicleRequest _build() {
    final _$result = _$v ??
        _$CheckInVehicleRequest._(
          endOdometer: BuiltValueNullFieldError.checkNotNull(
              endOdometer, r'CheckInVehicleRequest', 'endOdometer'),
          arrivedAt: arrivedAt,
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
