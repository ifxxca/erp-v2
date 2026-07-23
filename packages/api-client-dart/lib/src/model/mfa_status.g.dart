// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfa_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MfaStatusStatusEnum _$mfaStatusStatusEnum_notConfigured =
    const MfaStatusStatusEnum._('notConfigured');
const MfaStatusStatusEnum _$mfaStatusStatusEnum_pending =
    const MfaStatusStatusEnum._('pending');
const MfaStatusStatusEnum _$mfaStatusStatusEnum_active =
    const MfaStatusStatusEnum._('active');
const MfaStatusStatusEnum _$mfaStatusStatusEnum_disabled =
    const MfaStatusStatusEnum._('disabled');
const MfaStatusStatusEnum _$mfaStatusStatusEnum_unknownDefaultOpenApi =
    const MfaStatusStatusEnum._('unknownDefaultOpenApi');

MfaStatusStatusEnum _$mfaStatusStatusEnumValueOf(String name) {
  switch (name) {
    case 'notConfigured':
      return _$mfaStatusStatusEnum_notConfigured;
    case 'pending':
      return _$mfaStatusStatusEnum_pending;
    case 'active':
      return _$mfaStatusStatusEnum_active;
    case 'disabled':
      return _$mfaStatusStatusEnum_disabled;
    case 'unknownDefaultOpenApi':
      return _$mfaStatusStatusEnum_unknownDefaultOpenApi;
    default:
      return _$mfaStatusStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<MfaStatusStatusEnum> _$mfaStatusStatusEnumValues =
    BuiltSet<MfaStatusStatusEnum>(const <MfaStatusStatusEnum>[
  _$mfaStatusStatusEnum_notConfigured,
  _$mfaStatusStatusEnum_pending,
  _$mfaStatusStatusEnum_active,
  _$mfaStatusStatusEnum_disabled,
  _$mfaStatusStatusEnum_unknownDefaultOpenApi,
]);

Serializer<MfaStatusStatusEnum> _$mfaStatusStatusEnumSerializer =
    _$MfaStatusStatusEnumSerializer();

class _$MfaStatusStatusEnumSerializer
    implements PrimitiveSerializer<MfaStatusStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'notConfigured': 'not_configured',
    'pending': 'pending',
    'active': 'active',
    'disabled': 'disabled',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'not_configured': 'notConfigured',
    'pending': 'pending',
    'active': 'active',
    'disabled': 'disabled',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[MfaStatusStatusEnum];
  @override
  final String wireName = 'MfaStatusStatusEnum';

  @override
  Object serialize(Serializers serializers, MfaStatusStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MfaStatusStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MfaStatusStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MfaStatus extends MfaStatus {
  @override
  final bool required_;
  @override
  final bool enabled;
  @override
  final MfaStatusStatusEnum status;
  @override
  final DateTime? confirmedAt;
  @override
  final int unusedRecoveryCodes;
  @override
  final DateTime? currentTokenVerifiedAt;

  factory _$MfaStatus([void Function(MfaStatusBuilder)? updates]) =>
      (MfaStatusBuilder()..update(updates))._build();

  _$MfaStatus._(
      {required this.required_,
      required this.enabled,
      required this.status,
      this.confirmedAt,
      required this.unusedRecoveryCodes,
      this.currentTokenVerifiedAt})
      : super._();
  @override
  MfaStatus rebuild(void Function(MfaStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MfaStatusBuilder toBuilder() => MfaStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MfaStatus &&
        required_ == other.required_ &&
        enabled == other.enabled &&
        status == other.status &&
        confirmedAt == other.confirmedAt &&
        unusedRecoveryCodes == other.unusedRecoveryCodes &&
        currentTokenVerifiedAt == other.currentTokenVerifiedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, required_.hashCode);
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, confirmedAt.hashCode);
    _$hash = $jc(_$hash, unusedRecoveryCodes.hashCode);
    _$hash = $jc(_$hash, currentTokenVerifiedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MfaStatus')
          ..add('required_', required_)
          ..add('enabled', enabled)
          ..add('status', status)
          ..add('confirmedAt', confirmedAt)
          ..add('unusedRecoveryCodes', unusedRecoveryCodes)
          ..add('currentTokenVerifiedAt', currentTokenVerifiedAt))
        .toString();
  }
}

class MfaStatusBuilder implements Builder<MfaStatus, MfaStatusBuilder> {
  _$MfaStatus? _$v;

  bool? _required_;
  bool? get required_ => _$this._required_;
  set required_(bool? required_) => _$this._required_ = required_;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  MfaStatusStatusEnum? _status;
  MfaStatusStatusEnum? get status => _$this._status;
  set status(MfaStatusStatusEnum? status) => _$this._status = status;

  DateTime? _confirmedAt;
  DateTime? get confirmedAt => _$this._confirmedAt;
  set confirmedAt(DateTime? confirmedAt) => _$this._confirmedAt = confirmedAt;

  int? _unusedRecoveryCodes;
  int? get unusedRecoveryCodes => _$this._unusedRecoveryCodes;
  set unusedRecoveryCodes(int? unusedRecoveryCodes) =>
      _$this._unusedRecoveryCodes = unusedRecoveryCodes;

  DateTime? _currentTokenVerifiedAt;
  DateTime? get currentTokenVerifiedAt => _$this._currentTokenVerifiedAt;
  set currentTokenVerifiedAt(DateTime? currentTokenVerifiedAt) =>
      _$this._currentTokenVerifiedAt = currentTokenVerifiedAt;

  MfaStatusBuilder() {
    MfaStatus._defaults(this);
  }

  MfaStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _required_ = $v.required_;
      _enabled = $v.enabled;
      _status = $v.status;
      _confirmedAt = $v.confirmedAt;
      _unusedRecoveryCodes = $v.unusedRecoveryCodes;
      _currentTokenVerifiedAt = $v.currentTokenVerifiedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MfaStatus other) {
    _$v = other as _$MfaStatus;
  }

  @override
  void update(void Function(MfaStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MfaStatus build() => _build();

  _$MfaStatus _build() {
    final _$result = _$v ??
        _$MfaStatus._(
          required_: BuiltValueNullFieldError.checkNotNull(
              required_, r'MfaStatus', 'required_'),
          enabled: BuiltValueNullFieldError.checkNotNull(
              enabled, r'MfaStatus', 'enabled'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'MfaStatus', 'status'),
          confirmedAt: confirmedAt,
          unusedRecoveryCodes: BuiltValueNullFieldError.checkNotNull(
              unusedRecoveryCodes, r'MfaStatus', 'unusedRecoveryCodes'),
          currentTokenVerifiedAt: currentTokenVerifiedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
