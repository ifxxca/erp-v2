// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_vehicle_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateVehicleRequestOwnershipTypeEnum
    _$createVehicleRequestOwnershipTypeEnum_owned =
    const CreateVehicleRequestOwnershipTypeEnum._('owned');
const CreateVehicleRequestOwnershipTypeEnum
    _$createVehicleRequestOwnershipTypeEnum_leased =
    const CreateVehicleRequestOwnershipTypeEnum._('leased');
const CreateVehicleRequestOwnershipTypeEnum
    _$createVehicleRequestOwnershipTypeEnum_vendor =
    const CreateVehicleRequestOwnershipTypeEnum._('vendor');
const CreateVehicleRequestOwnershipTypeEnum
    _$createVehicleRequestOwnershipTypeEnum_unknownDefaultOpenApi =
    const CreateVehicleRequestOwnershipTypeEnum._('unknownDefaultOpenApi');

CreateVehicleRequestOwnershipTypeEnum
    _$createVehicleRequestOwnershipTypeEnumValueOf(String name) {
  switch (name) {
    case 'owned':
      return _$createVehicleRequestOwnershipTypeEnum_owned;
    case 'leased':
      return _$createVehicleRequestOwnershipTypeEnum_leased;
    case 'vendor':
      return _$createVehicleRequestOwnershipTypeEnum_vendor;
    case 'unknownDefaultOpenApi':
      return _$createVehicleRequestOwnershipTypeEnum_unknownDefaultOpenApi;
    default:
      return _$createVehicleRequestOwnershipTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateVehicleRequestOwnershipTypeEnum>
    _$createVehicleRequestOwnershipTypeEnumValues = BuiltSet<
        CreateVehicleRequestOwnershipTypeEnum>(const <CreateVehicleRequestOwnershipTypeEnum>[
  _$createVehicleRequestOwnershipTypeEnum_owned,
  _$createVehicleRequestOwnershipTypeEnum_leased,
  _$createVehicleRequestOwnershipTypeEnum_vendor,
  _$createVehicleRequestOwnershipTypeEnum_unknownDefaultOpenApi,
]);

Serializer<CreateVehicleRequestOwnershipTypeEnum>
    _$createVehicleRequestOwnershipTypeEnumSerializer =
    _$CreateVehicleRequestOwnershipTypeEnumSerializer();

class _$CreateVehicleRequestOwnershipTypeEnumSerializer
    implements PrimitiveSerializer<CreateVehicleRequestOwnershipTypeEnum> {
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
  final Iterable<Type> types = const <Type>[
    CreateVehicleRequestOwnershipTypeEnum
  ];
  @override
  final String wireName = 'CreateVehicleRequestOwnershipTypeEnum';

  @override
  Object serialize(
          Serializers serializers, CreateVehicleRequestOwnershipTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateVehicleRequestOwnershipTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateVehicleRequestOwnershipTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateVehicleRequest extends CreateVehicleRequest {
  @override
  final String vehicleTypeId;
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
  final CreateVehicleRequestOwnershipTypeEnum ownershipType;
  @override
  final String? providerName;
  @override
  final int currentOdometer;

  factory _$CreateVehicleRequest(
          [void Function(CreateVehicleRequestBuilder)? updates]) =>
      (CreateVehicleRequestBuilder()..update(updates))._build();

  _$CreateVehicleRequest._(
      {required this.vehicleTypeId,
      required this.code,
      required this.plateNumber,
      required this.brand,
      required this.model,
      this.modelYear,
      required this.ownershipType,
      this.providerName,
      required this.currentOdometer})
      : super._();
  @override
  CreateVehicleRequest rebuild(
          void Function(CreateVehicleRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateVehicleRequestBuilder toBuilder() =>
      CreateVehicleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateVehicleRequest &&
        vehicleTypeId == other.vehicleTypeId &&
        code == other.code &&
        plateNumber == other.plateNumber &&
        brand == other.brand &&
        model == other.model &&
        modelYear == other.modelYear &&
        ownershipType == other.ownershipType &&
        providerName == other.providerName &&
        currentOdometer == other.currentOdometer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, vehicleTypeId.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, plateNumber.hashCode);
    _$hash = $jc(_$hash, brand.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, modelYear.hashCode);
    _$hash = $jc(_$hash, ownershipType.hashCode);
    _$hash = $jc(_$hash, providerName.hashCode);
    _$hash = $jc(_$hash, currentOdometer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateVehicleRequest')
          ..add('vehicleTypeId', vehicleTypeId)
          ..add('code', code)
          ..add('plateNumber', plateNumber)
          ..add('brand', brand)
          ..add('model', model)
          ..add('modelYear', modelYear)
          ..add('ownershipType', ownershipType)
          ..add('providerName', providerName)
          ..add('currentOdometer', currentOdometer))
        .toString();
  }
}

class CreateVehicleRequestBuilder
    implements Builder<CreateVehicleRequest, CreateVehicleRequestBuilder> {
  _$CreateVehicleRequest? _$v;

  String? _vehicleTypeId;
  String? get vehicleTypeId => _$this._vehicleTypeId;
  set vehicleTypeId(String? vehicleTypeId) =>
      _$this._vehicleTypeId = vehicleTypeId;

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

  CreateVehicleRequestOwnershipTypeEnum? _ownershipType;
  CreateVehicleRequestOwnershipTypeEnum? get ownershipType =>
      _$this._ownershipType;
  set ownershipType(CreateVehicleRequestOwnershipTypeEnum? ownershipType) =>
      _$this._ownershipType = ownershipType;

  String? _providerName;
  String? get providerName => _$this._providerName;
  set providerName(String? providerName) => _$this._providerName = providerName;

  int? _currentOdometer;
  int? get currentOdometer => _$this._currentOdometer;
  set currentOdometer(int? currentOdometer) =>
      _$this._currentOdometer = currentOdometer;

  CreateVehicleRequestBuilder() {
    CreateVehicleRequest._defaults(this);
  }

  CreateVehicleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _vehicleTypeId = $v.vehicleTypeId;
      _code = $v.code;
      _plateNumber = $v.plateNumber;
      _brand = $v.brand;
      _model = $v.model;
      _modelYear = $v.modelYear;
      _ownershipType = $v.ownershipType;
      _providerName = $v.providerName;
      _currentOdometer = $v.currentOdometer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateVehicleRequest other) {
    _$v = other as _$CreateVehicleRequest;
  }

  @override
  void update(void Function(CreateVehicleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateVehicleRequest build() => _build();

  _$CreateVehicleRequest _build() {
    final _$result = _$v ??
        _$CreateVehicleRequest._(
          vehicleTypeId: BuiltValueNullFieldError.checkNotNull(
              vehicleTypeId, r'CreateVehicleRequest', 'vehicleTypeId'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'CreateVehicleRequest', 'code'),
          plateNumber: BuiltValueNullFieldError.checkNotNull(
              plateNumber, r'CreateVehicleRequest', 'plateNumber'),
          brand: BuiltValueNullFieldError.checkNotNull(
              brand, r'CreateVehicleRequest', 'brand'),
          model: BuiltValueNullFieldError.checkNotNull(
              model, r'CreateVehicleRequest', 'model'),
          modelYear: modelYear,
          ownershipType: BuiltValueNullFieldError.checkNotNull(
              ownershipType, r'CreateVehicleRequest', 'ownershipType'),
          providerName: providerName,
          currentOdometer: BuiltValueNullFieldError.checkNotNull(
              currentOdometer, r'CreateVehicleRequest', 'currentOdometer'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
