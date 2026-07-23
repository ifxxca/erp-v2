// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_role_assignment_role.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const StandardRoleAssignmentRoleIsPrivilegedEnum
    _$standardRoleAssignmentRoleIsPrivilegedEnum_false_ =
    const StandardRoleAssignmentRoleIsPrivilegedEnum._('false_');
const StandardRoleAssignmentRoleIsPrivilegedEnum
    _$standardRoleAssignmentRoleIsPrivilegedEnum_unknownDefaultOpenApi =
    const StandardRoleAssignmentRoleIsPrivilegedEnum._('unknownDefaultOpenApi');

StandardRoleAssignmentRoleIsPrivilegedEnum
    _$standardRoleAssignmentRoleIsPrivilegedEnumValueOf(String name) {
  switch (name) {
    case 'false_':
      return _$standardRoleAssignmentRoleIsPrivilegedEnum_false_;
    case 'unknownDefaultOpenApi':
      return _$standardRoleAssignmentRoleIsPrivilegedEnum_unknownDefaultOpenApi;
    default:
      return _$standardRoleAssignmentRoleIsPrivilegedEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<StandardRoleAssignmentRoleIsPrivilegedEnum>
    _$standardRoleAssignmentRoleIsPrivilegedEnumValues = BuiltSet<
        StandardRoleAssignmentRoleIsPrivilegedEnum>(const <StandardRoleAssignmentRoleIsPrivilegedEnum>[
  _$standardRoleAssignmentRoleIsPrivilegedEnum_false_,
  _$standardRoleAssignmentRoleIsPrivilegedEnum_unknownDefaultOpenApi,
]);

Serializer<StandardRoleAssignmentRoleIsPrivilegedEnum>
    _$standardRoleAssignmentRoleIsPrivilegedEnumSerializer =
    _$StandardRoleAssignmentRoleIsPrivilegedEnumSerializer();

class _$StandardRoleAssignmentRoleIsPrivilegedEnumSerializer
    implements PrimitiveSerializer<StandardRoleAssignmentRoleIsPrivilegedEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'false_': 'false',
    'unknownDefaultOpenApi': '11184809',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'false': 'false_',
    '11184809': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    StandardRoleAssignmentRoleIsPrivilegedEnum
  ];
  @override
  final String wireName = 'StandardRoleAssignmentRoleIsPrivilegedEnum';

  @override
  Object serialize(Serializers serializers,
          StandardRoleAssignmentRoleIsPrivilegedEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  StandardRoleAssignmentRoleIsPrivilegedEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      StandardRoleAssignmentRoleIsPrivilegedEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$StandardRoleAssignmentRole extends StandardRoleAssignmentRole {
  @override
  final StandardRoleAssignmentRoleIsPrivilegedEnum isPrivileged;
  @override
  final RoleAssignmentScope assignmentScope;
  @override
  final String id;
  @override
  final String code;
  @override
  final String name;

  factory _$StandardRoleAssignmentRole(
          [void Function(StandardRoleAssignmentRoleBuilder)? updates]) =>
      (StandardRoleAssignmentRoleBuilder()..update(updates))._build();

  _$StandardRoleAssignmentRole._(
      {required this.isPrivileged,
      required this.assignmentScope,
      required this.id,
      required this.code,
      required this.name})
      : super._();
  @override
  StandardRoleAssignmentRole rebuild(
          void Function(StandardRoleAssignmentRoleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StandardRoleAssignmentRoleBuilder toBuilder() =>
      StandardRoleAssignmentRoleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StandardRoleAssignmentRole &&
        isPrivileged == other.isPrivileged &&
        assignmentScope == other.assignmentScope &&
        id == other.id &&
        code == other.code &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isPrivileged.hashCode);
    _$hash = $jc(_$hash, assignmentScope.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StandardRoleAssignmentRole')
          ..add('isPrivileged', isPrivileged)
          ..add('assignmentScope', assignmentScope)
          ..add('id', id)
          ..add('code', code)
          ..add('name', name))
        .toString();
  }
}

class StandardRoleAssignmentRoleBuilder
    implements
        Builder<StandardRoleAssignmentRole, StandardRoleAssignmentRoleBuilder>,
        RoleSummaryBuilder {
  _$StandardRoleAssignmentRole? _$v;

  StandardRoleAssignmentRoleIsPrivilegedEnum? _isPrivileged;
  StandardRoleAssignmentRoleIsPrivilegedEnum? get isPrivileged =>
      _$this._isPrivileged;
  set isPrivileged(
          covariant StandardRoleAssignmentRoleIsPrivilegedEnum? isPrivileged) =>
      _$this._isPrivileged = isPrivileged;

  RoleAssignmentScope? _assignmentScope;
  RoleAssignmentScope? get assignmentScope => _$this._assignmentScope;
  set assignmentScope(covariant RoleAssignmentScope? assignmentScope) =>
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

  StandardRoleAssignmentRoleBuilder() {
    StandardRoleAssignmentRole._defaults(this);
  }

  StandardRoleAssignmentRoleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isPrivileged = $v.isPrivileged;
      _assignmentScope = $v.assignmentScope;
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant StandardRoleAssignmentRole other) {
    _$v = other as _$StandardRoleAssignmentRole;
  }

  @override
  void update(void Function(StandardRoleAssignmentRoleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StandardRoleAssignmentRole build() => _build();

  _$StandardRoleAssignmentRole _build() {
    final _$result = _$v ??
        _$StandardRoleAssignmentRole._(
          isPrivileged: BuiltValueNullFieldError.checkNotNull(
              isPrivileged, r'StandardRoleAssignmentRole', 'isPrivileged'),
          assignmentScope: BuiltValueNullFieldError.checkNotNull(
              assignmentScope,
              r'StandardRoleAssignmentRole',
              'assignmentScope'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'StandardRoleAssignmentRole', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'StandardRoleAssignmentRole', 'code'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'StandardRoleAssignmentRole', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
