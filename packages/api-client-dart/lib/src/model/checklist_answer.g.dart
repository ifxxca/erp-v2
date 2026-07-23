// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_answer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChecklistAnswerResultEnum _$checklistAnswerResultEnum_pass =
    const ChecklistAnswerResultEnum._('pass');
const ChecklistAnswerResultEnum _$checklistAnswerResultEnum_fail =
    const ChecklistAnswerResultEnum._('fail');
const ChecklistAnswerResultEnum _$checklistAnswerResultEnum_notApplicable =
    const ChecklistAnswerResultEnum._('notApplicable');
const ChecklistAnswerResultEnum
    _$checklistAnswerResultEnum_unknownDefaultOpenApi =
    const ChecklistAnswerResultEnum._('unknownDefaultOpenApi');

ChecklistAnswerResultEnum _$checklistAnswerResultEnumValueOf(String name) {
  switch (name) {
    case 'pass':
      return _$checklistAnswerResultEnum_pass;
    case 'fail':
      return _$checklistAnswerResultEnum_fail;
    case 'notApplicable':
      return _$checklistAnswerResultEnum_notApplicable;
    case 'unknownDefaultOpenApi':
      return _$checklistAnswerResultEnum_unknownDefaultOpenApi;
    default:
      return _$checklistAnswerResultEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ChecklistAnswerResultEnum> _$checklistAnswerResultEnumValues =
    BuiltSet<ChecklistAnswerResultEnum>(const <ChecklistAnswerResultEnum>[
  _$checklistAnswerResultEnum_pass,
  _$checklistAnswerResultEnum_fail,
  _$checklistAnswerResultEnum_notApplicable,
  _$checklistAnswerResultEnum_unknownDefaultOpenApi,
]);

Serializer<ChecklistAnswerResultEnum> _$checklistAnswerResultEnumSerializer =
    _$ChecklistAnswerResultEnumSerializer();

class _$ChecklistAnswerResultEnumSerializer
    implements PrimitiveSerializer<ChecklistAnswerResultEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pass': 'pass',
    'fail': 'fail',
    'notApplicable': 'not_applicable',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pass': 'pass',
    'fail': 'fail',
    'not_applicable': 'notApplicable',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ChecklistAnswerResultEnum];
  @override
  final String wireName = 'ChecklistAnswerResultEnum';

  @override
  Object serialize(Serializers serializers, ChecklistAnswerResultEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ChecklistAnswerResultEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ChecklistAnswerResultEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ChecklistAnswer extends ChecklistAnswer {
  @override
  final String id;
  @override
  final String checklistTemplateItemId;
  @override
  final ChecklistAnswerResultEnum result;
  @override
  final String? note;
  @override
  final ChecklistTemplateItem item;
  @override
  final BuiltList<ChecklistEvidence> evidenceFiles;

  factory _$ChecklistAnswer([void Function(ChecklistAnswerBuilder)? updates]) =>
      (ChecklistAnswerBuilder()..update(updates))._build();

  _$ChecklistAnswer._(
      {required this.id,
      required this.checklistTemplateItemId,
      required this.result,
      this.note,
      required this.item,
      required this.evidenceFiles})
      : super._();
  @override
  ChecklistAnswer rebuild(void Function(ChecklistAnswerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChecklistAnswerBuilder toBuilder() => ChecklistAnswerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChecklistAnswer &&
        id == other.id &&
        checklistTemplateItemId == other.checklistTemplateItemId &&
        result == other.result &&
        note == other.note &&
        item == other.item &&
        evidenceFiles == other.evidenceFiles;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, checklistTemplateItemId.hashCode);
    _$hash = $jc(_$hash, result.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, item.hashCode);
    _$hash = $jc(_$hash, evidenceFiles.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChecklistAnswer')
          ..add('id', id)
          ..add('checklistTemplateItemId', checklistTemplateItemId)
          ..add('result', result)
          ..add('note', note)
          ..add('item', item)
          ..add('evidenceFiles', evidenceFiles))
        .toString();
  }
}

class ChecklistAnswerBuilder
    implements Builder<ChecklistAnswer, ChecklistAnswerBuilder> {
  _$ChecklistAnswer? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _checklistTemplateItemId;
  String? get checklistTemplateItemId => _$this._checklistTemplateItemId;
  set checklistTemplateItemId(String? checklistTemplateItemId) =>
      _$this._checklistTemplateItemId = checklistTemplateItemId;

  ChecklistAnswerResultEnum? _result;
  ChecklistAnswerResultEnum? get result => _$this._result;
  set result(ChecklistAnswerResultEnum? result) => _$this._result = result;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  ChecklistTemplateItemBuilder? _item;
  ChecklistTemplateItemBuilder get item =>
      _$this._item ??= ChecklistTemplateItemBuilder();
  set item(ChecklistTemplateItemBuilder? item) => _$this._item = item;

  ListBuilder<ChecklistEvidence>? _evidenceFiles;
  ListBuilder<ChecklistEvidence> get evidenceFiles =>
      _$this._evidenceFiles ??= ListBuilder<ChecklistEvidence>();
  set evidenceFiles(ListBuilder<ChecklistEvidence>? evidenceFiles) =>
      _$this._evidenceFiles = evidenceFiles;

  ChecklistAnswerBuilder() {
    ChecklistAnswer._defaults(this);
  }

  ChecklistAnswerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _checklistTemplateItemId = $v.checklistTemplateItemId;
      _result = $v.result;
      _note = $v.note;
      _item = $v.item.toBuilder();
      _evidenceFiles = $v.evidenceFiles.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChecklistAnswer other) {
    _$v = other as _$ChecklistAnswer;
  }

  @override
  void update(void Function(ChecklistAnswerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChecklistAnswer build() => _build();

  _$ChecklistAnswer _build() {
    _$ChecklistAnswer _$result;
    try {
      _$result = _$v ??
          _$ChecklistAnswer._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'ChecklistAnswer', 'id'),
            checklistTemplateItemId: BuiltValueNullFieldError.checkNotNull(
                checklistTemplateItemId,
                r'ChecklistAnswer',
                'checklistTemplateItemId'),
            result: BuiltValueNullFieldError.checkNotNull(
                result, r'ChecklistAnswer', 'result'),
            note: note,
            item: item.build(),
            evidenceFiles: evidenceFiles.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'item';
        item.build();
        _$failedField = 'evidenceFiles';
        evidenceFiles.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ChecklistAnswer', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
