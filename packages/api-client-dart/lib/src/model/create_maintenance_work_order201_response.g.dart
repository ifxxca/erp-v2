// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_maintenance_work_order201_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateMaintenanceWorkOrder201Response
    extends CreateMaintenanceWorkOrder201Response {
  @override
  final MaintenanceWorkOrder? data;

  factory _$CreateMaintenanceWorkOrder201Response(
          [void Function(CreateMaintenanceWorkOrder201ResponseBuilder)?
              updates]) =>
      (CreateMaintenanceWorkOrder201ResponseBuilder()..update(updates))
          ._build();

  _$CreateMaintenanceWorkOrder201Response._({this.data}) : super._();
  @override
  CreateMaintenanceWorkOrder201Response rebuild(
          void Function(CreateMaintenanceWorkOrder201ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateMaintenanceWorkOrder201ResponseBuilder toBuilder() =>
      CreateMaintenanceWorkOrder201ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateMaintenanceWorkOrder201Response && data == other.data;
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
    return (newBuiltValueToStringHelper(
            r'CreateMaintenanceWorkOrder201Response')
          ..add('data', data))
        .toString();
  }
}

class CreateMaintenanceWorkOrder201ResponseBuilder
    implements
        Builder<CreateMaintenanceWorkOrder201Response,
            CreateMaintenanceWorkOrder201ResponseBuilder> {
  _$CreateMaintenanceWorkOrder201Response? _$v;

  MaintenanceWorkOrderBuilder? _data;
  MaintenanceWorkOrderBuilder get data =>
      _$this._data ??= MaintenanceWorkOrderBuilder();
  set data(MaintenanceWorkOrderBuilder? data) => _$this._data = data;

  CreateMaintenanceWorkOrder201ResponseBuilder() {
    CreateMaintenanceWorkOrder201Response._defaults(this);
  }

  CreateMaintenanceWorkOrder201ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateMaintenanceWorkOrder201Response other) {
    _$v = other as _$CreateMaintenanceWorkOrder201Response;
  }

  @override
  void update(
      void Function(CreateMaintenanceWorkOrder201ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateMaintenanceWorkOrder201Response build() => _build();

  _$CreateMaintenanceWorkOrder201Response _build() {
    _$CreateMaintenanceWorkOrder201Response _$result;
    try {
      _$result = _$v ??
          _$CreateMaintenanceWorkOrder201Response._(
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateMaintenanceWorkOrder201Response',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
