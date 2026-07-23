// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_assignment_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RoleAssignmentPage extends RoleAssignmentPage {
  @override
  final BuiltList<PrivilegedRoleAssignment> data;
  @override
  final int currentPage;
  @override
  final int lastPage;
  @override
  final int perPage;
  @override
  final int total;

  factory _$RoleAssignmentPage(
          [void Function(RoleAssignmentPageBuilder)? updates]) =>
      (RoleAssignmentPageBuilder()..update(updates))._build();

  _$RoleAssignmentPage._(
      {required this.data,
      required this.currentPage,
      required this.lastPage,
      required this.perPage,
      required this.total})
      : super._();
  @override
  RoleAssignmentPage rebuild(
          void Function(RoleAssignmentPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoleAssignmentPageBuilder toBuilder() =>
      RoleAssignmentPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoleAssignmentPage &&
        data == other.data &&
        currentPage == other.currentPage &&
        lastPage == other.lastPage &&
        perPage == other.perPage &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, currentPage.hashCode);
    _$hash = $jc(_$hash, lastPage.hashCode);
    _$hash = $jc(_$hash, perPage.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RoleAssignmentPage')
          ..add('data', data)
          ..add('currentPage', currentPage)
          ..add('lastPage', lastPage)
          ..add('perPage', perPage)
          ..add('total', total))
        .toString();
  }
}

class RoleAssignmentPageBuilder
    implements Builder<RoleAssignmentPage, RoleAssignmentPageBuilder> {
  _$RoleAssignmentPage? _$v;

  ListBuilder<PrivilegedRoleAssignment>? _data;
  ListBuilder<PrivilegedRoleAssignment> get data =>
      _$this._data ??= ListBuilder<PrivilegedRoleAssignment>();
  set data(ListBuilder<PrivilegedRoleAssignment>? data) => _$this._data = data;

  int? _currentPage;
  int? get currentPage => _$this._currentPage;
  set currentPage(int? currentPage) => _$this._currentPage = currentPage;

  int? _lastPage;
  int? get lastPage => _$this._lastPage;
  set lastPage(int? lastPage) => _$this._lastPage = lastPage;

  int? _perPage;
  int? get perPage => _$this._perPage;
  set perPage(int? perPage) => _$this._perPage = perPage;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  RoleAssignmentPageBuilder() {
    RoleAssignmentPage._defaults(this);
  }

  RoleAssignmentPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _currentPage = $v.currentPage;
      _lastPage = $v.lastPage;
      _perPage = $v.perPage;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RoleAssignmentPage other) {
    _$v = other as _$RoleAssignmentPage;
  }

  @override
  void update(void Function(RoleAssignmentPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RoleAssignmentPage build() => _build();

  _$RoleAssignmentPage _build() {
    _$RoleAssignmentPage _$result;
    try {
      _$result = _$v ??
          _$RoleAssignmentPage._(
            data: data.build(),
            currentPage: BuiltValueNullFieldError.checkNotNull(
                currentPage, r'RoleAssignmentPage', 'currentPage'),
            lastPage: BuiltValueNullFieldError.checkNotNull(
                lastPage, r'RoleAssignmentPage', 'lastPage'),
            perPage: BuiltValueNullFieldError.checkNotNull(
                perPage, r'RoleAssignmentPage', 'perPage'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'RoleAssignmentPage', 'total'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RoleAssignmentPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
