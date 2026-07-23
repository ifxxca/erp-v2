// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_mutation_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RoleMutationResponse extends RoleMutationResponse {
  @override
  final RoleMutationResponseData data;

  factory _$RoleMutationResponse(
          [void Function(RoleMutationResponseBuilder)? updates]) =>
      (RoleMutationResponseBuilder()..update(updates))._build();

  _$RoleMutationResponse._({required this.data}) : super._();
  @override
  RoleMutationResponse rebuild(
          void Function(RoleMutationResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoleMutationResponseBuilder toBuilder() =>
      RoleMutationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoleMutationResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'RoleMutationResponse')
          ..add('data', data))
        .toString();
  }
}

class RoleMutationResponseBuilder
    implements Builder<RoleMutationResponse, RoleMutationResponseBuilder> {
  _$RoleMutationResponse? _$v;

  RoleMutationResponseDataBuilder? _data;
  RoleMutationResponseDataBuilder get data =>
      _$this._data ??= RoleMutationResponseDataBuilder();
  set data(RoleMutationResponseDataBuilder? data) => _$this._data = data;

  RoleMutationResponseBuilder() {
    RoleMutationResponse._defaults(this);
  }

  RoleMutationResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RoleMutationResponse other) {
    _$v = other as _$RoleMutationResponse;
  }

  @override
  void update(void Function(RoleMutationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RoleMutationResponse build() => _build();

  _$RoleMutationResponse _build() {
    _$RoleMutationResponse _$result;
    try {
      _$result = _$v ??
          _$RoleMutationResponse._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RoleMutationResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
