//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/checklist_answer.dart';
import 'package:rajawali_api_client/src/model/checklist_template.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checklist_submission.g.dart';

/// ChecklistSubmission
///
/// Properties:
/// * [id]
/// * [checklistTemplateId]
/// * [submittedBy]
/// * [submittedAt]
/// * [template]
/// * [answers]
@BuiltValue()
abstract class ChecklistSubmission implements Built<ChecklistSubmission, ChecklistSubmissionBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'checklist_template_id')
  String get checklistTemplateId;

  @BuiltValueField(wireName: r'submitted_by')
  String get submittedBy;

  @BuiltValueField(wireName: r'submitted_at')
  DateTime get submittedAt;

  @BuiltValueField(wireName: r'template')
  ChecklistTemplate get template;

  @BuiltValueField(wireName: r'answers')
  BuiltList<ChecklistAnswer> get answers;

  ChecklistSubmission._();

  factory ChecklistSubmission([void updates(ChecklistSubmissionBuilder b)]) = _$ChecklistSubmission;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChecklistSubmissionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChecklistSubmission> get serializer => _$ChecklistSubmissionSerializer();
}

class _$ChecklistSubmissionSerializer implements PrimitiveSerializer<ChecklistSubmission> {
  @override
  final Iterable<Type> types = const [ChecklistSubmission, _$ChecklistSubmission];

  @override
  final String wireName = r'ChecklistSubmission';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChecklistSubmission object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'checklist_template_id';
    yield serializers.serialize(
      object.checklistTemplateId,
      specifiedType: const FullType(String),
    );
    yield r'submitted_by';
    yield serializers.serialize(
      object.submittedBy,
      specifiedType: const FullType(String),
    );
    yield r'submitted_at';
    yield serializers.serialize(
      object.submittedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'template';
    yield serializers.serialize(
      object.template,
      specifiedType: const FullType(ChecklistTemplate),
    );
    yield r'answers';
    yield serializers.serialize(
      object.answers,
      specifiedType: const FullType(BuiltList, [FullType(ChecklistAnswer)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChecklistSubmission object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChecklistSubmissionBuilder result,
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
        case r'checklist_template_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.checklistTemplateId = valueDes;
          break;
        case r'submitted_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.submittedBy = valueDes;
          break;
        case r'submitted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.submittedAt = valueDes;
          break;
        case r'template':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChecklistTemplate),
          ) as ChecklistTemplate;
          result.template.replace(valueDes);
          break;
        case r'answers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ChecklistAnswer)]),
          ) as BuiltList<ChecklistAnswer>;
          result.answers.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChecklistSubmission deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChecklistSubmissionBuilder();
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
