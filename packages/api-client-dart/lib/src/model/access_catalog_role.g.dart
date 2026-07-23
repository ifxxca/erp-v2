// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_catalog_role.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccessCatalogRoleAssignmentScopeEnum
    _$accessCatalogRoleAssignmentScopeEnum_company =
    const AccessCatalogRoleAssignmentScopeEnum._('company');
const AccessCatalogRoleAssignmentScopeEnum
    _$accessCatalogRoleAssignmentScopeEnum_department =
    const AccessCatalogRoleAssignmentScopeEnum._('department');
const AccessCatalogRoleAssignmentScopeEnum
    _$accessCatalogRoleAssignmentScopeEnum_location =
    const AccessCatalogRoleAssignmentScopeEnum._('location');
const AccessCatalogRoleAssignmentScopeEnum
    _$accessCatalogRoleAssignmentScopeEnum_unknownDefaultOpenApi =
    const AccessCatalogRoleAssignmentScopeEnum._('unknownDefaultOpenApi');

AccessCatalogRoleAssignmentScopeEnum
    _$accessCatalogRoleAssignmentScopeEnumValueOf(String name) {
  switch (name) {
    case 'company':
      return _$accessCatalogRoleAssignmentScopeEnum_company;
    case 'department':
      return _$accessCatalogRoleAssignmentScopeEnum_department;
    case 'location':
      return _$accessCatalogRoleAssignmentScopeEnum_location;
    case 'unknownDefaultOpenApi':
      return _$accessCatalogRoleAssignmentScopeEnum_unknownDefaultOpenApi;
    default:
      return _$accessCatalogRoleAssignmentScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AccessCatalogRoleAssignmentScopeEnum>
    _$accessCatalogRoleAssignmentScopeEnumValues = BuiltSet<
        AccessCatalogRoleAssignmentScopeEnum>(const <AccessCatalogRoleAssignmentScopeEnum>[
  _$accessCatalogRoleAssignmentScopeEnum_company,
  _$accessCatalogRoleAssignmentScopeEnum_department,
  _$accessCatalogRoleAssignmentScopeEnum_location,
  _$accessCatalogRoleAssignmentScopeEnum_unknownDefaultOpenApi,
]);

Serializer<AccessCatalogRoleAssignmentScopeEnum>
    _$accessCatalogRoleAssignmentScopeEnumSerializer =
    _$AccessCatalogRoleAssignmentScopeEnumSerializer();

class _$AccessCatalogRoleAssignmentScopeEnumSerializer
    implements PrimitiveSerializer<AccessCatalogRoleAssignmentScopeEnum> {
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
    AccessCatalogRoleAssignmentScopeEnum
  ];
  @override
  final String wireName = 'AccessCatalogRoleAssignmentScopeEnum';

  @override
  Object serialize(
          Serializers serializers, AccessCatalogRoleAssignmentScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AccessCatalogRoleAssignmentScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AccessCatalogRoleAssignmentScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AccessCatalogRole extends AccessCatalogRole {
  @override
  final String? description;
  @override
  final AccessCatalogRoleAssignmentScopeEnum assignmentScope;
  @override
  final String id;
  @override
  final String code;
  @override
  final String name;

  factory _$AccessCatalogRole(
          [void Function(AccessCatalogRoleBuilder)? updates]) =>
      (AccessCatalogRoleBuilder()..update(updates))._build();

  _$AccessCatalogRole._(
      {this.description,
      required this.assignmentScope,
      required this.id,
      required this.code,
      required this.name})
      : super._();
  @override
  AccessCatalogRole rebuild(void Function(AccessCatalogRoleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccessCatalogRoleBuilder toBuilder() =>
      AccessCatalogRoleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccessCatalogRole &&
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
    return (newBuiltValueToStringHelper(r'AccessCatalogRole')
          ..add('description', description)
          ..add('assignmentScope', assignmentScope)
          ..add('id', id)
          ..add('code', code)
          ..add('name', name))
        .toString();
  }
}

class AccessCatalogRoleBuilder
    implements
        Builder<AccessCatalogRole, AccessCatalogRoleBuilder>,
        RoleSummaryBuilder {
  _$AccessCatalogRole? _$v;

  String? _description;
  String? get description => _$this._description;
  set description(covariant String? description) =>
      _$this._description = description;

  AccessCatalogRoleAssignmentScopeEnum? _assignmentScope;
  AccessCatalogRoleAssignmentScopeEnum? get assignmentScope =>
      _$this._assignmentScope;
  set assignmentScope(
          covariant AccessCatalogRoleAssignmentScopeEnum? assignmentScope) =>
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

  AccessCatalogRoleBuilder() {
    AccessCatalogRole._defaults(this);
  }

  AccessCatalogRoleBuilder get _$this {
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
  void replace(covariant AccessCatalogRole other) {
    _$v = other as _$AccessCatalogRole;
  }

  @override
  void update(void Function(AccessCatalogRoleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccessCatalogRole build() => _build();

  _$AccessCatalogRole _build() {
    final _$result = _$v ??
        _$AccessCatalogRole._(
          description: description,
          assignmentScope: BuiltValueNullFieldError.checkNotNull(
              assignmentScope, r'AccessCatalogRole', 'assignmentScope'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'AccessCatalogRole', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'AccessCatalogRole', 'code'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'AccessCatalogRole', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
