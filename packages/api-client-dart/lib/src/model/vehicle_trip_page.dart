//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/vehicle_trip.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'vehicle_trip_page.g.dart';

/// VehicleTripPage
///
/// Properties:
/// * [data]
/// * [currentPage]
/// * [lastPage]
/// * [total]
@BuiltValue()
abstract class VehicleTripPage implements Built<VehicleTripPage, VehicleTripPageBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<VehicleTrip> get data;

  @BuiltValueField(wireName: r'current_page')
  int get currentPage;

  @BuiltValueField(wireName: r'last_page')
  int get lastPage;

  @BuiltValueField(wireName: r'total')
  int get total;

  VehicleTripPage._();

  factory VehicleTripPage([void updates(VehicleTripPageBuilder b)]) = _$VehicleTripPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VehicleTripPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VehicleTripPage> get serializer => _$VehicleTripPageSerializer();
}

class _$VehicleTripPageSerializer implements PrimitiveSerializer<VehicleTripPage> {
  @override
  final Iterable<Type> types = const [VehicleTripPage, _$VehicleTripPage];

  @override
  final String wireName = r'VehicleTripPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VehicleTripPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(VehicleTrip)]),
    );
    yield r'current_page';
    yield serializers.serialize(
      object.currentPage,
      specifiedType: const FullType(int),
    );
    yield r'last_page';
    yield serializers.serialize(
      object.lastPage,
      specifiedType: const FullType(int),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    VehicleTripPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VehicleTripPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(VehicleTrip)]),
          ) as BuiltList<VehicleTrip>;
          result.data.replace(valueDes);
          break;
        case r'current_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.currentPage = valueDes;
          break;
        case r'last_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lastPage = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  VehicleTripPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VehicleTripPageBuilder();
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
