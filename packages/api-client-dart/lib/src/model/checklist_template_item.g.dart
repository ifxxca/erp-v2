// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_template_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChecklistTemplateItem extends ChecklistTemplateItem {
  @override
  final String id;
  @override
  final int lineNumber;
  @override
  final String code;
  @override
  final String label;
  @override
  final bool isRequired;
  @override
  final bool isCritical;

  factory _$ChecklistTemplateItem(
          [void Function(ChecklistTemplateItemBuilder)? updates]) =>
      (ChecklistTemplateItemBuilder()..update(updates))._build();

  _$ChecklistTemplateItem._(
      {required this.id,
      required this.lineNumber,
      required this.code,
      required this.label,
      required this.isRequired,
      required this.isCritical})
      : super._();
  @override
  ChecklistTemplateItem rebuild(
          void Function(ChecklistTemplateItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChecklistTemplateItemBuilder toBuilder() =>
      ChecklistTemplateItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChecklistTemplateItem &&
        id == other.id &&
        lineNumber == other.lineNumber &&
        code == other.code &&
        label == other.label &&
        isRequired == other.isRequired &&
        isCritical == other.isCritical;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, lineNumber.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, isRequired.hashCode);
    _$hash = $jc(_$hash, isCritical.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChecklistTemplateItem')
          ..add('id', id)
          ..add('lineNumber', lineNumber)
          ..add('code', code)
          ..add('label', label)
          ..add('isRequired', isRequired)
          ..add('isCritical', isCritical))
        .toString();
  }
}

class ChecklistTemplateItemBuilder
    implements Builder<ChecklistTemplateItem, ChecklistTemplateItemBuilder> {
  _$ChecklistTemplateItem? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  int? _lineNumber;
  int? get lineNumber => _$this._lineNumber;
  set lineNumber(int? lineNumber) => _$this._lineNumber = lineNumber;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  bool? _isRequired;
  bool? get isRequired => _$this._isRequired;
  set isRequired(bool? isRequired) => _$this._isRequired = isRequired;

  bool? _isCritical;
  bool? get isCritical => _$this._isCritical;
  set isCritical(bool? isCritical) => _$this._isCritical = isCritical;

  ChecklistTemplateItemBuilder() {
    ChecklistTemplateItem._defaults(this);
  }

  ChecklistTemplateItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _lineNumber = $v.lineNumber;
      _code = $v.code;
      _label = $v.label;
      _isRequired = $v.isRequired;
      _isCritical = $v.isCritical;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChecklistTemplateItem other) {
    _$v = other as _$ChecklistTemplateItem;
  }

  @override
  void update(void Function(ChecklistTemplateItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChecklistTemplateItem build() => _build();

  _$ChecklistTemplateItem _build() {
    final _$result = _$v ??
        _$ChecklistTemplateItem._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'ChecklistTemplateItem', 'id'),
          lineNumber: BuiltValueNullFieldError.checkNotNull(
              lineNumber, r'ChecklistTemplateItem', 'lineNumber'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'ChecklistTemplateItem', 'code'),
          label: BuiltValueNullFieldError.checkNotNull(
              label, r'ChecklistTemplateItem', 'label'),
          isRequired: BuiltValueNullFieldError.checkNotNull(
              isRequired, r'ChecklistTemplateItem', 'isRequired'),
          isCritical: BuiltValueNullFieldError.checkNotNull(
              isCritical, r'ChecklistTemplateItem', 'isCritical'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
