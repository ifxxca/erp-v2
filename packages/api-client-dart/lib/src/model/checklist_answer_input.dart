//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checklist_answer_input.g.dart';

/// ChecklistAnswerInput
///
/// Properties:
/// * [itemId]
/// * [result]
/// * [note]
/// * [evidenceFileIds]
@BuiltValue()
abstract class ChecklistAnswerInput implements Built<ChecklistAnswerInput, ChecklistAnswerInputBuilder> {
  @BuiltValueField(wireName: r'item_id')
  String get itemId;

  @BuiltValueField(wireName: r'result')
  ChecklistAnswerInputResultEnum get result;
  // enum resultEnum {  pass,  fail,  not_applicable,  };

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'evidence_file_ids')
  BuiltSet<String>? get evidenceFileIds;

  ChecklistAnswerInput._();

  factory ChecklistAnswerInput([void updates(ChecklistAnswerInputBuilder b)]) = _$ChecklistAnswerInput;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChecklistAnswerInputBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChecklistAnswerInput> get serializer => _$ChecklistAnswerInputSerializer();
}

class _$ChecklistAnswerInputSerializer implements PrimitiveSerializer<ChecklistAnswerInput> {
  @override
  final Iterable<Type> types = const [ChecklistAnswerInput, _$ChecklistAnswerInput];

  @override
  final String wireName = r'ChecklistAnswerInput';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChecklistAnswerInput object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'item_id';
    yield serializers.serialize(
      object.itemId,
      specifiedType: const FullType(String),
    );
    yield r'result';
    yield serializers.serialize(
      object.result,
      specifiedType: const FullType(ChecklistAnswerInputResultEnum),
    );
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.evidenceFileIds != null) {
      yield r'evidence_file_ids';
      yield serializers.serialize(
        object.evidenceFileIds,
        specifiedType: const FullType(BuiltSet, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChecklistAnswerInput object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChecklistAnswerInputBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'item_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.itemId = valueDes;
          break;
        case r'result':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChecklistAnswerInputResultEnum),
          ) as ChecklistAnswerInputResultEnum;
          result.result = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        case r'evidence_file_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>;
          result.evidenceFileIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChecklistAnswerInput deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChecklistAnswerInputBuilder();
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

class ChecklistAnswerInputResultEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pass')
  static const ChecklistAnswerInputResultEnum pass = _$checklistAnswerInputResultEnum_pass;
  @BuiltValueEnumConst(wireName: r'fail')
  static const ChecklistAnswerInputResultEnum fail = _$checklistAnswerInputResultEnum_fail;
  @BuiltValueEnumConst(wireName: r'not_applicable')
  static const ChecklistAnswerInputResultEnum notApplicable = _$checklistAnswerInputResultEnum_notApplicable;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ChecklistAnswerInputResultEnum unknownDefaultOpenApi = _$checklistAnswerInputResultEnum_unknownDefaultOpenApi;

  static Serializer<ChecklistAnswerInputResultEnum> get serializer => _$checklistAnswerInputResultEnumSerializer;

  const ChecklistAnswerInputResultEnum._(String name): super(name);

  static BuiltSet<ChecklistAnswerInputResultEnum> get values => _$checklistAnswerInputResultEnumValues;
  static ChecklistAnswerInputResultEnum valueOf(String name) => _$checklistAnswerInputResultEnumValueOf(name);
}
