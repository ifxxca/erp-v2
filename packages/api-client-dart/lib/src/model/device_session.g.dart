// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_session.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeviceSessionSurfaceEnum _$deviceSessionSurfaceEnum_erpWeb =
    const DeviceSessionSurfaceEnum._('erpWeb');
const DeviceSessionSurfaceEnum _$deviceSessionSurfaceEnum_opsWeb =
    const DeviceSessionSurfaceEnum._('opsWeb');
const DeviceSessionSurfaceEnum _$deviceSessionSurfaceEnum_mobile =
    const DeviceSessionSurfaceEnum._('mobile');
const DeviceSessionSurfaceEnum _$deviceSessionSurfaceEnum_unknown =
    const DeviceSessionSurfaceEnum._('unknown');
const DeviceSessionSurfaceEnum
    _$deviceSessionSurfaceEnum_unknownDefaultOpenApi =
    const DeviceSessionSurfaceEnum._('unknownDefaultOpenApi');

DeviceSessionSurfaceEnum _$deviceSessionSurfaceEnumValueOf(String name) {
  switch (name) {
    case 'erpWeb':
      return _$deviceSessionSurfaceEnum_erpWeb;
    case 'opsWeb':
      return _$deviceSessionSurfaceEnum_opsWeb;
    case 'mobile':
      return _$deviceSessionSurfaceEnum_mobile;
    case 'unknown':
      return _$deviceSessionSurfaceEnum_unknown;
    case 'unknownDefaultOpenApi':
      return _$deviceSessionSurfaceEnum_unknownDefaultOpenApi;
    default:
      return _$deviceSessionSurfaceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DeviceSessionSurfaceEnum> _$deviceSessionSurfaceEnumValues =
    BuiltSet<DeviceSessionSurfaceEnum>(const <DeviceSessionSurfaceEnum>[
  _$deviceSessionSurfaceEnum_erpWeb,
  _$deviceSessionSurfaceEnum_opsWeb,
  _$deviceSessionSurfaceEnum_mobile,
  _$deviceSessionSurfaceEnum_unknown,
  _$deviceSessionSurfaceEnum_unknownDefaultOpenApi,
]);

Serializer<DeviceSessionSurfaceEnum> _$deviceSessionSurfaceEnumSerializer =
    _$DeviceSessionSurfaceEnumSerializer();

class _$DeviceSessionSurfaceEnumSerializer
    implements PrimitiveSerializer<DeviceSessionSurfaceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'erpWeb': 'erp_web',
    'opsWeb': 'ops_web',
    'mobile': 'mobile',
    'unknown': 'unknown',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'erp_web': 'erpWeb',
    'ops_web': 'opsWeb',
    'mobile': 'mobile',
    'unknown': 'unknown',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DeviceSessionSurfaceEnum];
  @override
  final String wireName = 'DeviceSessionSurfaceEnum';

  @override
  Object serialize(Serializers serializers, DeviceSessionSurfaceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DeviceSessionSurfaceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DeviceSessionSurfaceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DeviceSession extends DeviceSession {
  @override
  final String id;
  @override
  final String deviceName;
  @override
  final DeviceSessionSurfaceEnum surface;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastUsedAt;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime? mfaVerifiedAt;
  @override
  final bool current;

  factory _$DeviceSession([void Function(DeviceSessionBuilder)? updates]) =>
      (DeviceSessionBuilder()..update(updates))._build();

  _$DeviceSession._(
      {required this.id,
      required this.deviceName,
      required this.surface,
      required this.createdAt,
      this.lastUsedAt,
      this.expiresAt,
      this.mfaVerifiedAt,
      required this.current})
      : super._();
  @override
  DeviceSession rebuild(void Function(DeviceSessionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeviceSessionBuilder toBuilder() => DeviceSessionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeviceSession &&
        id == other.id &&
        deviceName == other.deviceName &&
        surface == other.surface &&
        createdAt == other.createdAt &&
        lastUsedAt == other.lastUsedAt &&
        expiresAt == other.expiresAt &&
        mfaVerifiedAt == other.mfaVerifiedAt &&
        current == other.current;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, deviceName.hashCode);
    _$hash = $jc(_$hash, surface.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastUsedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, mfaVerifiedAt.hashCode);
    _$hash = $jc(_$hash, current.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeviceSession')
          ..add('id', id)
          ..add('deviceName', deviceName)
          ..add('surface', surface)
          ..add('createdAt', createdAt)
          ..add('lastUsedAt', lastUsedAt)
          ..add('expiresAt', expiresAt)
          ..add('mfaVerifiedAt', mfaVerifiedAt)
          ..add('current', current))
        .toString();
  }
}

class DeviceSessionBuilder
    implements Builder<DeviceSession, DeviceSessionBuilder> {
  _$DeviceSession? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _deviceName;
  String? get deviceName => _$this._deviceName;
  set deviceName(String? deviceName) => _$this._deviceName = deviceName;

  DeviceSessionSurfaceEnum? _surface;
  DeviceSessionSurfaceEnum? get surface => _$this._surface;
  set surface(DeviceSessionSurfaceEnum? surface) => _$this._surface = surface;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _lastUsedAt;
  DateTime? get lastUsedAt => _$this._lastUsedAt;
  set lastUsedAt(DateTime? lastUsedAt) => _$this._lastUsedAt = lastUsedAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  DateTime? _mfaVerifiedAt;
  DateTime? get mfaVerifiedAt => _$this._mfaVerifiedAt;
  set mfaVerifiedAt(DateTime? mfaVerifiedAt) =>
      _$this._mfaVerifiedAt = mfaVerifiedAt;

  bool? _current;
  bool? get current => _$this._current;
  set current(bool? current) => _$this._current = current;

  DeviceSessionBuilder() {
    DeviceSession._defaults(this);
  }

  DeviceSessionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _deviceName = $v.deviceName;
      _surface = $v.surface;
      _createdAt = $v.createdAt;
      _lastUsedAt = $v.lastUsedAt;
      _expiresAt = $v.expiresAt;
      _mfaVerifiedAt = $v.mfaVerifiedAt;
      _current = $v.current;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeviceSession other) {
    _$v = other as _$DeviceSession;
  }

  @override
  void update(void Function(DeviceSessionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeviceSession build() => _build();

  _$DeviceSession _build() {
    final _$result = _$v ??
        _$DeviceSession._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'DeviceSession', 'id'),
          deviceName: BuiltValueNullFieldError.checkNotNull(
              deviceName, r'DeviceSession', 'deviceName'),
          surface: BuiltValueNullFieldError.checkNotNull(
              surface, r'DeviceSession', 'surface'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'DeviceSession', 'createdAt'),
          lastUsedAt: lastUsedAt,
          expiresAt: expiresAt,
          mfaVerifiedAt: mfaVerifiedAt,
          current: BuiltValueNullFieldError.checkNotNull(
              current, r'DeviceSession', 'current'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
