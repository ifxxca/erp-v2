// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const VehicleOwnershipTypeEnum _$vehicleOwnershipTypeEnum_owned =
    const VehicleOwnershipTypeEnum._('owned');
const VehicleOwnershipTypeEnum _$vehicleOwnershipTypeEnum_leased =
    const VehicleOwnershipTypeEnum._('leased');
const VehicleOwnershipTypeEnum _$vehicleOwnershipTypeEnum_vendor =
    const VehicleOwnershipTypeEnum._('vendor');
const VehicleOwnershipTypeEnum
    _$vehicleOwnershipTypeEnum_unknownDefaultOpenApi =
    const VehicleOwnershipTypeEnum._('unknownDefaultOpenApi');

VehicleOwnershipTypeEnum _$vehicleOwnershipTypeEnumValueOf(String name) {
  switch (name) {
    case 'owned':
      return _$vehicleOwnershipTypeEnum_owned;
    case 'leased':
      return _$vehicleOwnershipTypeEnum_leased;
    case 'vendor':
      return _$vehicleOwnershipTypeEnum_vendor;
    case 'unknownDefaultOpenApi':
      return _$vehicleOwnershipTypeEnum_unknownDefaultOpenApi;
    default:
      return _$vehicleOwnershipTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<VehicleOwnershipTypeEnum> _$vehicleOwnershipTypeEnumValues =
    BuiltSet<VehicleOwnershipTypeEnum>(const <VehicleOwnershipTypeEnum>[
  _$vehicleOwnershipTypeEnum_owned,
  _$vehicleOwnershipTypeEnum_leased,
  _$vehicleOwnershipTypeEnum_vendor,
  _$vehicleOwnershipTypeEnum_unknownDefaultOpenApi,
]);

Serializer<VehicleOwnershipTypeEnum> _$vehicleOwnershipTypeEnumSerializer =
    _$VehicleOwnershipTypeEnumSerializer();

class _$VehicleOwnershipTypeEnumSerializer
    implements PrimitiveSerializer<VehicleOwnershipTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'owned': 'owned',
    'leased': 'leased',
    'vendor': 'vendor',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'owned': 'owned',
    'leased': 'leased',
    'vendor': 'vendor',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[VehicleOwnershipTypeEnum];
  @override
  final String wireName = 'VehicleOwnershipTypeEnum';

  @override
  Object serialize(Serializers serializers, VehicleOwnershipTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  VehicleOwnershipTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      VehicleOwnershipTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Vehicle extends Vehicle {
  @override
  final String id;
  @override
  final String code;
  @override
  final String plateNumber;
  @override
  final String brand;
  @override
  final String model;
  @override
  final int? modelYear;
  @override
  final VehicleOwnershipTypeEnum? ownershipType;
  @override
  final String? providerName;
  @override
  final int currentOdometer;
  @override
  final VehicleStatus operationalStatus;
  @override
  final String? statusReason;
  @override
  final VehicleType? type;

  factory _$Vehicle([void Function(VehicleBuilder)? updates]) =>
      (VehicleBuilder()..update(updates))._build();

  _$Vehicle._(
      {required this.id,
      required this.code,
      required this.plateNumber,
      required this.brand,
      required this.model,
      this.modelYear,
      this.ownershipType,
      this.providerName,
      required this.currentOdometer,
      required this.operationalStatus,
      this.statusReason,
      this.type})
      : super._();
  @override
  Vehicle rebuild(void Function(VehicleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VehicleBuilder toBuilder() => VehicleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Vehicle &&
        id == other.id &&
        code == other.code &&
        plateNumber == other.plateNumber &&
        brand == other.brand &&
        model == other.model &&
        modelYear == other.modelYear &&
        ownershipType == other.ownershipType &&
        providerName == other.providerName &&
        currentOdometer == other.currentOdometer &&
        operationalStatus == other.operationalStatus &&
        statusReason == other.statusReason &&
        type == other.type;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, plateNumber.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, modelYear.hashCode);
    _$hash = $jc(_$hash, ownershipType.hashCode);
    _$hash = $jc(_$hash, providerName.hashCode);
    _$hash = $jc(_$hash, currentOdometer.hashCode);
    _$hash = $jc(_$hash, operationalStatus.hashCode);
    _$hash = $jc(_$hash, statusReason.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Vehicle')
          ..add('id', id)
          ..add('code', code)
          ..add('plateNumber', plateNumber)
          ..add('brand', brand)
          ..add('model', model)
          ..add('modelYear', modelYear)
          ..add('ownershipType', ownershipType)
          ..add('providerName', providerName)
          ..add('currentOdometer', currentOdometer)
          ..add('operationalStatus', operationalStatus)
          ..add('statusReason', statusReason)
          ..add('type', type))
        .toString();
  }
}

class VehicleBuilder implements Builder<Vehicle, VehicleBuilder> {
  _$Vehicle? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _plateNumber;
  String? get plateNumber => _$this._plateNumber;
  set plateNumber(String? plateNumber) => _$this._plateNumber = plateNumber;

  String? _brand;
  String? get brand => _$this._brand;
  set brand(String? brand) => _$this._brand = brand;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  int? _modelYear;
  int? get modelYear => _$this._modelYear;
  set modelYear(int? modelYear) => _$this._modelYear = modelYear;

  VehicleOwnershipTypeEnum? _ownershipType;
  VehicleOwnershipTypeEnum? get ownershipType => _$this._ownershipType;
  set ownershipType(VehicleOwnershipTypeEnum? ownershipType) =>
      _$this._ownershipType = ownershipType;

  String? _providerName;
  String? get providerName => _$this._providerName;
  set providerName(String? providerName) => _$this._providerName = providerName;

  int? _currentOdometer;
  int? get currentOdometer => _$this._currentOdometer;
  set currentOdometer(int? currentOdometer) =>
      _$this._currentOdometer = currentOdometer;

  VehicleStatus? _operationalStatus;
  VehicleStatus? get operationalStatus => _$this._operationalStatus;
  set operationalStatus(VehicleStatus? operationalStatus) =>
      _$this._operationalStatus = operationalStatus;

  String? _statusReason;
  String? get statusReason => _$this._statusReason;
  set statusReason(String? statusReason) => _$this._statusReason = statusReason;

  VehicleTypeBuilder? _type;
  VehicleTypeBuilder get type => _$this._type ??= VehicleTypeBuilder();
  set type(VehicleTypeBuilder? type) => _$this._type = type;

  VehicleBuilder() {
    Vehicle._defaults(this);
  }

  VehicleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _plateNumber = $v.plateNumber;
      _brand = $v.brand;
      _model = $v.model;
      _modelYear = $v.modelYear;
      _ownershipType = $v.ownershipType;
      _providerName = $v.providerName;
      _currentOdometer = $v.currentOdometer;
      _operationalStatus = $v.operationalStatus;
      _statusReason = $v.statusReason;
      _type = $v.type?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Vehicle other) {
    _$v = other as _$Vehicle;
  }

  @override
  void update(void Function(VehicleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Vehicle build() => _build();

  _$Vehicle _build() {
    _$Vehicle _$result;
    try {
      _$result = _$v ??
          _$Vehicle._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Vehicle', 'id'),
            code:
                BuiltValueNullFieldError.checkNotNull(code, r'Vehicle', 'code'),
            plateNumber: BuiltValueNullFieldError.checkNotNull(
                plateNumber, r'Vehicle', 'plateNumber'),
            brand: BuiltValueNullFieldError.checkNotNull(
                brand, r'Vehicle', 'brand'),
            model: BuiltValueNullFieldError.checkNotNull(
                model, r'Vehicle', 'model'),
            modelYear: modelYear,
            ownershipType: ownershipType,
            providerName: providerName,
            currentOdometer: BuiltValueNullFieldError.checkNotNull(
                currentOdometer, r'Vehicle', 'currentOdometer'),
            operationalStatus: BuiltValueNullFieldError.checkNotNull(
                operationalStatus, r'Vehicle', 'operationalStatus'),
            statusReason: statusReason,
            type: _type?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'type';
        _type?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Vehicle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
