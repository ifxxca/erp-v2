// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_request_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccessRequestStatus _$pending = const AccessRequestStatus._('pending');
const AccessRequestStatus _$approved = const AccessRequestStatus._('approved');
const AccessRequestStatus _$rejected = const AccessRequestStatus._('rejected');
const AccessRequestStatus _$cancelled =
    const AccessRequestStatus._('cancelled');
const AccessRequestStatus _$unknownDefaultOpenApi =
    const AccessRequestStatus._('unknownDefaultOpenApi');

AccessRequestStatus _$valueOf(String name) {
  switch (name) {
    case 'pending':
      return _$pending;
    case 'approved':
      return _$approved;
    case 'rejected':
      return _$rejected;
    case 'cancelled':
      return _$cancelled;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<AccessRequestStatus> _$values =
    BuiltSet<AccessRequestStatus>(const <AccessRequestStatus>[
  _$pending,
  _$approved,
  _$rejected,
  _$cancelled,
  _$unknownDefaultOpenApi,
]);

class _$AccessRequestStatusMeta {
  const _$AccessRequestStatusMeta();
  AccessRequestStatus get pending => _$pending;
  AccessRequestStatus get approved => _$approved;
  AccessRequestStatus get rejected => _$rejected;
  AccessRequestStatus get cancelled => _$cancelled;
  AccessRequestStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  AccessRequestStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<AccessRequestStatus> get values => _$values;
}

abstract class _$AccessRequestStatusMixin {
  // ignore: non_constant_identifier_names
  _$AccessRequestStatusMeta get AccessRequestStatus =>
      const _$AccessRequestStatusMeta();
}

Serializer<AccessRequestStatus> _$accessRequestStatusSerializer =
    _$AccessRequestStatusSerializer();

class _$AccessRequestStatusSerializer
    implements PrimitiveSerializer<AccessRequestStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'approved': 'approved',
    'rejected': 'rejected',
    'cancelled': 'cancelled',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'approved': 'approved',
    'rejected': 'rejected',
    'cancelled': 'cancelled',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[AccessRequestStatus];
  @override
  final String wireName = 'AccessRequestStatus';

  @override
  Object serialize(Serializers serializers, AccessRequestStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AccessRequestStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AccessRequestStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
