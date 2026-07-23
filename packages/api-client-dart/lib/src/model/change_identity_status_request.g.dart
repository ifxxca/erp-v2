// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_identity_status_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChangeIdentityStatusRequestStatusEnum
    _$changeIdentityStatusRequestStatusEnum_active =
    const ChangeIdentityStatusRequestStatusEnum._('active');
const ChangeIdentityStatusRequestStatusEnum
    _$changeIdentityStatusRequestStatusEnum_suspended =
    const ChangeIdentityStatusRequestStatusEnum._('suspended');
const ChangeIdentityStatusRequestStatusEnum
    _$changeIdentityStatusRequestStatusEnum_disabled =
    const ChangeIdentityStatusRequestStatusEnum._('disabled');
const ChangeIdentityStatusRequestStatusEnum
    _$changeIdentityStatusRequestStatusEnum_unknownDefaultOpenApi =
    const ChangeIdentityStatusRequestStatusEnum._('unknownDefaultOpenApi');

ChangeIdentityStatusRequestStatusEnum
    _$changeIdentityStatusRequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'active':
      return _$changeIdentityStatusRequestStatusEnum_active;
    case 'suspended':
      return _$changeIdentityStatusRequestStatusEnum_suspended;
    case 'disabled':
      return _$changeIdentityStatusRequestStatusEnum_disabled;
    case 'unknownDefaultOpenApi':
      return _$changeIdentityStatusRequestStatusEnum_unknownDefaultOpenApi;
    default:
      return _$changeIdentityStatusRequestStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ChangeIdentityStatusRequestStatusEnum>
    _$changeIdentityStatusRequestStatusEnumValues = BuiltSet<
        ChangeIdentityStatusRequestStatusEnum>(const <ChangeIdentityStatusRequestStatusEnum>[
  _$changeIdentityStatusRequestStatusEnum_active,
  _$changeIdentityStatusRequestStatusEnum_suspended,
  _$changeIdentityStatusRequestStatusEnum_disabled,
  _$changeIdentityStatusRequestStatusEnum_unknownDefaultOpenApi,
]);

Serializer<ChangeIdentityStatusRequestStatusEnum>
    _$changeIdentityStatusRequestStatusEnumSerializer =
    _$ChangeIdentityStatusRequestStatusEnumSerializer();

class _$ChangeIdentityStatusRequestStatusEnumSerializer
    implements PrimitiveSerializer<ChangeIdentityStatusRequestStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'active': 'active',
    'suspended': 'suspended',
    'disabled': 'disabled',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'active': 'active',
    'suspended': 'suspended',
    'disabled': 'disabled',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ChangeIdentityStatusRequestStatusEnum
  ];
  @override
  final String wireName = 'ChangeIdentityStatusRequestStatusEnum';

  @override
  Object serialize(
          Serializers serializers, ChangeIdentityStatusRequestStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ChangeIdentityStatusRequestStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ChangeIdentityStatusRequestStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ChangeIdentityStatusRequest extends ChangeIdentityStatusRequest {
  @override
  final ChangeIdentityStatusRequestStatusEnum status;
  @override
  final String reason;

  factory _$ChangeIdentityStatusRequest(
          [void Function(ChangeIdentityStatusRequestBuilder)? updates]) =>
      (ChangeIdentityStatusRequestBuilder()..update(updates))._build();

  _$ChangeIdentityStatusRequest._({required this.status, required this.reason})
      : super._();
  @override
  ChangeIdentityStatusRequest rebuild(
          void Function(ChangeIdentityStatusRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChangeIdentityStatusRequestBuilder toBuilder() =>
      ChangeIdentityStatusRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangeIdentityStatusRequest &&
        status == other.status &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangeIdentityStatusRequest')
          ..add('status', status)
          ..add('reason', reason))
        .toString();
  }
}

class ChangeIdentityStatusRequestBuilder
    implements
        Builder<ChangeIdentityStatusRequest,
            ChangeIdentityStatusRequestBuilder> {
  _$ChangeIdentityStatusRequest? _$v;

  ChangeIdentityStatusRequestStatusEnum? _status;
  ChangeIdentityStatusRequestStatusEnum? get status => _$this._status;
  set status(ChangeIdentityStatusRequestStatusEnum? status) =>
      _$this._status = status;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  ChangeIdentityStatusRequestBuilder() {
    ChangeIdentityStatusRequest._defaults(this);
  }

  ChangeIdentityStatusRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangeIdentityStatusRequest other) {
    _$v = other as _$ChangeIdentityStatusRequest;
  }

  @override
  void update(void Function(ChangeIdentityStatusRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangeIdentityStatusRequest build() => _build();

  _$ChangeIdentityStatusRequest _build() {
    final _$result = _$v ??
        _$ChangeIdentityStatusRequest._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'ChangeIdentityStatusRequest', 'status'),
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'ChangeIdentityStatusRequest', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
