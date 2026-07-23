// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_notification.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PlatformNotificationDeliveriesEnum
    _$platformNotificationDeliveriesEnum_pending =
    const PlatformNotificationDeliveriesEnum._('pending');
const PlatformNotificationDeliveriesEnum
    _$platformNotificationDeliveriesEnum_processing =
    const PlatformNotificationDeliveriesEnum._('processing');
const PlatformNotificationDeliveriesEnum
    _$platformNotificationDeliveriesEnum_delivered =
    const PlatformNotificationDeliveriesEnum._('delivered');
const PlatformNotificationDeliveriesEnum
    _$platformNotificationDeliveriesEnum_deadLetter =
    const PlatformNotificationDeliveriesEnum._('deadLetter');
const PlatformNotificationDeliveriesEnum
    _$platformNotificationDeliveriesEnum_unknownDefaultOpenApi =
    const PlatformNotificationDeliveriesEnum._('unknownDefaultOpenApi');

PlatformNotificationDeliveriesEnum _$platformNotificationDeliveriesEnumValueOf(
    String name) {
  switch (name) {
    case 'pending':
      return _$platformNotificationDeliveriesEnum_pending;
    case 'processing':
      return _$platformNotificationDeliveriesEnum_processing;
    case 'delivered':
      return _$platformNotificationDeliveriesEnum_delivered;
    case 'deadLetter':
      return _$platformNotificationDeliveriesEnum_deadLetter;
    case 'unknownDefaultOpenApi':
      return _$platformNotificationDeliveriesEnum_unknownDefaultOpenApi;
    default:
      return _$platformNotificationDeliveriesEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PlatformNotificationDeliveriesEnum>
    _$platformNotificationDeliveriesEnumValues = BuiltSet<
        PlatformNotificationDeliveriesEnum>(const <PlatformNotificationDeliveriesEnum>[
  _$platformNotificationDeliveriesEnum_pending,
  _$platformNotificationDeliveriesEnum_processing,
  _$platformNotificationDeliveriesEnum_delivered,
  _$platformNotificationDeliveriesEnum_deadLetter,
  _$platformNotificationDeliveriesEnum_unknownDefaultOpenApi,
]);

Serializer<PlatformNotificationDeliveriesEnum>
    _$platformNotificationDeliveriesEnumSerializer =
    _$PlatformNotificationDeliveriesEnumSerializer();

class _$PlatformNotificationDeliveriesEnumSerializer
    implements PrimitiveSerializer<PlatformNotificationDeliveriesEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'processing': 'processing',
    'delivered': 'delivered',
    'deadLetter': 'dead_letter',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'processing': 'processing',
    'delivered': 'delivered',
    'dead_letter': 'deadLetter',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PlatformNotificationDeliveriesEnum];
  @override
  final String wireName = 'PlatformNotificationDeliveriesEnum';

  @override
  Object serialize(
          Serializers serializers, PlatformNotificationDeliveriesEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PlatformNotificationDeliveriesEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PlatformNotificationDeliveriesEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PlatformNotification extends PlatformNotification {
  @override
  final String id;
  @override
  final String? companyId;
  @override
  final String kind;
  @override
  final String title;
  @override
  final String body;
  @override
  final BuiltMap<String, JsonObject?> data;
  @override
  final String? actionUrl;
  @override
  final DateTime? readAt;
  @override
  final DateTime createdAt;
  @override
  final BuiltMap<String, PlatformNotificationDeliveriesEnum> deliveries;

  factory _$PlatformNotification(
          [void Function(PlatformNotificationBuilder)? updates]) =>
      (PlatformNotificationBuilder()..update(updates))._build();

  _$PlatformNotification._(
      {required this.id,
      this.companyId,
      required this.kind,
      required this.title,
      required this.body,
      required this.data,
      this.actionUrl,
      this.readAt,
      required this.createdAt,
      required this.deliveries})
      : super._();
  @override
  PlatformNotification rebuild(
          void Function(PlatformNotificationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlatformNotificationBuilder toBuilder() =>
      PlatformNotificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PlatformNotification &&
        id == other.id &&
        companyId == other.companyId &&
        kind == other.kind &&
        title == other.title &&
        body == other.body &&
        data == other.data &&
        actionUrl == other.actionUrl &&
        readAt == other.readAt &&
        createdAt == other.createdAt &&
        deliveries == other.deliveries;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, companyId.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, actionUrl.hashCode);
    _$hash = $jc(_$hash, readAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, deliveries.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PlatformNotification')
          ..add('id', id)
          ..add('companyId', companyId)
          ..add('kind', kind)
          ..add('title', title)
          ..add('body', body)
          ..add('data', data)
          ..add('actionUrl', actionUrl)
          ..add('readAt', readAt)
          ..add('createdAt', createdAt)
          ..add('deliveries', deliveries))
        .toString();
  }
}

class PlatformNotificationBuilder
    implements Builder<PlatformNotification, PlatformNotificationBuilder> {
  _$PlatformNotification? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _companyId;
  String? get companyId => _$this._companyId;
  set companyId(String? companyId) => _$this._companyId = companyId;

  String? _kind;
  String? get kind => _$this._kind;
  set kind(String? kind) => _$this._kind = kind;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  MapBuilder<String, JsonObject?>? _data;
  MapBuilder<String, JsonObject?> get data =>
      _$this._data ??= MapBuilder<String, JsonObject?>();
  set data(MapBuilder<String, JsonObject?>? data) => _$this._data = data;

  String? _actionUrl;
  String? get actionUrl => _$this._actionUrl;
  set actionUrl(String? actionUrl) => _$this._actionUrl = actionUrl;

  DateTime? _readAt;
  DateTime? get readAt => _$this._readAt;
  set readAt(DateTime? readAt) => _$this._readAt = readAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  MapBuilder<String, PlatformNotificationDeliveriesEnum>? _deliveries;
  MapBuilder<String, PlatformNotificationDeliveriesEnum> get deliveries =>
      _$this._deliveries ??=
          MapBuilder<String, PlatformNotificationDeliveriesEnum>();
  set deliveries(
          MapBuilder<String, PlatformNotificationDeliveriesEnum>? deliveries) =>
      _$this._deliveries = deliveries;

  PlatformNotificationBuilder() {
    PlatformNotification._defaults(this);
  }

  PlatformNotificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _companyId = $v.companyId;
      _kind = $v.kind;
      _title = $v.title;
      _body = $v.body;
      _data = $v.data.toBuilder();
      _actionUrl = $v.actionUrl;
      _readAt = $v.readAt;
      _createdAt = $v.createdAt;
      _deliveries = $v.deliveries.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PlatformNotification other) {
    _$v = other as _$PlatformNotification;
  }

  @override
  void update(void Function(PlatformNotificationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PlatformNotification build() => _build();

  _$PlatformNotification _build() {
    _$PlatformNotification _$result;
    try {
      _$result = _$v ??
          _$PlatformNotification._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'PlatformNotification', 'id'),
            companyId: companyId,
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'PlatformNotification', 'kind'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'PlatformNotification', 'title'),
            body: BuiltValueNullFieldError.checkNotNull(
                body, r'PlatformNotification', 'body'),
            data: data.build(),
            actionUrl: actionUrl,
            readAt: readAt,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'PlatformNotification', 'createdAt'),
            deliveries: deliveries.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();

        _$failedField = 'deliveries';
        deliveries.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PlatformNotification', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
