//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checklist_template_item.g.dart';

/// ChecklistTemplateItem
///
/// Properties:
/// * [id]
/// * [lineNumber]
/// * [code]
/// * [label]
/// * [isRequired]
/// * [isCritical]
@BuiltValue()
abstract class ChecklistTemplateItem implements Built<ChecklistTemplateItem, ChecklistTemplateItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'line_number')
  int get lineNumber;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'label')
  String get label;

  @BuiltValueField(wireName: r'is_required')
  bool get isRequired;

  @BuiltValueField(wireName: r'is_critical')
  bool get isCritical;

  ChecklistTemplateItem._();

  factory ChecklistTemplateItem([void updates(ChecklistTemplateItemBuilder b)]) = _$ChecklistTemplateItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChecklistTemplateItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChecklistTemplateItem> get serializer => _$ChecklistTemplateItemSerializer();
}

class _$ChecklistTemplateItemSerializer implements PrimitiveSerializer<ChecklistTemplateItem> {
  @override
  final Iterable<Type> types = const [ChecklistTemplateItem, _$ChecklistTemplateItem];

  @override
  final String wireName = r'ChecklistTemplateItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChecklistTemplateItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'line_number';
    yield serializers.serialize(
      object.lineNumber,
      specifiedType: const FullType(int),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'label';
    yield serializers.serialize(
      object.label,
      specifiedType: const FullType(String),
    );
    yield r'is_required';
    yield serializers.serialize(
      object.isRequired,
      specifiedType: const FullType(bool),
    );
    yield r'is_critical';
    yield serializers.serialize(
      object.isCritical,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChecklistTemplateItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChecklistTemplateItemBuilder result,
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
        case r'line_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lineNumber = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.label = valueDes;
          break;
        case r'is_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isRequired = valueDes;
          break;
        case r'is_critical':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isCritical = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChecklistTemplateItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChecklistTemplateItemBuilder();
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
