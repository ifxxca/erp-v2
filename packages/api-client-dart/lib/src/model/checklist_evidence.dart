//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checklist_evidence.g.dart';

/// ChecklistEvidence
///
/// Properties:
/// * [id]
/// * [attachedId]
/// * [originalName]
/// * [declaredMimeType]
/// * [detectedMimeType]
/// * [expectedSize]
/// * [actualSize]
/// * [status]
/// * [scanStatus]
/// * [createdAt]
@BuiltValue()
abstract class ChecklistEvidence implements Built<ChecklistEvidence, ChecklistEvidenceBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'attached_id')
  String get attachedId;

  @BuiltValueField(wireName: r'original_name')
  String get originalName;

  @BuiltValueField(wireName: r'declared_mime_type')
  String? get declaredMimeType;

  @BuiltValueField(wireName: r'detected_mime_type')
  String? get detectedMimeType;

  @BuiltValueField(wireName: r'expected_size')
  int? get expectedSize;

  @BuiltValueField(wireName: r'actual_size')
  int? get actualSize;

  @BuiltValueField(wireName: r'status')
  JsonObject? get status;

  @BuiltValueField(wireName: r'scan_status')
  ChecklistEvidenceScanStatusEnum get scanStatus;
  // enum scanStatusEnum {  clean,  skipped,  };

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  ChecklistEvidence._();

  factory ChecklistEvidence([void updates(ChecklistEvidenceBuilder b)]) = _$ChecklistEvidence;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChecklistEvidenceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChecklistEvidence> get serializer => _$ChecklistEvidenceSerializer();
}

class _$ChecklistEvidenceSerializer implements PrimitiveSerializer<ChecklistEvidence> {
  @override
  final Iterable<Type> types = const [ChecklistEvidence, _$ChecklistEvidence];

  @override
  final String wireName = r'ChecklistEvidence';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChecklistEvidence object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'attached_id';
    yield serializers.serialize(
      object.attachedId,
      specifiedType: const FullType(String),
    );
    yield r'original_name';
    yield serializers.serialize(
      object.originalName,
      specifiedType: const FullType(String),
    );
    if (object.declaredMimeType != null) {
      yield r'declared_mime_type';
      yield serializers.serialize(
        object.declaredMimeType,
        specifiedType: const FullType(String),
      );
    }
    if (object.detectedMimeType != null) {
      yield r'detected_mime_type';
      yield serializers.serialize(
        object.detectedMimeType,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.expectedSize != null) {
      yield r'expected_size';
      yield serializers.serialize(
        object.expectedSize,
        specifiedType: const FullType(int),
      );
    }
    if (object.actualSize != null) {
      yield r'actual_size';
      yield serializers.serialize(
        object.actualSize,
        specifiedType: const FullType.nullable(int),
      );
    }
    yield r'status';
    yield object.status == null ? null : serializers.serialize(
      object.status,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'scan_status';
    yield serializers.serialize(
      object.scanStatus,
      specifiedType: const FullType(ChecklistEvidenceScanStatusEnum),
    );
    if (object.createdAt != null) {
      yield r'created_at';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChecklistEvidence object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChecklistEvidenceBuilder result,
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
        case r'attached_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.attachedId = valueDes;
          break;
        case r'original_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.originalName = valueDes;
          break;
        case r'declared_mime_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.declaredMimeType = valueDes;
          break;
        case r'detected_mime_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.detectedMimeType = valueDes;
          break;
        case r'expected_size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.expectedSize = valueDes;
          break;
        case r'actual_size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.actualSize = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'scan_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChecklistEvidenceScanStatusEnum),
          ) as ChecklistEvidenceScanStatusEnum;
          result.scanStatus = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChecklistEvidence deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChecklistEvidenceBuilder();
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

class ChecklistEvidenceScanStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'clean')
  static const ChecklistEvidenceScanStatusEnum clean = _$checklistEvidenceScanStatusEnum_clean;
  @BuiltValueEnumConst(wireName: r'skipped')
  static const ChecklistEvidenceScanStatusEnum skipped = _$checklistEvidenceScanStatusEnum_skipped;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ChecklistEvidenceScanStatusEnum unknownDefaultOpenApi = _$checklistEvidenceScanStatusEnum_unknownDefaultOpenApi;

  static Serializer<ChecklistEvidenceScanStatusEnum> get serializer => _$checklistEvidenceScanStatusEnumSerializer;

  const ChecklistEvidenceScanStatusEnum._(String name): super(name);

  static BuiltSet<ChecklistEvidenceScanStatusEnum> get values => _$checklistEvidenceScanStatusEnumValues;
  static ChecklistEvidenceScanStatusEnum valueOf(String name) => _$checklistEvidenceScanStatusEnumValueOf(name);
}
