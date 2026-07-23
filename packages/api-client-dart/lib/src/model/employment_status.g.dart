// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employment_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EmploymentStatus _$invited = const EmploymentStatus._('invited');
const EmploymentStatus _$active = const EmploymentStatus._('active');
const EmploymentStatus _$leave = const EmploymentStatus._('leave');
const EmploymentStatus _$terminated = const EmploymentStatus._('terminated');
const EmploymentStatus _$unknownDefaultOpenApi =
    const EmploymentStatus._('unknownDefaultOpenApi');

EmploymentStatus _$valueOf(String name) {
  switch (name) {
    case 'invited':
      return _$invited;
    case 'active':
      return _$active;
    case 'leave':
      return _$leave;
    case 'terminated':
      return _$terminated;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<EmploymentStatus> _$values =
    BuiltSet<EmploymentStatus>(const <EmploymentStatus>[
  _$invited,
  _$active,
  _$leave,
  _$terminated,
  _$unknownDefaultOpenApi,
]);

class _$EmploymentStatusMeta {
  const _$EmploymentStatusMeta();
  EmploymentStatus get invited => _$invited;
  EmploymentStatus get active => _$active;
  EmploymentStatus get leave => _$leave;
  EmploymentStatus get terminated => _$terminated;
  EmploymentStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  EmploymentStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<EmploymentStatus> get values => _$values;
}

abstract class _$EmploymentStatusMixin {
  // ignore: non_constant_identifier_names
  _$EmploymentStatusMeta get EmploymentStatus => const _$EmploymentStatusMeta();
}

Serializer<EmploymentStatus> _$employmentStatusSerializer =
    _$EmploymentStatusSerializer();

class _$EmploymentStatusSerializer
    implements PrimitiveSerializer<EmploymentStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'invited': 'invited',
    'active': 'active',
    'leave': 'leave',
    'terminated': 'terminated',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'invited': 'invited',
    'active': 'active',
    'leave': 'leave',
    'terminated': 'terminated',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[EmploymentStatus];
  @override
  final String wireName = 'EmploymentStatus';

  @override
  Object serialize(Serializers serializers, EmploymentStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EmploymentStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EmploymentStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
