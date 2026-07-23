//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'identity_status.g.dart';

class IdentityStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'invited')
  static const IdentityStatus invited = _$invited;
  @BuiltValueEnumConst(wireName: r'active')
  static const IdentityStatus active = _$active;
  @BuiltValueEnumConst(wireName: r'suspended')
  static const IdentityStatus suspended = _$suspended;
  @BuiltValueEnumConst(wireName: r'disabled')
  static const IdentityStatus disabled = _$disabled;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const IdentityStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<IdentityStatus> get serializer => _$identityStatusSerializer;

  const IdentityStatus._(String name): super(name);

  static BuiltSet<IdentityStatus> get values => _$values;
  static IdentityStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class IdentityStatusMixin = Object with _$IdentityStatusMixin;
