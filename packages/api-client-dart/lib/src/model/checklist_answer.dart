//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/checklist_template_item.dart';
import 'package:rajawali_api_client/src/model/checklist_evidence.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checklist_answer.g.dart';

/// ChecklistAnswer
///
/// Properties:
/// * [id]
/// * [checklistTemplateItemId]
/// * [result]
/// * [note]
/// * [item]
/// * [evidenceFiles]
@BuiltValue()
abstract class ChecklistAnswer implements Built<ChecklistAnswer, ChecklistAnswerBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'checklist_template_item_id')
  String get checklistTemplateItemId;

  @BuiltValueField(wireName: r'result')
  ChecklistAnswerResultEnum get result;
  // enum resultEnum {  pass,  fail,  not_applicable,  };

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'item')
  ChecklistTemplateItem get item;

  @BuiltValueField(wireName: r'evidence_files')
  BuiltList<ChecklistEvidence> get evidenceFiles;

  ChecklistAnswer._();

  factory ChecklistAnswer([void updates(ChecklistAnswerBuilder b)]) = _$ChecklistAnswer;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChecklistAnswerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChecklistAnswer> get serializer => _$ChecklistAnswerSerializer();
}

class _$ChecklistAnswerSerializer implements PrimitiveSerializer<ChecklistAnswer> {
  @override
  final Iterable<Type> types = const [ChecklistAnswer, _$ChecklistAnswer];

  @override
  final String wireName = r'ChecklistAnswer';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChecklistAnswer object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'checklist_template_item_id';
    yield serializers.serialize(
      object.checklistTemplateItemId,
      specifiedType: const FullType(String),
    );
    yield r'result';
    yield serializers.serialize(
      object.result,
      specifiedType: const FullType(ChecklistAnswerResultEnum),
    );
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'item';
    yield serializers.serialize(
      object.item,
      specifiedType: const FullType(ChecklistTemplateItem),
    );
    yield r'evidence_files';
    yield serializers.serialize(
      object.evidenceFiles,
      specifiedType: const FullType(BuiltList, [FullType(ChecklistEvidence)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChecklistAnswer object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChecklistAnswerBuilder result,
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
        case r'checklist_template_item_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.checklistTemplateItemId = valueDes;
          break;
        case r'result':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChecklistAnswerResultEnum),
          ) as ChecklistAnswerResultEnum;
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
        case r'item':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChecklistTemplateItem),
          ) as ChecklistTemplateItem;
          result.item.replace(valueDes);
          break;
        case r'evidence_files':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ChecklistEvidence)]),
          ) as BuiltList<ChecklistEvidence>;
          result.evidenceFiles.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChecklistAnswer deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChecklistAnswerBuilder();
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

class ChecklistAnswerResultEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pass')
  static const ChecklistAnswerResultEnum pass = _$checklistAnswerResultEnum_pass;
  @BuiltValueEnumConst(wireName: r'fail')
  static const ChecklistAnswerResultEnum fail = _$checklistAnswerResultEnum_fail;
  @BuiltValueEnumConst(wireName: r'not_applicable')
  static const ChecklistAnswerResultEnum notApplicable = _$checklistAnswerResultEnum_notApplicable;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ChecklistAnswerResultEnum unknownDefaultOpenApi = _$checklistAnswerResultEnum_unknownDefaultOpenApi;

  static Serializer<ChecklistAnswerResultEnum> get serializer => _$checklistAnswerResultEnumSerializer;

  const ChecklistAnswerResultEnum._(String name): super(name);

  static BuiltSet<ChecklistAnswerResultEnum> get values => _$checklistAnswerResultEnumValues;
  static ChecklistAnswerResultEnum valueOf(String name) => _$checklistAnswerResultEnumValueOf(name);
}
