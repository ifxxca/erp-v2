// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transition_work_order_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransitionWorkOrderRequestStatusEnum
    _$transitionWorkOrderRequestStatusEnum_scheduled =
    const TransitionWorkOrderRequestStatusEnum._('scheduled');
const TransitionWorkOrderRequestStatusEnum
    _$transitionWorkOrderRequestStatusEnum_inProgress =
    const TransitionWorkOrderRequestStatusEnum._('inProgress');
const TransitionWorkOrderRequestStatusEnum
    _$transitionWorkOrderRequestStatusEnum_completed =
    const TransitionWorkOrderRequestStatusEnum._('completed');
const TransitionWorkOrderRequestStatusEnum
    _$transitionWorkOrderRequestStatusEnum_cancelled =
    const TransitionWorkOrderRequestStatusEnum._('cancelled');
const TransitionWorkOrderRequestStatusEnum
    _$transitionWorkOrderRequestStatusEnum_unknownDefaultOpenApi =
    const TransitionWorkOrderRequestStatusEnum._('unknownDefaultOpenApi');

TransitionWorkOrderRequestStatusEnum
    _$transitionWorkOrderRequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'scheduled':
      return _$transitionWorkOrderRequestStatusEnum_scheduled;
    case 'inProgress':
      return _$transitionWorkOrderRequestStatusEnum_inProgress;
    case 'completed':
      return _$transitionWorkOrderRequestStatusEnum_completed;
    case 'cancelled':
      return _$transitionWorkOrderRequestStatusEnum_cancelled;
    case 'unknownDefaultOpenApi':
      return _$transitionWorkOrderRequestStatusEnum_unknownDefaultOpenApi;
    default:
      return _$transitionWorkOrderRequestStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TransitionWorkOrderRequestStatusEnum>
    _$transitionWorkOrderRequestStatusEnumValues = BuiltSet<
        TransitionWorkOrderRequestStatusEnum>(const <TransitionWorkOrderRequestStatusEnum>[
  _$transitionWorkOrderRequestStatusEnum_scheduled,
  _$transitionWorkOrderRequestStatusEnum_inProgress,
  _$transitionWorkOrderRequestStatusEnum_completed,
  _$transitionWorkOrderRequestStatusEnum_cancelled,
  _$transitionWorkOrderRequestStatusEnum_unknownDefaultOpenApi,
]);

Serializer<TransitionWorkOrderRequestStatusEnum>
    _$transitionWorkOrderRequestStatusEnumSerializer =
    _$TransitionWorkOrderRequestStatusEnumSerializer();

class _$TransitionWorkOrderRequestStatusEnumSerializer
    implements PrimitiveSerializer<TransitionWorkOrderRequestStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'scheduled': 'scheduled',
    'inProgress': 'in_progress',
    'completed': 'completed',
    'cancelled': 'cancelled',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'scheduled': 'scheduled',
    'in_progress': 'inProgress',
    'completed': 'completed',
    'cancelled': 'cancelled',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TransitionWorkOrderRequestStatusEnum
  ];
  @override
  final String wireName = 'TransitionWorkOrderRequestStatusEnum';

  @override
  Object serialize(
          Serializers serializers, TransitionWorkOrderRequestStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransitionWorkOrderRequestStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransitionWorkOrderRequestStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TransitionWorkOrderRequest extends TransitionWorkOrderRequest {
  @override
  final TransitionWorkOrderRequestStatusEnum status;
  @override
  final String? note;

  factory _$TransitionWorkOrderRequest(
          [void Function(TransitionWorkOrderRequestBuilder)? updates]) =>
      (TransitionWorkOrderRequestBuilder()..update(updates))._build();

  _$TransitionWorkOrderRequest._({required this.status, this.note}) : super._();
  @override
  TransitionWorkOrderRequest rebuild(
          void Function(TransitionWorkOrderRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransitionWorkOrderRequestBuilder toBuilder() =>
      TransitionWorkOrderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransitionWorkOrderRequest &&
        status == other.status &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransitionWorkOrderRequest')
          ..add('status', status)
          ..add('note', note))
        .toString();
  }
}

class TransitionWorkOrderRequestBuilder
    implements
        Builder<TransitionWorkOrderRequest, TransitionWorkOrderRequestBuilder> {
  _$TransitionWorkOrderRequest? _$v;

  TransitionWorkOrderRequestStatusEnum? _status;
  TransitionWorkOrderRequestStatusEnum? get status => _$this._status;
  set status(TransitionWorkOrderRequestStatusEnum? status) =>
      _$this._status = status;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  TransitionWorkOrderRequestBuilder() {
    TransitionWorkOrderRequest._defaults(this);
  }

  TransitionWorkOrderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransitionWorkOrderRequest other) {
    _$v = other as _$TransitionWorkOrderRequest;
  }

  @override
  void update(void Function(TransitionWorkOrderRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransitionWorkOrderRequest build() => _build();

  _$TransitionWorkOrderRequest _build() {
    final _$result = _$v ??
        _$TransitionWorkOrderRequest._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'TransitionWorkOrderRequest', 'status'),
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
