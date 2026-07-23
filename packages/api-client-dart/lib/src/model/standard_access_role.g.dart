// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_access_role.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const StandardAccessRoleAssignmentScopeEnum
    _$standardAccessRoleAssignmentScopeEnum_company =
    const StandardAccessRoleAssignmentScopeEnum._('company');
const StandardAccessRoleAssignmentScopeEnum
    _$standardAccessRoleAssignmentScopeEnum_department =
    const StandardAccessRoleAssignmentScopeEnum._('department');
const StandardAccessRoleAssignmentScopeEnum
    _$standardAccessRoleAssignmentScopeEnum_location =
    const StandardAccessRoleAssignmentScopeEnum._('location');
const StandardAccessRoleAssignmentScopeEnum
    _$standardAccessRoleAssignmentScopeEnum_unknownDefaultOpenApi =
    const StandardAccessRoleAssignmentScopeEnum._('unknownDefaultOpenApi');

StandardAccessRoleAssignmentScopeEnum
    _$standardAccessRoleAssignmentScopeEnumValueOf(String name) {
  switch (name) {
    case 'company':
      return _$standardAccessRoleAssignmentScopeEnum_company;
    case 'department':
      return _$standardAccessRoleAssignmentScopeEnum_department;
    case 'location':
      return _$standardAccessRoleAssignmentScopeEnum_location;
    case 'unknownDefaultOpenApi':
      return _$standardAccessRoleAssignmentScopeEnum_unknownDefaultOpenApi;
    default:
      return _$standardAccessRoleAssignmentScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<StandardAccessRoleAssignmentScopeEnum>
    _$standardAccessRoleAssignmentScopeEnumValues = BuiltSet<
        StandardAccessRoleAssignmentScopeEnum>(const <StandardAccessRoleAssignmentScopeEnum>[
  _$standardAccessRoleAssignmentScopeEnum_company,
  _$standardAccessRoleAssignmentScopeEnum_department,
  _$standardAccessRoleAssignmentScopeEnum_location,
  _$standardAccessRoleAssignmentScopeEnum_unknownDefaultOpenApi,
]);

Serializer<StandardAccessRoleAssignmentScopeEnum>
    _$standardAccessRoleAssignmentScopeEnumSerializer =
    _$StandardAccessRoleAssignmentScopeEnumSerializer();

class _$StandardAccessRoleAssignmentScopeEnumSerializer
    implements PrimitiveSerializer<StandardAccessRoleAssignmentScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'company': 'company',
    'department': 'department',
    'location': 'location',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'company': 'company',
    'department': 'department',
    'location': 'location',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    StandardAccessRoleAssignmentScopeEnum
  ];
  @override
  final String wireName = 'StandardAccessRoleAssignmentScopeEnum';

  @override
  Object serialize(
          Serializers serializers, StandardAccessRoleAssignmentScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  StandardAccessRoleAssignmentScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      StandardAccessRoleAssignmentScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$StandardAccessRole extends StandardAccessRole {
  @override
  final String? description;
  @override
  final StandardAccessRoleAssignmentScopeEnum assignmentScope;
  @override
  final String id;
  @override
  final String code;
  @override
  final String name;

  factory _$StandardAccessRole(
          [void Function(StandardAccessRoleBuilder)? updates]) =>
      (StandardAccessRoleBuilder()..update(updates))._build();

  _$StandardAccessRole._(
      {this.description,
      required this.assignmentScope,
      required this.id,
      required this.code,
      required this.name})
      : super._();
  @override
  StandardAccessRole rebuild(
          void Function(StandardAccessRoleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StandardAccessRoleBuilder toBuilder() =>
      StandardAccessRoleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StandardAccessRole &&
        description == other.description &&
        assignmentScope == other.assignmentScope &&
        id == other.id &&
        code == other.code &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, assignmentScope.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StandardAccessRole')
          ..add('description', description)
          ..add('assignmentScope', assignmentScope)
          ..add('id', id)
          ..add('code', code)
          ..add('name', name))
        .toString();
  }
}

class StandardAccessRoleBuilder
    implements
        Builder<StandardAccessRole, StandardAccessRoleBuilder>,
        RoleSummaryBuilder {
  _$StandardAccessRole? _$v;

  String? _description;
  String? get description => _$this._description;
  set description(covariant String? description) =>
      _$this._description = description;

  StandardAccessRoleAssignmentScopeEnum? _assignmentScope;
  StandardAccessRoleAssignmentScopeEnum? get assignmentScope =>
      _$this._assignmentScope;
  set assignmentScope(
          covariant StandardAccessRoleAssignmentScopeEnum? assignmentScope) =>
      _$this._assignmentScope = assignmentScope;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(covariant String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(covariant String? name) => _$this._name = name;

  StandardAccessRoleBuilder() {
    StandardAccessRole._defaults(this);
  }

  StandardAccessRoleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _description = $v.description;
      _assignmentScope = $v.assignmentScope;
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant StandardAccessRole other) {
    _$v = other as _$StandardAccessRole;
  }

  @override
  void update(void Function(StandardAccessRoleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StandardAccessRole build() => _build();

  _$StandardAccessRole _build() {
    final _$result = _$v ??
        _$StandardAccessRole._(
          description: description,
          assignmentScope: BuiltValueNullFieldError.checkNotNull(
              assignmentScope, r'StandardAccessRole', 'assignmentScope'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'StandardAccessRole', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'StandardAccessRole', 'code'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'StandardAccessRole', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
