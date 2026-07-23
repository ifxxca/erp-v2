// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_answer_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChecklistAnswerInputResultEnum _$checklistAnswerInputResultEnum_pass =
    const ChecklistAnswerInputResultEnum._('pass');
const ChecklistAnswerInputResultEnum _$checklistAnswerInputResultEnum_fail =
    const ChecklistAnswerInputResultEnum._('fail');
const ChecklistAnswerInputResultEnum
    _$checklistAnswerInputResultEnum_notApplicable =
    const ChecklistAnswerInputResultEnum._('notApplicable');
const ChecklistAnswerInputResultEnum
    _$checklistAnswerInputResultEnum_unknownDefaultOpenApi =
    const ChecklistAnswerInputResultEnum._('unknownDefaultOpenApi');

ChecklistAnswerInputResultEnum _$checklistAnswerInputResultEnumValueOf(
    String name) {
  switch (name) {
    case 'pass':
      return _$checklistAnswerInputResultEnum_pass;
    case 'fail':
      return _$checklistAnswerInputResultEnum_fail;
    case 'notApplicable':
      return _$checklistAnswerInputResultEnum_notApplicable;
    case 'unknownDefaultOpenApi':
      return _$checklistAnswerInputResultEnum_unknownDefaultOpenApi;
    default:
      return _$checklistAnswerInputResultEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ChecklistAnswerInputResultEnum>
    _$checklistAnswerInputResultEnumValues = BuiltSet<
        ChecklistAnswerInputResultEnum>(const <ChecklistAnswerInputResultEnum>[
  _$checklistAnswerInputResultEnum_pass,
  _$checklistAnswerInputResultEnum_fail,
  _$checklistAnswerInputResultEnum_notApplicable,
  _$checklistAnswerInputResultEnum_unknownDefaultOpenApi,
]);

Serializer<ChecklistAnswerInputResultEnum>
    _$checklistAnswerInputResultEnumSerializer =
    _$ChecklistAnswerInputResultEnumSerializer();

class _$ChecklistAnswerInputResultEnumSerializer
    implements PrimitiveSerializer<ChecklistAnswerInputResultEnum> {
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
  final Iterable<Type> types = const <Type>[ChecklistAnswerInputResultEnum];
  @override
  final String wireName = 'ChecklistAnswerInputResultEnum';

  @override
  Object serialize(
          Serializers serializers, ChecklistAnswerInputResultEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ChecklistAnswerInputResultEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ChecklistAnswerInputResultEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ChecklistAnswerInput extends ChecklistAnswerInput {
  @override
  final String itemId;
  @override
  final ChecklistAnswerInputResultEnum result;
  @override
  final String? note;
  @override
  final BuiltSet<String>? evidenceFileIds;

  factory _$ChecklistAnswerInput(
          [void Function(ChecklistAnswerInputBuilder)? updates]) =>
      (ChecklistAnswerInputBuilder()..update(updates))._build();

  _$ChecklistAnswerInput._(
      {required this.itemId,
      required this.result,
      this.note,
      this.evidenceFileIds})
      : super._();
  @override
  ChecklistAnswerInput rebuild(
          void Function(ChecklistAnswerInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChecklistAnswerInputBuilder toBuilder() =>
      ChecklistAnswerInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChecklistAnswerInput &&
        itemId == other.itemId &&
        result == other.result &&
        note == other.note &&
        evidenceFileIds == other.evidenceFileIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, itemId.hashCode);
    _$hash = $jc(_$hash, result.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, evidenceFileIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChecklistAnswerInput')
          ..add('itemId', itemId)
          ..add('result', result)
          ..add('note', note)
          ..add('evidenceFileIds', evidenceFileIds))
        .toString();
  }
}

class ChecklistAnswerInputBuilder
    implements Builder<ChecklistAnswerInput, ChecklistAnswerInputBuilder> {
  _$ChecklistAnswerInput? _$v;

  String? _itemId;
  String? get itemId => _$this._itemId;
  set itemId(String? itemId) => _$this._itemId = itemId;

  ChecklistAnswerInputResultEnum? _result;
  ChecklistAnswerInputResultEnum? get result => _$this._result;
  set result(ChecklistAnswerInputResultEnum? result) => _$this._result = result;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  SetBuilder<String>? _evidenceFileIds;
  SetBuilder<String> get evidenceFileIds =>
      _$this._evidenceFileIds ??= SetBuilder<String>();
  set evidenceFileIds(SetBuilder<String>? evidenceFileIds) =>
      _$this._evidenceFileIds = evidenceFileIds;

  ChecklistAnswerInputBuilder() {
    ChecklistAnswerInput._defaults(this);
  }

  ChecklistAnswerInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _itemId = $v.itemId;
      _result = $v.result;
      _note = $v.note;
      _evidenceFileIds = $v.evidenceFileIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChecklistAnswerInput other) {
    _$v = other as _$ChecklistAnswerInput;
  }

  @override
  void update(void Function(ChecklistAnswerInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChecklistAnswerInput build() => _build();

  _$ChecklistAnswerInput _build() {
    _$ChecklistAnswerInput _$result;
    try {
      _$result = _$v ??
          _$ChecklistAnswerInput._(
            itemId: BuiltValueNullFieldError.checkNotNull(
                itemId, r'ChecklistAnswerInput', 'itemId'),
            result: BuiltValueNullFieldError.checkNotNull(
                result, r'ChecklistAnswerInput', 'result'),
            note: note,
            evidenceFileIds: _evidenceFileIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'evidenceFileIds';
        _evidenceFileIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ChecklistAnswerInput', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
