//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'access_request_status.g.dart';

class AccessRequestStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const AccessRequestStatus pending = _$pending;
  @BuiltValueEnumConst(wireName: r'approved')
  static const AccessRequestStatus approved = _$approved;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const AccessRequestStatus rejected = _$rejected;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const AccessRequestStatus cancelled = _$cancelled;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AccessRequestStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<AccessRequestStatus> get serializer => _$accessRequestStatusSerializer;

  const AccessRequestStatus._(String name): super(name);

  static BuiltSet<AccessRequestStatus> get values => _$values;
  static AccessRequestStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class AccessRequestStatusMixin = Object with _$AccessRequestStatusMixin;
