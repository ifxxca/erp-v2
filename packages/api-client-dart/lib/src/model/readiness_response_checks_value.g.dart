// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readiness_response_checks_value.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ReadinessResponseChecksValueStatusEnum
    _$readinessResponseChecksValueStatusEnum_up =
    const ReadinessResponseChecksValueStatusEnum._('up');
const ReadinessResponseChecksValueStatusEnum
    _$readinessResponseChecksValueStatusEnum_down =
    const ReadinessResponseChecksValueStatusEnum._('down');
const ReadinessResponseChecksValueStatusEnum
    _$readinessResponseChecksValueStatusEnum_unknownDefaultOpenApi =
    const ReadinessResponseChecksValueStatusEnum._('unknownDefaultOpenApi');

ReadinessResponseChecksValueStatusEnum
    _$readinessResponseChecksValueStatusEnumValueOf(String name) {
  switch (name) {
    case 'up':
      return _$readinessResponseChecksValueStatusEnum_up;
    case 'down':
      return _$readinessResponseChecksValueStatusEnum_down;
    case 'unknownDefaultOpenApi':
      return _$readinessResponseChecksValueStatusEnum_unknownDefaultOpenApi;
    default:
      return _$readinessResponseChecksValueStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ReadinessResponseChecksValueStatusEnum>
    _$readinessResponseChecksValueStatusEnumValues = BuiltSet<
        ReadinessResponseChecksValueStatusEnum>(const <ReadinessResponseChecksValueStatusEnum>[
  _$readinessResponseChecksValueStatusEnum_up,
  _$readinessResponseChecksValueStatusEnum_down,
  _$readinessResponseChecksValueStatusEnum_unknownDefaultOpenApi,
]);

Serializer<ReadinessResponseChecksValueStatusEnum>
    _$readinessResponseChecksValueStatusEnumSerializer =
    _$ReadinessResponseChecksValueStatusEnumSerializer();

class _$ReadinessResponseChecksValueStatusEnumSerializer
    implements PrimitiveSerializer<ReadinessResponseChecksValueStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'up': 'up',
    'down': 'down',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'up': 'up',
    'down': 'down',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ReadinessResponseChecksValueStatusEnum
  ];
  @override
  final String wireName = 'ReadinessResponseChecksValueStatusEnum';

  @override
  Object serialize(Serializers serializers,
          ReadinessResponseChecksValueStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ReadinessResponseChecksValueStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ReadinessResponseChecksValueStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ReadinessResponseChecksValue extends ReadinessResponseChecksValue {
  @override
  final ReadinessResponseChecksValueStatusEnum status;
  @override
  final num latencyMs;

  factory _$ReadinessResponseChecksValue(
          [void Function(ReadinessResponseChecksValueBuilder)? updates]) =>
      (ReadinessResponseChecksValueBuilder()..update(updates))._build();

  _$ReadinessResponseChecksValue._(
      {required this.status, required this.latencyMs})
      : super._();
  @override
  ReadinessResponseChecksValue rebuild(
          void Function(ReadinessResponseChecksValueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReadinessResponseChecksValueBuilder toBuilder() =>
      ReadinessResponseChecksValueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReadinessResponseChecksValue &&
        status == other.status &&
        latencyMs == other.latencyMs;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, latencyMs.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReadinessResponseChecksValue')
          ..add('status', status)
          ..add('latencyMs', latencyMs))
        .toString();
  }
}

class ReadinessResponseChecksValueBuilder
    implements
        Builder<ReadinessResponseChecksValue,
            ReadinessResponseChecksValueBuilder> {
  _$ReadinessResponseChecksValue? _$v;

  ReadinessResponseChecksValueStatusEnum? _status;
  ReadinessResponseChecksValueStatusEnum? get status => _$this._status;
  set status(ReadinessResponseChecksValueStatusEnum? status) =>
      _$this._status = status;

  num? _latencyMs;
  num? get latencyMs => _$this._latencyMs;
  set latencyMs(num? latencyMs) => _$this._latencyMs = latencyMs;

  ReadinessResponseChecksValueBuilder() {
    ReadinessResponseChecksValue._defaults(this);
  }

  ReadinessResponseChecksValueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _latencyMs = $v.latencyMs;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReadinessResponseChecksValue other) {
    _$v = other as _$ReadinessResponseChecksValue;
  }

  @override
  void update(void Function(ReadinessResponseChecksValueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReadinessResponseChecksValue build() => _build();

  _$ReadinessResponseChecksValue _build() {
    final _$result = _$v ??
        _$ReadinessResponseChecksValue._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'ReadinessResponseChecksValue', 'status'),
          latencyMs: BuiltValueNullFieldError.checkNotNull(
              latencyMs, r'ReadinessResponseChecksValue', 'latencyMs'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
