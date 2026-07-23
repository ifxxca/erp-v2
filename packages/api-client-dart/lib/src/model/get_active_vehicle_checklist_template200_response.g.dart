// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_active_vehicle_checklist_template200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetActiveVehicleChecklistTemplate200Response
    extends GetActiveVehicleChecklistTemplate200Response {
  @override
  final ChecklistTemplate? data;

  factory _$GetActiveVehicleChecklistTemplate200Response(
          [void Function(GetActiveVehicleChecklistTemplate200ResponseBuilder)?
              updates]) =>
      (GetActiveVehicleChecklistTemplate200ResponseBuilder()..update(updates))
          ._build();

  _$GetActiveVehicleChecklistTemplate200Response._({this.data}) : super._();
  @override
  GetActiveVehicleChecklistTemplate200Response rebuild(
          void Function(GetActiveVehicleChecklistTemplate200ResponseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetActiveVehicleChecklistTemplate200ResponseBuilder toBuilder() =>
      GetActiveVehicleChecklistTemplate200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetActiveVehicleChecklistTemplate200Response &&
        data == other.data;
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
            r'GetActiveVehicleChecklistTemplate200Response')
          ..add('data', data))
        .toString();
  }
}

class GetActiveVehicleChecklistTemplate200ResponseBuilder
    implements
        Builder<GetActiveVehicleChecklistTemplate200Response,
            GetActiveVehicleChecklistTemplate200ResponseBuilder> {
  _$GetActiveVehicleChecklistTemplate200Response? _$v;

  ChecklistTemplateBuilder? _data;
  ChecklistTemplateBuilder get data =>
      _$this._data ??= ChecklistTemplateBuilder();
  set data(ChecklistTemplateBuilder? data) => _$this._data = data;

  GetActiveVehicleChecklistTemplate200ResponseBuilder() {
    GetActiveVehicleChecklistTemplate200Response._defaults(this);
  }

  GetActiveVehicleChecklistTemplate200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetActiveVehicleChecklistTemplate200Response other) {
    _$v = other as _$GetActiveVehicleChecklistTemplate200Response;
  }

  @override
  void update(
      void Function(GetActiveVehicleChecklistTemplate200ResponseBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GetActiveVehicleChecklistTemplate200Response build() => _build();

  _$GetActiveVehicleChecklistTemplate200Response _build() {
    _$GetActiveVehicleChecklistTemplate200Response _$result;
    try {
      _$result = _$v ??
          _$GetActiveVehicleChecklistTemplate200Response._(
            data: _data?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetActiveVehicleChecklistTemplate200Response',
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
