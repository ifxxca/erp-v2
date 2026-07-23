// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readiness_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ReadinessResponseStatusEnum _$readinessResponseStatusEnum_ready =
    const ReadinessResponseStatusEnum._('ready');
const ReadinessResponseStatusEnum _$readinessResponseStatusEnum_unavailable =
    const ReadinessResponseStatusEnum._('unavailable');
const ReadinessResponseStatusEnum
    _$readinessResponseStatusEnum_unknownDefaultOpenApi =
    const ReadinessResponseStatusEnum._('unknownDefaultOpenApi');

ReadinessResponseStatusEnum _$readinessResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'ready':
      return _$readinessResponseStatusEnum_ready;
    case 'unavailable':
      return _$readinessResponseStatusEnum_unavailable;
    case 'unknownDefaultOpenApi':
      return _$readinessResponseStatusEnum_unknownDefaultOpenApi;
    default:
      return _$readinessResponseStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ReadinessResponseStatusEnum>
    _$readinessResponseStatusEnumValues =
    BuiltSet<ReadinessResponseStatusEnum>(const <ReadinessResponseStatusEnum>[
  _$readinessResponseStatusEnum_ready,
  _$readinessResponseStatusEnum_unavailable,
  _$readinessResponseStatusEnum_unknownDefaultOpenApi,
]);

Serializer<ReadinessResponseStatusEnum>
    _$readinessResponseStatusEnumSerializer =
    _$ReadinessResponseStatusEnumSerializer();

class _$ReadinessResponseStatusEnumSerializer
    implements PrimitiveSerializer<ReadinessResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ready': 'ready',
    'unavailable': 'unavailable',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ready': 'ready',
    'unavailable': 'unavailable',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ReadinessResponseStatusEnum];
  @override
  final String wireName = 'ReadinessResponseStatusEnum';

  @override
  Object serialize(Serializers serializers, ReadinessResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ReadinessResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ReadinessResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ReadinessResponse extends ReadinessResponse {
  @override
  final ReadinessResponseStatusEnum status;
  @override
  final BuiltMap<String, ReadinessResponseChecksValue> checks;
  @override
  final DateTime checkedAt;

  factory _$ReadinessResponse(
          [void Function(ReadinessResponseBuilder)? updates]) =>
      (ReadinessResponseBuilder()..update(updates))._build();

  _$ReadinessResponse._(
      {required this.status, required this.checks, required this.checkedAt})
      : super._();
  @override
  ReadinessResponse rebuild(void Function(ReadinessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReadinessResponseBuilder toBuilder() =>
      ReadinessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReadinessResponse &&
        status == other.status &&
        checks == other.checks &&
        checkedAt == other.checkedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, checks.hashCode);
    _$hash = $jc(_$hash, checkedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReadinessResponse')
          ..add('status', status)
          ..add('checks', checks)
          ..add('checkedAt', checkedAt))
        .toString();
  }
}

class ReadinessResponseBuilder
    implements Builder<ReadinessResponse, ReadinessResponseBuilder> {
  _$ReadinessResponse? _$v;

  ReadinessResponseStatusEnum? _status;
  ReadinessResponseStatusEnum? get status => _$this._status;
  set status(ReadinessResponseStatusEnum? status) => _$this._status = status;

  MapBuilder<String, ReadinessResponseChecksValue>? _checks;
  MapBuilder<String, ReadinessResponseChecksValue> get checks =>
      _$this._checks ??= MapBuilder<String, ReadinessResponseChecksValue>();
  set checks(MapBuilder<String, ReadinessResponseChecksValue>? checks) =>
      _$this._checks = checks;

  DateTime? _checkedAt;
  DateTime? get checkedAt => _$this._checkedAt;
  set checkedAt(DateTime? checkedAt) => _$this._checkedAt = checkedAt;

  ReadinessResponseBuilder() {
    ReadinessResponse._defaults(this);
  }

  ReadinessResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _checks = $v.checks.toBuilder();
      _checkedAt = $v.checkedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReadinessResponse other) {
    _$v = other as _$ReadinessResponse;
  }

  @override
  void update(void Function(ReadinessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReadinessResponse build() => _build();

  _$ReadinessResponse _build() {
    _$ReadinessResponse _$result;
    try {
      _$result = _$v ??
          _$ReadinessResponse._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'ReadinessResponse', 'status'),
            checks: checks.build(),
            checkedAt: BuiltValueNullFieldError.checkNotNull(
                checkedAt, r'ReadinessResponse', 'checkedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'checks';
        checks.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ReadinessResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
