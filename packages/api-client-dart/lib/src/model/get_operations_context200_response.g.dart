// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_operations_context200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetOperationsContext200Response
    extends GetOperationsContext200Response {
  @override
  final BuiltList<OperationsContext> data;

  factory _$GetOperationsContext200Response(
          [void Function(GetOperationsContext200ResponseBuilder)? updates]) =>
      (GetOperationsContext200ResponseBuilder()..update(updates))._build();

  _$GetOperationsContext200Response._({required this.data}) : super._();
  @override
  GetOperationsContext200Response rebuild(
          void Function(GetOperationsContext200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetOperationsContext200ResponseBuilder toBuilder() =>
      GetOperationsContext200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetOperationsContext200Response && data == other.data;
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
    return (newBuiltValueToStringHelper(r'GetOperationsContext200Response')
          ..add('data', data))
        .toString();
  }
}

class GetOperationsContext200ResponseBuilder
    implements
        Builder<GetOperationsContext200Response,
            GetOperationsContext200ResponseBuilder> {
  _$GetOperationsContext200Response? _$v;

  ListBuilder<OperationsContext>? _data;
  ListBuilder<OperationsContext> get data =>
      _$this._data ??= ListBuilder<OperationsContext>();
  set data(ListBuilder<OperationsContext>? data) => _$this._data = data;

  GetOperationsContext200ResponseBuilder() {
    GetOperationsContext200Response._defaults(this);
  }

  GetOperationsContext200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetOperationsContext200Response other) {
    _$v = other as _$GetOperationsContext200Response;
  }

  @override
  void update(void Function(GetOperationsContext200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetOperationsContext200Response build() => _build();

  _$GetOperationsContext200Response _build() {
    _$GetOperationsContext200Response _$result;
    try {
      _$result = _$v ??
          _$GetOperationsContext200Response._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetOperationsContext200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
