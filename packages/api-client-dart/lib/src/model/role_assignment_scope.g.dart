// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_assignment_scope.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RoleAssignmentScope _$global = const RoleAssignmentScope._('global');
const RoleAssignmentScope _$company = const RoleAssignmentScope._('company');
const RoleAssignmentScope _$department =
    const RoleAssignmentScope._('department');
const RoleAssignmentScope _$location = const RoleAssignmentScope._('location');
const RoleAssignmentScope _$unknownDefaultOpenApi =
    const RoleAssignmentScope._('unknownDefaultOpenApi');

RoleAssignmentScope _$valueOf(String name) {
  switch (name) {
    case 'global':
      return _$global;
    case 'company':
      return _$company;
    case 'department':
      return _$department;
    case 'location':
      return _$location;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<RoleAssignmentScope> _$values =
    BuiltSet<RoleAssignmentScope>(const <RoleAssignmentScope>[
  _$global,
  _$company,
  _$department,
  _$location,
  _$unknownDefaultOpenApi,
]);

class _$RoleAssignmentScopeMeta {
  const _$RoleAssignmentScopeMeta();
  RoleAssignmentScope get global => _$global;
  RoleAssignmentScope get company => _$company;
  RoleAssignmentScope get department => _$department;
  RoleAssignmentScope get location => _$location;
  RoleAssignmentScope get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  RoleAssignmentScope valueOf(String name) => _$valueOf(name);
  BuiltSet<RoleAssignmentScope> get values => _$values;
}

abstract class _$RoleAssignmentScopeMixin {
  // ignore: non_constant_identifier_names
  _$RoleAssignmentScopeMeta get RoleAssignmentScope =>
      const _$RoleAssignmentScopeMeta();
}

Serializer<RoleAssignmentScope> _$roleAssignmentScopeSerializer =
    _$RoleAssignmentScopeSerializer();

class _$RoleAssignmentScopeSerializer
    implements PrimitiveSerializer<RoleAssignmentScope> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'global': 'global',
    'company': 'company',
    'department': 'department',
    'location': 'location',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'global': 'global',
    'company': 'company',
    'department': 'department',
    'location': 'location',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RoleAssignmentScope];
  @override
  final String wireName = 'RoleAssignmentScope';

  @override
  Object serialize(Serializers serializers, RoleAssignmentScope object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RoleAssignmentScope deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RoleAssignmentScope.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
