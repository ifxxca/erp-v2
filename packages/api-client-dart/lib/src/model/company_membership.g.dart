// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_membership.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CompanyMembership extends CompanyMembership {
  @override
  final String id;
  @override
  final String? employeeNo;
  @override
  final EmploymentStatus employmentStatus;
  @override
  final bool isPrimary;
  @override
  final Date validFrom;
  @override
  final Date? validUntil;

  factory _$CompanyMembership(
          [void Function(CompanyMembershipBuilder)? updates]) =>
      (CompanyMembershipBuilder()..update(updates))._build();

  _$CompanyMembership._(
      {required this.id,
      this.employeeNo,
      required this.employmentStatus,
      required this.isPrimary,
      required this.validFrom,
      this.validUntil})
      : super._();
  @override
  CompanyMembership rebuild(void Function(CompanyMembershipBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompanyMembershipBuilder toBuilder() =>
      CompanyMembershipBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompanyMembership &&
        id == other.id &&
        employeeNo == other.employeeNo &&
        employmentStatus == other.employmentStatus &&
        isPrimary == other.isPrimary &&
        validFrom == other.validFrom &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, employeeNo.hashCode);
    _$hash = $jc(_$hash, employmentStatus.hashCode);
    _$hash = $jc(_$hash, isPrimary.hashCode);
    _$hash = $jc(_$hash, validFrom.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CompanyMembership')
          ..add('id', id)
          ..add('employeeNo', employeeNo)
          ..add('employmentStatus', employmentStatus)
          ..add('isPrimary', isPrimary)
          ..add('validFrom', validFrom)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class CompanyMembershipBuilder
    implements Builder<CompanyMembership, CompanyMembershipBuilder> {
  _$CompanyMembership? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _employeeNo;
  String? get employeeNo => _$this._employeeNo;
  set employeeNo(String? employeeNo) => _$this._employeeNo = employeeNo;

  EmploymentStatus? _employmentStatus;
  EmploymentStatus? get employmentStatus => _$this._employmentStatus;
  set employmentStatus(EmploymentStatus? employmentStatus) =>
      _$this._employmentStatus = employmentStatus;

  bool? _isPrimary;
  bool? get isPrimary => _$this._isPrimary;
  set isPrimary(bool? isPrimary) => _$this._isPrimary = isPrimary;

  Date? _validFrom;
  Date? get validFrom => _$this._validFrom;
  set validFrom(Date? validFrom) => _$this._validFrom = validFrom;

  Date? _validUntil;
  Date? get validUntil => _$this._validUntil;
  set validUntil(Date? validUntil) => _$this._validUntil = validUntil;

  CompanyMembershipBuilder() {
    CompanyMembership._defaults(this);
  }

  CompanyMembershipBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _employeeNo = $v.employeeNo;
      _employmentStatus = $v.employmentStatus;
      _isPrimary = $v.isPrimary;
      _validFrom = $v.validFrom;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompanyMembership other) {
    _$v = other as _$CompanyMembership;
  }

  @override
  void update(void Function(CompanyMembershipBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CompanyMembership build() => _build();

  _$CompanyMembership _build() {
    final _$result = _$v ??
        _$CompanyMembership._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'CompanyMembership', 'id'),
          employeeNo: employeeNo,
          employmentStatus: BuiltValueNullFieldError.checkNotNull(
              employmentStatus, r'CompanyMembership', 'employmentStatus'),
          isPrimary: BuiltValueNullFieldError.checkNotNull(
              isPrimary, r'CompanyMembership', 'isPrimary'),
          validFrom: BuiltValueNullFieldError.checkNotNull(
              validFrom, r'CompanyMembership', 'validFrom'),
          validUntil: validUntil,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
