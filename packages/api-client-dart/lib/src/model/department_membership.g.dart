// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_membership.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DepartmentMembership extends DepartmentMembership {
  @override
  final String id;
  @override
  final DepartmentSummary department;
  @override
  final bool isPrimary;
  @override
  final Date validFrom;
  @override
  final Date? validUntil;

  factory _$DepartmentMembership(
          [void Function(DepartmentMembershipBuilder)? updates]) =>
      (DepartmentMembershipBuilder()..update(updates))._build();

  _$DepartmentMembership._(
      {required this.id,
      required this.department,
      required this.isPrimary,
      required this.validFrom,
      this.validUntil})
      : super._();
  @override
  DepartmentMembership rebuild(
          void Function(DepartmentMembershipBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepartmentMembershipBuilder toBuilder() =>
      DepartmentMembershipBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepartmentMembership &&
        id == other.id &&
        department == other.department &&
        isPrimary == other.isPrimary &&
        validFrom == other.validFrom &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, isPrimary.hashCode);
    _$hash = $jc(_$hash, validFrom.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DepartmentMembership')
          ..add('id', id)
          ..add('department', department)
          ..add('isPrimary', isPrimary)
          ..add('validFrom', validFrom)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class DepartmentMembershipBuilder
    implements Builder<DepartmentMembership, DepartmentMembershipBuilder> {
  _$DepartmentMembership? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DepartmentSummaryBuilder? _department;
  DepartmentSummaryBuilder get department =>
      _$this._department ??= DepartmentSummaryBuilder();
  set department(DepartmentSummaryBuilder? department) =>
      _$this._department = department;

  bool? _isPrimary;
  bool? get isPrimary => _$this._isPrimary;
  set isPrimary(bool? isPrimary) => _$this._isPrimary = isPrimary;

  Date? _validFrom;
  Date? get validFrom => _$this._validFrom;
  set validFrom(Date? validFrom) => _$this._validFrom = validFrom;

  Date? _validUntil;
  Date? get validUntil => _$this._validUntil;
  set validUntil(Date? validUntil) => _$this._validUntil = validUntil;

  DepartmentMembershipBuilder() {
    DepartmentMembership._defaults(this);
  }

  DepartmentMembershipBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _department = $v.department.toBuilder();
      _isPrimary = $v.isPrimary;
      _validFrom = $v.validFrom;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepartmentMembership other) {
    _$v = other as _$DepartmentMembership;
  }

  @override
  void update(void Function(DepartmentMembershipBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepartmentMembership build() => _build();

  _$DepartmentMembership _build() {
    _$DepartmentMembership _$result;
    try {
      _$result = _$v ??
          _$DepartmentMembership._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'DepartmentMembership', 'id'),
            department: department.build(),
            isPrimary: BuiltValueNullFieldError.checkNotNull(
                isPrimary, r'DepartmentMembership', 'isPrimary'),
            validFrom: BuiltValueNullFieldError.checkNotNull(
                validFrom, r'DepartmentMembership', 'validFrom'),
            validUntil: validUntil,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'department';
        department.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DepartmentMembership', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
