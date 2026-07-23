// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_invitation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateInvitationRequest extends CreateInvitationRequest {
  @override
  final String name;
  @override
  final String email;
  @override
  final String companyId;
  @override
  final String? employeeNo;
  @override
  final BuiltSet<String> departmentIds;
  @override
  final String primaryDepartmentId;
  @override
  final BuiltSet<String>? locationIds;
  @override
  final Date validFrom;

  factory _$CreateInvitationRequest(
          [void Function(CreateInvitationRequestBuilder)? updates]) =>
      (CreateInvitationRequestBuilder()..update(updates))._build();

  _$CreateInvitationRequest._(
      {required this.name,
      required this.email,
      required this.companyId,
      this.employeeNo,
      required this.departmentIds,
      required this.primaryDepartmentId,
      this.locationIds,
      required this.validFrom})
      : super._();
  @override
  CreateInvitationRequest rebuild(
          void Function(CreateInvitationRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateInvitationRequestBuilder toBuilder() =>
      CreateInvitationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateInvitationRequest &&
        name == other.name &&
        email == other.email &&
        companyId == other.companyId &&
        employeeNo == other.employeeNo &&
        departmentIds == other.departmentIds &&
        primaryDepartmentId == other.primaryDepartmentId &&
        locationIds == other.locationIds &&
        validFrom == other.validFrom;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, companyId.hashCode);
    _$hash = $jc(_$hash, employeeNo.hashCode);
    _$hash = $jc(_$hash, departmentIds.hashCode);
    _$hash = $jc(_$hash, primaryDepartmentId.hashCode);
    _$hash = $jc(_$hash, locationIds.hashCode);
    _$hash = $jc(_$hash, validFrom.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateInvitationRequest')
          ..add('name', name)
          ..add('email', email)
          ..add('companyId', companyId)
          ..add('employeeNo', employeeNo)
          ..add('departmentIds', departmentIds)
          ..add('primaryDepartmentId', primaryDepartmentId)
          ..add('locationIds', locationIds)
          ..add('validFrom', validFrom))
        .toString();
  }
}

class CreateInvitationRequestBuilder
    implements
        Builder<CreateInvitationRequest, CreateInvitationRequestBuilder> {
  _$CreateInvitationRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _companyId;
  String? get companyId => _$this._companyId;
  set companyId(String? companyId) => _$this._companyId = companyId;

  String? _employeeNo;
  String? get employeeNo => _$this._employeeNo;
  set employeeNo(String? employeeNo) => _$this._employeeNo = employeeNo;

  SetBuilder<String>? _departmentIds;
  SetBuilder<String> get departmentIds =>
      _$this._departmentIds ??= SetBuilder<String>();
  set departmentIds(SetBuilder<String>? departmentIds) =>
      _$this._departmentIds = departmentIds;

  String? _primaryDepartmentId;
  String? get primaryDepartmentId => _$this._primaryDepartmentId;
  set primaryDepartmentId(String? primaryDepartmentId) =>
      _$this._primaryDepartmentId = primaryDepartmentId;

  SetBuilder<String>? _locationIds;
  SetBuilder<String> get locationIds =>
      _$this._locationIds ??= SetBuilder<String>();
  set locationIds(SetBuilder<String>? locationIds) =>
      _$this._locationIds = locationIds;

  Date? _validFrom;
  Date? get validFrom => _$this._validFrom;
  set validFrom(Date? validFrom) => _$this._validFrom = validFrom;

  CreateInvitationRequestBuilder() {
    CreateInvitationRequest._defaults(this);
  }

  CreateInvitationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _email = $v.email;
      _companyId = $v.companyId;
      _employeeNo = $v.employeeNo;
      _departmentIds = $v.departmentIds.toBuilder();
      _primaryDepartmentId = $v.primaryDepartmentId;
      _locationIds = $v.locationIds?.toBuilder();
      _validFrom = $v.validFrom;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateInvitationRequest other) {
    _$v = other as _$CreateInvitationRequest;
  }

  @override
  void update(void Function(CreateInvitationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateInvitationRequest build() => _build();

  _$CreateInvitationRequest _build() {
    _$CreateInvitationRequest _$result;
    try {
      _$result = _$v ??
          _$CreateInvitationRequest._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'CreateInvitationRequest', 'name'),
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'CreateInvitationRequest', 'email'),
            companyId: BuiltValueNullFieldError.checkNotNull(
                companyId, r'CreateInvitationRequest', 'companyId'),
            employeeNo: employeeNo,
            departmentIds: departmentIds.build(),
            primaryDepartmentId: BuiltValueNullFieldError.checkNotNull(
                primaryDepartmentId,
                r'CreateInvitationRequest',
                'primaryDepartmentId'),
            locationIds: _locationIds?.build(),
            validFrom: BuiltValueNullFieldError.checkNotNull(
                validFrom, r'CreateInvitationRequest', 'validFrom'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'departmentIds';
        departmentIds.build();

        _$failedField = 'locationIds';
        _locationIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateInvitationRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
