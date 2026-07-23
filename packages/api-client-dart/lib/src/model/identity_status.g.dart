// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const IdentityStatus _$invited = const IdentityStatus._('invited');
const IdentityStatus _$active = const IdentityStatus._('active');
const IdentityStatus _$suspended = const IdentityStatus._('suspended');
const IdentityStatus _$disabled = const IdentityStatus._('disabled');
const IdentityStatus _$unknownDefaultOpenApi =
    const IdentityStatus._('unknownDefaultOpenApi');

IdentityStatus _$valueOf(String name) {
  switch (name) {
    case 'invited':
      return _$invited;
    case 'active':
      return _$active;
    case 'suspended':
      return _$suspended;
    case 'disabled':
      return _$disabled;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<IdentityStatus> _$values =
    BuiltSet<IdentityStatus>(const <IdentityStatus>[
  _$invited,
  _$active,
  _$suspended,
  _$disabled,
  _$unknownDefaultOpenApi,
]);

class _$IdentityStatusMeta {
  const _$IdentityStatusMeta();
  IdentityStatus get invited => _$invited;
  IdentityStatus get active => _$active;
  IdentityStatus get suspended => _$suspended;
  IdentityStatus get disabled => _$disabled;
  IdentityStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  IdentityStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<IdentityStatus> get values => _$values;
}

abstract class _$IdentityStatusMixin {
  // ignore: non_constant_identifier_names
  _$IdentityStatusMeta get IdentityStatus => const _$IdentityStatusMeta();
}

Serializer<IdentityStatus> _$identityStatusSerializer =
    _$IdentityStatusSerializer();

class _$IdentityStatusSerializer
    implements PrimitiveSerializer<IdentityStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'invited': 'invited',
    'active': 'active',
    'suspended': 'suspended',
    'disabled': 'disabled',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'invited': 'invited',
    'active': 'active',
    'suspended': 'suspended',
    'disabled': 'disabled',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[IdentityStatus];
  @override
  final String wireName = 'IdentityStatus';

  @override
  Object serialize(Serializers serializers, IdentityStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  IdentityStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      IdentityStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
