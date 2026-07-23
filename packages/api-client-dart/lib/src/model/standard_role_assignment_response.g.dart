// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_role_assignment_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StandardRoleAssignmentResponse extends StandardRoleAssignmentResponse {
  @override
  final StandardRoleAssignment data;

  factory _$StandardRoleAssignmentResponse(
          [void Function(StandardRoleAssignmentResponseBuilder)? updates]) =>
      (StandardRoleAssignmentResponseBuilder()..update(updates))._build();

  _$StandardRoleAssignmentResponse._({required this.data}) : super._();
  @override
  StandardRoleAssignmentResponse rebuild(
          void Function(StandardRoleAssignmentResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StandardRoleAssignmentResponseBuilder toBuilder() =>
      StandardRoleAssignmentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StandardRoleAssignmentResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'StandardRoleAssignmentResponse')
          ..add('data', data))
        .toString();
  }
}

class StandardRoleAssignmentResponseBuilder
    implements
        Builder<StandardRoleAssignmentResponse,
            StandardRoleAssignmentResponseBuilder> {
  _$StandardRoleAssignmentResponse? _$v;

  StandardRoleAssignmentBuilder? _data;
  StandardRoleAssignmentBuilder get data =>
      _$this._data ??= StandardRoleAssignmentBuilder();
  set data(StandardRoleAssignmentBuilder? data) => _$this._data = data;

  StandardRoleAssignmentResponseBuilder() {
    StandardRoleAssignmentResponse._defaults(this);
  }

  StandardRoleAssignmentResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StandardRoleAssignmentResponse other) {
    _$v = other as _$StandardRoleAssignmentResponse;
  }

  @override
  void update(void Function(StandardRoleAssignmentResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StandardRoleAssignmentResponse build() => _build();

  _$StandardRoleAssignmentResponse _build() {
    _$StandardRoleAssignmentResponse _$result;
    try {
      _$result = _$v ??
          _$StandardRoleAssignmentResponse._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StandardRoleAssignmentResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
