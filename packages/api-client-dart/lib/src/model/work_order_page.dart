//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/maintenance_work_order.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'work_order_page.g.dart';

/// WorkOrderPage
///
/// Properties:
/// * [data]
/// * [currentPage]
/// * [lastPage]
/// * [total]
@BuiltValue()
abstract class WorkOrderPage implements Built<WorkOrderPage, WorkOrderPageBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<MaintenanceWorkOrder> get data;

  @BuiltValueField(wireName: r'current_page')
  int get currentPage;

  @BuiltValueField(wireName: r'last_page')
  int get lastPage;

  @BuiltValueField(wireName: r'total')
  int get total;

  WorkOrderPage._();

  factory WorkOrderPage([void updates(WorkOrderPageBuilder b)]) = _$WorkOrderPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkOrderPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkOrderPage> get serializer => _$WorkOrderPageSerializer();
}

class _$WorkOrderPageSerializer implements PrimitiveSerializer<WorkOrderPage> {
  @override
  final Iterable<Type> types = const [WorkOrderPage, _$WorkOrderPage];

  @override
  final String wireName = r'WorkOrderPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkOrderPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(MaintenanceWorkOrder)]),
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
    WorkOrderPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WorkOrderPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MaintenanceWorkOrder)]),
          ) as BuiltList<MaintenanceWorkOrder>;
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
  WorkOrderPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkOrderPageBuilder();
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
