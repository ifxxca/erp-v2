//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_work_order_request_jobs_inner.g.dart';

/// CreateWorkOrderRequestJobsInner
///
/// Properties:
/// * [description]
/// * [laborCost]
/// * [note]
@BuiltValue()
abstract class CreateWorkOrderRequestJobsInner implements Built<CreateWorkOrderRequestJobsInner, CreateWorkOrderRequestJobsInnerBuilder> {
  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'labor_cost')
  num get laborCost;

  @BuiltValueField(wireName: r'note')
  String? get note;

  CreateWorkOrderRequestJobsInner._();

  factory CreateWorkOrderRequestJobsInner([void updates(CreateWorkOrderRequestJobsInnerBuilder b)]) = _$CreateWorkOrderRequestJobsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateWorkOrderRequestJobsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateWorkOrderRequestJobsInner> get serializer => _$CreateWorkOrderRequestJobsInnerSerializer();
}

class _$CreateWorkOrderRequestJobsInnerSerializer implements PrimitiveSerializer<CreateWorkOrderRequestJobsInner> {
  @override
  final Iterable<Type> types = const [CreateWorkOrderRequestJobsInner, _$CreateWorkOrderRequestJobsInner];

  @override
  final String wireName = r'CreateWorkOrderRequestJobsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateWorkOrderRequestJobsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    yield r'labor_cost';
    yield serializers.serialize(
      object.laborCost,
      specifiedType: const FullType(num),
    );
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateWorkOrderRequestJobsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateWorkOrderRequestJobsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'labor_cost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.laborCost = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateWorkOrderRequestJobsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateWorkOrderRequestJobsInnerBuilder();
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
