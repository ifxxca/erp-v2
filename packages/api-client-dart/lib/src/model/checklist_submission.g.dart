// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_submission.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChecklistSubmission extends ChecklistSubmission {
  @override
  final String id;
  @override
  final String checklistTemplateId;
  @override
  final String submittedBy;
  @override
  final DateTime submittedAt;
  @override
  final ChecklistTemplate template;
  @override
  final BuiltList<ChecklistAnswer> answers;

  factory _$ChecklistSubmission(
          [void Function(ChecklistSubmissionBuilder)? updates]) =>
      (ChecklistSubmissionBuilder()..update(updates))._build();

  _$ChecklistSubmission._(
      {required this.id,
      required this.checklistTemplateId,
      required this.submittedBy,
      required this.submittedAt,
      required this.template,
      required this.answers})
      : super._();
  @override
  ChecklistSubmission rebuild(
          void Function(ChecklistSubmissionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChecklistSubmissionBuilder toBuilder() =>
      ChecklistSubmissionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChecklistSubmission &&
        id == other.id &&
        checklistTemplateId == other.checklistTemplateId &&
        submittedBy == other.submittedBy &&
        submittedAt == other.submittedAt &&
        template == other.template &&
        answers == other.answers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, checklistTemplateId.hashCode);
    _$hash = $jc(_$hash, submittedBy.hashCode);
    _$hash = $jc(_$hash, submittedAt.hashCode);
    _$hash = $jc(_$hash, template.hashCode);
    _$hash = $jc(_$hash, answers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChecklistSubmission')
          ..add('id', id)
          ..add('checklistTemplateId', checklistTemplateId)
          ..add('submittedBy', submittedBy)
          ..add('submittedAt', submittedAt)
          ..add('template', template)
          ..add('answers', answers))
        .toString();
  }
}

class ChecklistSubmissionBuilder
    implements Builder<ChecklistSubmission, ChecklistSubmissionBuilder> {
  _$ChecklistSubmission? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _checklistTemplateId;
  String? get checklistTemplateId => _$this._checklistTemplateId;
  set checklistTemplateId(String? checklistTemplateId) =>
      _$this._checklistTemplateId = checklistTemplateId;

  String? _submittedBy;
  String? get submittedBy => _$this._submittedBy;
  set submittedBy(String? submittedBy) => _$this._submittedBy = submittedBy;

  DateTime? _submittedAt;
  DateTime? get submittedAt => _$this._submittedAt;
  set submittedAt(DateTime? submittedAt) => _$this._submittedAt = submittedAt;

  ChecklistTemplateBuilder? _template;
  ChecklistTemplateBuilder get template =>
      _$this._template ??= ChecklistTemplateBuilder();
  set template(ChecklistTemplateBuilder? template) =>
      _$this._template = template;

  ListBuilder<ChecklistAnswer>? _answers;
  ListBuilder<ChecklistAnswer> get answers =>
      _$this._answers ??= ListBuilder<ChecklistAnswer>();
  set answers(ListBuilder<ChecklistAnswer>? answers) =>
      _$this._answers = answers;

  ChecklistSubmissionBuilder() {
    ChecklistSubmission._defaults(this);
  }

  ChecklistSubmissionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _checklistTemplateId = $v.checklistTemplateId;
      _submittedBy = $v.submittedBy;
      _submittedAt = $v.submittedAt;
      _template = $v.template.toBuilder();
      _answers = $v.answers.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChecklistSubmission other) {
    _$v = other as _$ChecklistSubmission;
  }

  @override
  void update(void Function(ChecklistSubmissionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChecklistSubmission build() => _build();

  _$ChecklistSubmission _build() {
    _$ChecklistSubmission _$result;
    try {
      _$result = _$v ??
          _$ChecklistSubmission._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'ChecklistSubmission', 'id'),
            checklistTemplateId: BuiltValueNullFieldError.checkNotNull(
                checklistTemplateId,
                r'ChecklistSubmission',
                'checklistTemplateId'),
            submittedBy: BuiltValueNullFieldError.checkNotNull(
                submittedBy, r'ChecklistSubmission', 'submittedBy'),
            submittedAt: BuiltValueNullFieldError.checkNotNull(
                submittedAt, r'ChecklistSubmission', 'submittedAt'),
            template: template.build(),
            answers: answers.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'template';
        template.build();
        _$failedField = 'answers';
        answers.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ChecklistSubmission', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
