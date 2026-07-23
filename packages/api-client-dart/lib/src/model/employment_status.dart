//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'employment_status.g.dart';

class EmploymentStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'invited')
  static const EmploymentStatus invited = _$invited;
  @BuiltValueEnumConst(wireName: r'active')
  static const EmploymentStatus active = _$active;
  @BuiltValueEnumConst(wireName: r'leave')
  static const EmploymentStatus leave = _$leave;
  @BuiltValueEnumConst(wireName: r'terminated')
  static const EmploymentStatus terminated = _$terminated;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EmploymentStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<EmploymentStatus> get serializer => _$employmentStatusSerializer;

  const EmploymentStatus._(String name): super(name);

  static BuiltSet<EmploymentStatus> get values => _$values;
  static EmploymentStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class EmploymentStatusMixin = Object with _$EmploymentStatusMixin;
