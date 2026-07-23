// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_role_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateRoleRequestAssignmentScopeEnum
    _$createRoleRequestAssignmentScopeEnum_company =
    const CreateRoleRequestAssignmentScopeEnum._('company');
const CreateRoleRequestAssignmentScopeEnum
    _$createRoleRequestAssignmentScopeEnum_department =
    const CreateRoleRequestAssignmentScopeEnum._('department');
const CreateRoleRequestAssignmentScopeEnum
    _$createRoleRequestAssignmentScopeEnum_location =
    const CreateRoleRequestAssignmentScopeEnum._('location');
const CreateRoleRequestAssignmentScopeEnum
    _$createRoleRequestAssignmentScopeEnum_unknownDefaultOpenApi =
    const CreateRoleRequestAssignmentScopeEnum._('unknownDefaultOpenApi');

CreateRoleRequestAssignmentScopeEnum
    _$createRoleRequestAssignmentScopeEnumValueOf(String name) {
  switch (name) {
    case 'company':
      return _$createRoleRequestAssignmentScopeEnum_company;
    case 'department':
      return _$createRoleRequestAssignmentScopeEnum_department;
    case 'location':
      return _$createRoleRequestAssignmentScopeEnum_location;
    case 'unknownDefaultOpenApi':
      return _$createRoleRequestAssignmentScopeEnum_unknownDefaultOpenApi;
    default:
      return _$createRoleRequestAssignmentScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateRoleRequestAssignmentScopeEnum>
    _$createRoleRequestAssignmentScopeEnumValues = BuiltSet<
        CreateRoleRequestAssignmentScopeEnum>(const <CreateRoleRequestAssignmentScopeEnum>[
  _$createRoleRequestAssignmentScopeEnum_company,
  _$createRoleRequestAssignmentScopeEnum_department,
  _$createRoleRequestAssignmentScopeEnum_location,
  _$createRoleRequestAssignmentScopeEnum_unknownDefaultOpenApi,
]);

Serializer<CreateRoleRequestAssignmentScopeEnum>
    _$createRoleRequestAssignmentScopeEnumSerializer =
    _$CreateRoleRequestAssignmentScopeEnumSerializer();

class _$CreateRoleRequestAssignmentScopeEnumSerializer
    implements PrimitiveSerializer<CreateRoleRequestAssignmentScopeEnum> {
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
    CreateRoleRequestAssignmentScopeEnum
  ];
  @override
  final String wireName = 'CreateRoleRequestAssignmentScopeEnum';

  @override
  Object serialize(
          Serializers serializers, CreateRoleRequestAssignmentScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateRoleRequestAssignmentScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateRoleRequestAssignmentScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateRoleRequest extends CreateRoleRequest {
  @override
  final String code;
  @override
  final BuiltSet<String> permissionIds;
  @override
  final String name;
  @override
  final String? description;
  @override
  final bool isPrivileged;
  @override
  final CustomRoleProfileAssignmentScopeEnum assignmentScope;
  @override
  final String reason;

  factory _$CreateRoleRequest(
          [void Function(CreateRoleRequestBuilder)? updates]) =>
      (CreateRoleRequestBuilder()..update(updates))._build();

  _$CreateRoleRequest._(
      {required this.code,
      required this.permissionIds,
      required this.name,
      this.description,
      required this.isPrivileged,
      required this.assignmentScope,
      required this.reason})
      : super._();
  @override
  CreateRoleRequest rebuild(void Function(CreateRoleRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateRoleRequestBuilder toBuilder() =>
      CreateRoleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateRoleRequest &&
        code == other.code &&
        permissionIds == other.permissionIds &&
        name == other.name &&
        description == other.description &&
        isPrivileged == other.isPrivileged &&
        assignmentScope == other.assignmentScope &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, permissionIds.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isPrivileged.hashCode);
    _$hash = $jc(_$hash, assignmentScope.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateRoleRequest')
          ..add('code', code)
          ..add('permissionIds', permissionIds)
          ..add('name', name)
          ..add('description', description)
          ..add('isPrivileged', isPrivileged)
          ..add('assignmentScope', assignmentScope)
          ..add('reason', reason))
        .toString();
  }
}

class CreateRoleRequestBuilder
    implements
        Builder<CreateRoleRequest, CreateRoleRequestBuilder>,
        CustomRoleProfileBuilder {
  _$CreateRoleRequest? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(covariant String? code) => _$this._code = code;

  SetBuilder<String>? _permissionIds;
  SetBuilder<String> get permissionIds =>
      _$this._permissionIds ??= SetBuilder<String>();
  set permissionIds(covariant SetBuilder<String>? permissionIds) =>
      _$this._permissionIds = permissionIds;

  String? _name;
  String? get name => _$this._name;
  set name(covariant String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(covariant String? description) =>
      _$this._description = description;

  bool? _isPrivileged;
  bool? get isPrivileged => _$this._isPrivileged;
  set isPrivileged(covariant bool? isPrivileged) =>
      _$this._isPrivileged = isPrivileged;

  CustomRoleProfileAssignmentScopeEnum? _assignmentScope;
  CustomRoleProfileAssignmentScopeEnum? get assignmentScope =>
      _$this._assignmentScope;
  set assignmentScope(
          covariant CustomRoleProfileAssignmentScopeEnum? assignmentScope) =>
      _$this._assignmentScope = assignmentScope;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(covariant String? reason) => _$this._reason = reason;

  CreateRoleRequestBuilder() {
    CreateRoleRequest._defaults(this);
  }

  CreateRoleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _permissionIds = $v.permissionIds.toBuilder();
      _name = $v.name;
      _description = $v.description;
      _isPrivileged = $v.isPrivileged;
      _assignmentScope = $v.assignmentScope;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant CreateRoleRequest other) {
    _$v = other as _$CreateRoleRequest;
  }

  @override
  void update(void Function(CreateRoleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateRoleRequest build() => _build();

  _$CreateRoleRequest _build() {
    _$CreateRoleRequest _$result;
    try {
      _$result = _$v ??
          _$CreateRoleRequest._(
            code: BuiltValueNullFieldError.checkNotNull(
                code, r'CreateRoleRequest', 'code'),
            permissionIds: permissionIds.build(),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'CreateRoleRequest', 'name'),
            description: description,
            isPrivileged: BuiltValueNullFieldError.checkNotNull(
                isPrivileged, r'CreateRoleRequest', 'isPrivileged'),
            assignmentScope: BuiltValueNullFieldError.checkNotNull(
                assignmentScope, r'CreateRoleRequest', 'assignmentScope'),
            reason: BuiltValueNullFieldError.checkNotNull(
                reason, r'CreateRoleRequest', 'reason'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'permissionIds';
        permissionIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateRoleRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
