//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/vehicle_type.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/vehicle_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'vehicle.g.dart';

/// Vehicle
///
/// Properties:
/// * [id]
/// * [code]
/// * [plateNumber]
/// * [brand]
/// * [model]
/// * [modelYear]
/// * [ownershipType]
/// * [providerName]
/// * [currentOdometer]
/// * [operationalStatus]
/// * [statusReason]
/// * [type]
@BuiltValue()
abstract class Vehicle implements Built<Vehicle, VehicleBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'plate_number')
  String get plateNumber;

  @BuiltValueField(wireName: r'brand')
  String get brand;

  @BuiltValueField(wireName: r'model')
  String get model;

  @BuiltValueField(wireName: r'model_year')
  int? get modelYear;

  @BuiltValueField(wireName: r'ownership_type')
  VehicleOwnershipTypeEnum? get ownershipType;
  // enum ownershipTypeEnum {  owned,  leased,  vendor,  };

  @BuiltValueField(wireName: r'provider_name')
  String? get providerName;

  @BuiltValueField(wireName: r'current_odometer')
  int get currentOdometer;

  @BuiltValueField(wireName: r'operational_status')
  VehicleStatus get operationalStatus;
  // enum operationalStatusEnum {  available,  in_use,  maintenance,  blocked,  inactive,  };

  @BuiltValueField(wireName: r'status_reason')
  String? get statusReason;

  @BuiltValueField(wireName: r'type')
  VehicleType? get type;

  Vehicle._();

  factory Vehicle([void updates(VehicleBuilder b)]) = _$Vehicle;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VehicleBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Vehicle> get serializer => _$VehicleSerializer();
}

class _$VehicleSerializer implements PrimitiveSerializer<Vehicle> {
  @override
  final Iterable<Type> types = const [Vehicle, _$Vehicle];

  @override
  final String wireName = r'Vehicle';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Vehicle object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'plate_number';
    yield serializers.serialize(
      object.plateNumber,
      specifiedType: const FullType(String),
    );
    yield r'brand';
    yield serializers.serialize(
      object.brand,
      specifiedType: const FullType(String),
    );
    yield r'model';
    yield serializers.serialize(
      object.model,
      specifiedType: const FullType(String),
    );
    if (object.modelYear != null) {
      yield r'model_year';
      yield serializers.serialize(
        object.modelYear,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.ownershipType != null) {
      yield r'ownership_type';
      yield serializers.serialize(
        object.ownershipType,
        specifiedType: const FullType(VehicleOwnershipTypeEnum),
      );
    }
    if (object.providerName != null) {
      yield r'provider_name';
      yield serializers.serialize(
        object.providerName,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'current_odometer';
    yield serializers.serialize(
      object.currentOdometer,
      specifiedType: const FullType(int),
    );
    yield r'operational_status';
    yield serializers.serialize(
      object.operationalStatus,
      specifiedType: const FullType(VehicleStatus),
    );
    if (object.statusReason != null) {
      yield r'status_reason';
      yield serializers.serialize(
        object.statusReason,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(VehicleType),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Vehicle object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VehicleBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'plate_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.plateNumber = valueDes;
          break;
        case r'brand':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.brand = valueDes;
          break;
        case r'model':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.model = valueDes;
          break;
        case r'model_year':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.modelYear = valueDes;
          break;
        case r'ownership_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(VehicleOwnershipTypeEnum),
          ) as VehicleOwnershipTypeEnum;
          result.ownershipType = valueDes;
          break;
        case r'provider_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.providerName = valueDes;
          break;
        case r'current_odometer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.currentOdometer = valueDes;
          break;
        case r'operational_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(VehicleStatus),
          ) as VehicleStatus;
          result.operationalStatus = valueDes;
          break;
        case r'status_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.statusReason = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(VehicleType),
          ) as VehicleType;
          result.type.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Vehicle deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VehicleBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class VehicleOwnershipTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'owned')
  static const VehicleOwnershipTypeEnum owned = _$vehicleOwnershipTypeEnum_owned;
  @BuiltValueEnumConst(wireName: r'leased')
  static const VehicleOwnershipTypeEnum leased = _$vehicleOwnershipTypeEnum_leased;
  @BuiltValueEnumConst(wireName: r'vendor')
  static const VehicleOwnershipTypeEnum vendor = _$vehicleOwnershipTypeEnum_vendor;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const VehicleOwnershipTypeEnum unknownDefaultOpenApi = _$vehicleOwnershipTypeEnum_unknownDefaultOpenApi;

  static Serializer<VehicleOwnershipTypeEnum> get serializer => _$vehicleOwnershipTypeEnumSerializer;

  const VehicleOwnershipTypeEnum._(String name): super(name);

  static BuiltSet<VehicleOwnershipTypeEnum> get values => _$vehicleOwnershipTypeEnumValues;
  static VehicleOwnershipTypeEnum valueOf(String name) => _$vehicleOwnershipTypeEnumValueOf(name);
}
