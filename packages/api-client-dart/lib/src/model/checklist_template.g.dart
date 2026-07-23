// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_template.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChecklistTemplateStatusEnum _$checklistTemplateStatusEnum_draft =
    const ChecklistTemplateStatusEnum._('draft');
const ChecklistTemplateStatusEnum _$checklistTemplateStatusEnum_active =
    const ChecklistTemplateStatusEnum._('active');
const ChecklistTemplateStatusEnum _$checklistTemplateStatusEnum_retired =
    const ChecklistTemplateStatusEnum._('retired');
const ChecklistTemplateStatusEnum
    _$checklistTemplateStatusEnum_unknownDefaultOpenApi =
    const ChecklistTemplateStatusEnum._('unknownDefaultOpenApi');

ChecklistTemplateStatusEnum _$checklistTemplateStatusEnumValueOf(String name) {
  switch (name) {
    case 'draft':
      return _$checklistTemplateStatusEnum_draft;
    case 'active':
      return _$checklistTemplateStatusEnum_active;
    case 'retired':
      return _$checklistTemplateStatusEnum_retired;
    case 'unknownDefaultOpenApi':
      return _$checklistTemplateStatusEnum_unknownDefaultOpenApi;
    default:
      return _$checklistTemplateStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ChecklistTemplateStatusEnum>
    _$checklistTemplateStatusEnumValues =
    BuiltSet<ChecklistTemplateStatusEnum>(const <ChecklistTemplateStatusEnum>[
  _$checklistTemplateStatusEnum_draft,
  _$checklistTemplateStatusEnum_active,
  _$checklistTemplateStatusEnum_retired,
  _$checklistTemplateStatusEnum_unknownDefaultOpenApi,
]);

Serializer<ChecklistTemplateStatusEnum>
    _$checklistTemplateStatusEnumSerializer =
    _$ChecklistTemplateStatusEnumSerializer();

class _$ChecklistTemplateStatusEnumSerializer
    implements PrimitiveSerializer<ChecklistTemplateStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'draft': 'draft',
    'active': 'active',
    'retired': 'retired',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'draft': 'draft',
    'active': 'active',
    'retired': 'retired',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ChecklistTemplateStatusEnum];
  @override
  final String wireName = 'ChecklistTemplateStatusEnum';

  @override
  Object serialize(Serializers serializers, ChecklistTemplateStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ChecklistTemplateStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ChecklistTemplateStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ChecklistTemplate extends ChecklistTemplate {
  @override
  final String id;
  @override
  final String companyId;
  @override
  final String code;
  @override
  final String name;
  @override
  final int version;
  @override
  final ChecklistTemplateStatusEnum status;
  @override
  final BuiltList<ChecklistTemplateItem> items;

  factory _$ChecklistTemplate(
          [void Function(ChecklistTemplateBuilder)? updates]) =>
      (ChecklistTemplateBuilder()..update(updates))._build();

  _$ChecklistTemplate._(
      {required this.id,
      required this.companyId,
      required this.code,
      required this.name,
      required this.version,
      required this.status,
      required this.items})
      : super._();
  @override
  ChecklistTemplate rebuild(void Function(ChecklistTemplateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChecklistTemplateBuilder toBuilder() =>
      ChecklistTemplateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChecklistTemplate &&
        id == other.id &&
        companyId == other.companyId &&
        code == other.code &&
        name == other.name &&
        version == other.version &&
        status == other.status &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, companyId.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChecklistTemplate')
          ..add('id', id)
          ..add('companyId', companyId)
          ..add('code', code)
          ..add('name', name)
          ..add('version', version)
          ..add('status', status)
          ..add('items', items))
        .toString();
  }
}

class ChecklistTemplateBuilder
    implements Builder<ChecklistTemplate, ChecklistTemplateBuilder> {
  _$ChecklistTemplate? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _companyId;
  String? get companyId => _$this._companyId;
  set companyId(String? companyId) => _$this._companyId = companyId;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  ChecklistTemplateStatusEnum? _status;
  ChecklistTemplateStatusEnum? get status => _$this._status;
  set status(ChecklistTemplateStatusEnum? status) => _$this._status = status;

  ListBuilder<ChecklistTemplateItem>? _items;
  ListBuilder<ChecklistTemplateItem> get items =>
      _$this._items ??= ListBuilder<ChecklistTemplateItem>();
  set items(ListBuilder<ChecklistTemplateItem>? items) => _$this._items = items;

  ChecklistTemplateBuilder() {
    ChecklistTemplate._defaults(this);
  }

  ChecklistTemplateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _companyId = $v.companyId;
      _code = $v.code;
      _name = $v.name;
      _version = $v.version;
      _status = $v.status;
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChecklistTemplate other) {
    _$v = other as _$ChecklistTemplate;
  }

  @override
  void update(void Function(ChecklistTemplateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChecklistTemplate build() => _build();

  _$ChecklistTemplate _build() {
    _$ChecklistTemplate _$result;
    try {
      _$result = _$v ??
          _$ChecklistTemplate._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'ChecklistTemplate', 'id'),
            companyId: BuiltValueNullFieldError.checkNotNull(
                companyId, r'ChecklistTemplate', 'companyId'),
            code: BuiltValueNullFieldError.checkNotNull(
                code, r'ChecklistTemplate', 'code'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'ChecklistTemplate', 'name'),
            version: BuiltValueNullFieldError.checkNotNull(
                version, r'ChecklistTemplate', 'version'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'ChecklistTemplate', 'status'),
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ChecklistTemplate', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
