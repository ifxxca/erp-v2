//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_vehicle_request.g.dart';

/// CreateVehicleRequest
///
/// Properties:
/// * [vehicleTypeId]
/// * [code]
/// * [plateNumber]
/// * [brand]
/// * [model]
/// * [modelYear]
/// * [ownershipType]
/// * [providerName]
/// * [currentOdometer]
@BuiltValue()
abstract class CreateVehicleRequest implements Built<CreateVehicleRequest, CreateVehicleRequestBuilder> {
  @BuiltValueField(wireName: r'vehicle_type_id')
  String get vehicleTypeId;

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
  CreateVehicleRequestOwnershipTypeEnum get ownershipType;
  // enum ownershipTypeEnum {  owned,  leased,  vendor,  };

  @BuiltValueField(wireName: r'provider_name')
  String? get providerName;

  @BuiltValueField(wireName: r'current_odometer')
  int get currentOdometer;

  CreateVehicleRequest._();

  factory CreateVehicleRequest([void updates(CreateVehicleRequestBuilder b)]) = _$CreateVehicleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateVehicleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateVehicleRequest> get serializer => _$CreateVehicleRequestSerializer();
}

class _$CreateVehicleRequestSerializer implements PrimitiveSerializer<CreateVehicleRequest> {
  @override
  final Iterable<Type> types = const [CreateVehicleRequest, _$CreateVehicleRequest];

  @override
  final String wireName = r'CreateVehicleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateVehicleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'vehicle_type_id';
    yield serializers.serialize(
      object.vehicleTypeId,
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
    yield r'ownership_type';
    yield serializers.serialize(
      object.ownershipType,
      specifiedType: const FullType(CreateVehicleRequestOwnershipTypeEnum),
    );
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateVehicleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateVehicleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'vehicle_type_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.vehicleTypeId = valueDes;
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
            specifiedType: const FullType(CreateVehicleRequestOwnershipTypeEnum),
          ) as CreateVehicleRequestOwnershipTypeEnum;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateVehicleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateVehicleRequestBuilder();
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

class CreateVehicleRequestOwnershipTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'owned')
  static const CreateVehicleRequestOwnershipTypeEnum owned = _$createVehicleRequestOwnershipTypeEnum_owned;
  @BuiltValueEnumConst(wireName: r'leased')
  static const CreateVehicleRequestOwnershipTypeEnum leased = _$createVehicleRequestOwnershipTypeEnum_leased;
  @BuiltValueEnumConst(wireName: r'vendor')
  static const CreateVehicleRequestOwnershipTypeEnum vendor = _$createVehicleRequestOwnershipTypeEnum_vendor;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateVehicleRequestOwnershipTypeEnum unknownDefaultOpenApi = _$createVehicleRequestOwnershipTypeEnum_unknownDefaultOpenApi;

  static Serializer<CreateVehicleRequestOwnershipTypeEnum> get serializer => _$createVehicleRequestOwnershipTypeEnumSerializer;

  const CreateVehicleRequestOwnershipTypeEnum._(String name): super(name);

  static BuiltSet<CreateVehicleRequestOwnershipTypeEnum> get values => _$createVehicleRequestOwnershipTypeEnumValues;
  static CreateVehicleRequestOwnershipTypeEnum valueOf(String name) => _$createVehicleRequestOwnershipTypeEnumValueOf(name);
}
