//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/checklist_template_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checklist_template.g.dart';

/// ChecklistTemplate
///
/// Properties:
/// * [id]
/// * [companyId]
/// * [code]
/// * [name]
/// * [version]
/// * [status]
/// * [items]
@BuiltValue()
abstract class ChecklistTemplate implements Built<ChecklistTemplate, ChecklistTemplateBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'company_id')
  String get companyId;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'status')
  ChecklistTemplateStatusEnum get status;
  // enum statusEnum {  draft,  active,  retired,  };

  @BuiltValueField(wireName: r'items')
  BuiltList<ChecklistTemplateItem> get items;

  ChecklistTemplate._();

  factory ChecklistTemplate([void updates(ChecklistTemplateBuilder b)]) = _$ChecklistTemplate;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChecklistTemplateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChecklistTemplate> get serializer => _$ChecklistTemplateSerializer();
}

class _$ChecklistTemplateSerializer implements PrimitiveSerializer<ChecklistTemplate> {
  @override
  final Iterable<Type> types = const [ChecklistTemplate, _$ChecklistTemplate];

  @override
  final String wireName = r'ChecklistTemplate';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChecklistTemplate object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'company_id';
    yield serializers.serialize(
      object.companyId,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(ChecklistTemplateStatusEnum),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(ChecklistTemplateItem)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChecklistTemplate object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChecklistTemplateBuilder result,
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
        case r'company_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.companyId = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChecklistTemplateStatusEnum),
          ) as ChecklistTemplateStatusEnum;
          result.status = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ChecklistTemplateItem)]),
          ) as BuiltList<ChecklistTemplateItem>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChecklistTemplate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChecklistTemplateBuilder();
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

class ChecklistTemplateStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'draft')
  static const ChecklistTemplateStatusEnum draft = _$checklistTemplateStatusEnum_draft;
  @BuiltValueEnumConst(wireName: r'active')
  static const ChecklistTemplateStatusEnum active = _$checklistTemplateStatusEnum_active;
  @BuiltValueEnumConst(wireName: r'retired')
  static const ChecklistTemplateStatusEnum retired = _$checklistTemplateStatusEnum_retired;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ChecklistTemplateStatusEnum unknownDefaultOpenApi = _$checklistTemplateStatusEnum_unknownDefaultOpenApi;

  static Serializer<ChecklistTemplateStatusEnum> get serializer => _$checklistTemplateStatusEnumSerializer;

  const ChecklistTemplateStatusEnum._(String name): super(name);

  static BuiltSet<ChecklistTemplateStatusEnum> get values => _$checklistTemplateStatusEnumValues;
  static ChecklistTemplateStatusEnum valueOf(String name) => _$checklistTemplateStatusEnumValueOf(name);
}
