// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_catalog.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrganizationCatalog extends OrganizationCatalog {
  @override
  final CompanySummary company;
  @override
  final BuiltList<DepartmentSummary> departments;
  @override
  final BuiltList<LocationSummary> locations;

  factory _$OrganizationCatalog(
          [void Function(OrganizationCatalogBuilder)? updates]) =>
      (OrganizationCatalogBuilder()..update(updates))._build();

  _$OrganizationCatalog._(
      {required this.company,
      required this.departments,
      required this.locations})
      : super._();
  @override
  OrganizationCatalog rebuild(
          void Function(OrganizationCatalogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrganizationCatalogBuilder toBuilder() =>
      OrganizationCatalogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrganizationCatalog &&
        company == other.company &&
        departments == other.departments &&
        locations == other.locations;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, company.hashCode);
    _$hash = $jc(_$hash, departments.hashCode);
    _$hash = $jc(_$hash, locations.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrganizationCatalog')
          ..add('company', company)
          ..add('departments', departments)
          ..add('locations', locations))
        .toString();
  }
}

class OrganizationCatalogBuilder
    implements Builder<OrganizationCatalog, OrganizationCatalogBuilder> {
  _$OrganizationCatalog? _$v;

  CompanySummary? _company;
  CompanySummary? get company => _$this._company;
  set company(CompanySummary? company) => _$this._company = company;

  ListBuilder<DepartmentSummary>? _departments;
  ListBuilder<DepartmentSummary> get departments =>
      _$this._departments ??= ListBuilder<DepartmentSummary>();
  set departments(ListBuilder<DepartmentSummary>? departments) =>
      _$this._departments = departments;

  ListBuilder<LocationSummary>? _locations;
  ListBuilder<LocationSummary> get locations =>
      _$this._locations ??= ListBuilder<LocationSummary>();
  set locations(ListBuilder<LocationSummary>? locations) =>
      _$this._locations = locations;

  OrganizationCatalogBuilder() {
    OrganizationCatalog._defaults(this);
  }

  OrganizationCatalogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _company = $v.company;
      _departments = $v.departments.toBuilder();
      _locations = $v.locations.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrganizationCatalog other) {
    _$v = other as _$OrganizationCatalog;
  }

  @override
  void update(void Function(OrganizationCatalogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrganizationCatalog build() => _build();

  _$OrganizationCatalog _build() {
    _$OrganizationCatalog _$result;
    try {
      _$result = _$v ??
          _$OrganizationCatalog._(
            company: BuiltValueNullFieldError.checkNotNull(
                company, r'OrganizationCatalog', 'company'),
            departments: departments.build(),
            locations: locations.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'departments';
        departments.build();
        _$failedField = 'locations';
        locations.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'OrganizationCatalog', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
