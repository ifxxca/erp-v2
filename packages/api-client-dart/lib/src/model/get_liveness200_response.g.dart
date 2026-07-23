// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_liveness200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetLiveness200Response extends GetLiveness200Response {
  @override
  final JsonObject? status;
  @override
  final DateTime checkedAt;

  factory _$GetLiveness200Response(
          [void Function(GetLiveness200ResponseBuilder)? updates]) =>
      (GetLiveness200ResponseBuilder()..update(updates))._build();

  _$GetLiveness200Response._({this.status, required this.checkedAt})
      : super._();
  @override
  GetLiveness200Response rebuild(
          void Function(GetLiveness200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetLiveness200ResponseBuilder toBuilder() =>
      GetLiveness200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetLiveness200Response &&
        status == other.status &&
        checkedAt == other.checkedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, checkedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetLiveness200Response')
          ..add('status', status)
          ..add('checkedAt', checkedAt))
        .toString();
  }
}

class GetLiveness200ResponseBuilder
    implements Builder<GetLiveness200Response, GetLiveness200ResponseBuilder> {
  _$GetLiveness200Response? _$v;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(JsonObject? status) => _$this._status = status;

  DateTime? _checkedAt;
  DateTime? get checkedAt => _$this._checkedAt;
  set checkedAt(DateTime? checkedAt) => _$this._checkedAt = checkedAt;

  GetLiveness200ResponseBuilder() {
    GetLiveness200Response._defaults(this);
  }

  GetLiveness200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _checkedAt = $v.checkedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetLiveness200Response other) {
    _$v = other as _$GetLiveness200Response;
  }

  @override
  void update(void Function(GetLiveness200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetLiveness200Response build() => _build();

  _$GetLiveness200Response _build() {
    final _$result = _$v ??
        _$GetLiveness200Response._(
          status: status,
          checkedAt: BuiltValueNullFieldError.checkNotNull(
              checkedAt, r'GetLiveness200Response', 'checkedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
