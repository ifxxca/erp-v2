// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_sessions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListSessions200Response extends ListSessions200Response {
  @override
  final BuiltList<DeviceSession> data;

  factory _$ListSessions200Response(
          [void Function(ListSessions200ResponseBuilder)? updates]) =>
      (ListSessions200ResponseBuilder()..update(updates))._build();

  _$ListSessions200Response._({required this.data}) : super._();
  @override
  ListSessions200Response rebuild(
          void Function(ListSessions200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListSessions200ResponseBuilder toBuilder() =>
      ListSessions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListSessions200Response && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ListSessions200Response')
          ..add('data', data))
        .toString();
  }
}

class ListSessions200ResponseBuilder
    implements
        Builder<ListSessions200Response, ListSessions200ResponseBuilder> {
  _$ListSessions200Response? _$v;

  ListBuilder<DeviceSession>? _data;
  ListBuilder<DeviceSession> get data =>
      _$this._data ??= ListBuilder<DeviceSession>();
  set data(ListBuilder<DeviceSession>? data) => _$this._data = data;

  ListSessions200ResponseBuilder() {
    ListSessions200Response._defaults(this);
  }

  ListSessions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListSessions200Response other) {
    _$v = other as _$ListSessions200Response;
  }

  @override
  void update(void Function(ListSessions200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListSessions200Response build() => _build();

  _$ListSessions200Response _build() {
    _$ListSessions200Response _$result;
    try {
      _$result = _$v ??
          _$ListSessions200Response._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ListSessions200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
