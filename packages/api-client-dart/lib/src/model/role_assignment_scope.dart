//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_assignment_scope.g.dart';

class RoleAssignmentScope extends EnumClass {

  @BuiltValueEnumConst(wireName: r'global')
  static const RoleAssignmentScope global = _$global;
  @BuiltValueEnumConst(wireName: r'company')
  static const RoleAssignmentScope company = _$company;
  @BuiltValueEnumConst(wireName: r'department')
  static const RoleAssignmentScope department = _$department;
  @BuiltValueEnumConst(wireName: r'location')
  static const RoleAssignmentScope location = _$location;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RoleAssignmentScope unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<RoleAssignmentScope> get serializer => _$roleAssignmentScopeSerializer;

  const RoleAssignmentScope._(String name): super(name);

  static BuiltSet<RoleAssignmentScope> get values => _$values;
  static RoleAssignmentScope valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class RoleAssignmentScopeMixin = Object with _$RoleAssignmentScopeMixin;
