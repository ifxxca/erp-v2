// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_access_catalog_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StandardAccessCatalogResponseData
    extends StandardAccessCatalogResponseData {
  @override
  final BuiltList<StandardAccessRole> roles;
  @override
  final BuiltList<StandardRoleAssignment> assignments;

  factory _$StandardAccessCatalogResponseData(
          [void Function(StandardAccessCatalogResponseDataBuilder)? updates]) =>
      (StandardAccessCatalogResponseDataBuilder()..update(updates))._build();

  _$StandardAccessCatalogResponseData._(
      {required this.roles, required this.assignments})
      : super._();
  @override
  StandardAccessCatalogResponseData rebuild(
          void Function(StandardAccessCatalogResponseDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StandardAccessCatalogResponseDataBuilder toBuilder() =>
      StandardAccessCatalogResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StandardAccessCatalogResponseData &&
        roles == other.roles &&
        assignments == other.assignments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, roles.hashCode);
    _$hash = $jc(_$hash, assignments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StandardAccessCatalogResponseData')
          ..add('roles', roles)
          ..add('assignments', assignments))
        .toString();
  }
}

class StandardAccessCatalogResponseDataBuilder
    implements
        Builder<StandardAccessCatalogResponseData,
            StandardAccessCatalogResponseDataBuilder> {
  _$StandardAccessCatalogResponseData? _$v;

  ListBuilder<StandardAccessRole>? _roles;
  ListBuilder<StandardAccessRole> get roles =>
      _$this._roles ??= ListBuilder<StandardAccessRole>();
  set roles(ListBuilder<StandardAccessRole>? roles) => _$this._roles = roles;

  ListBuilder<StandardRoleAssignment>? _assignments;
  ListBuilder<StandardRoleAssignment> get assignments =>
      _$this._assignments ??= ListBuilder<StandardRoleAssignment>();
  set assignments(ListBuilder<StandardRoleAssignment>? assignments) =>
      _$this._assignments = assignments;

  StandardAccessCatalogResponseDataBuilder() {
    StandardAccessCatalogResponseData._defaults(this);
  }

  StandardAccessCatalogResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _roles = $v.roles.toBuilder();
      _assignments = $v.assignments.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StandardAccessCatalogResponseData other) {
    _$v = other as _$StandardAccessCatalogResponseData;
  }

  @override
  void update(
      void Function(StandardAccessCatalogResponseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StandardAccessCatalogResponseData build() => _build();

  _$StandardAccessCatalogResponseData _build() {
    _$StandardAccessCatalogResponseData _$result;
    try {
      _$result = _$v ??
          _$StandardAccessCatalogResponseData._(
            roles: roles.build(),
            assignments: assignments.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'roles';
        roles.build();
        _$failedField = 'assignments';
        assignments.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'StandardAccessCatalogResponseData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
