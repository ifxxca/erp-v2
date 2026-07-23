// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_request_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccessRequestPage extends AccessRequestPage {
  @override
  final BuiltList<PrivilegedAccessRequest> data;
  @override
  final int currentPage;
  @override
  final int lastPage;
  @override
  final int perPage;
  @override
  final int total;

  factory _$AccessRequestPage(
          [void Function(AccessRequestPageBuilder)? updates]) =>
      (AccessRequestPageBuilder()..update(updates))._build();

  _$AccessRequestPage._(
      {required this.data,
      required this.currentPage,
      required this.lastPage,
      required this.perPage,
      required this.total})
      : super._();
  @override
  AccessRequestPage rebuild(void Function(AccessRequestPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccessRequestPageBuilder toBuilder() =>
      AccessRequestPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccessRequestPage &&
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
    return (newBuiltValueToStringHelper(r'AccessRequestPage')
          ..add('data', data)
          ..add('currentPage', currentPage)
          ..add('lastPage', lastPage)
          ..add('perPage', perPage)
          ..add('total', total))
        .toString();
  }
}

class AccessRequestPageBuilder
    implements Builder<AccessRequestPage, AccessRequestPageBuilder> {
  _$AccessRequestPage? _$v;

  ListBuilder<PrivilegedAccessRequest>? _data;
  ListBuilder<PrivilegedAccessRequest> get data =>
      _$this._data ??= ListBuilder<PrivilegedAccessRequest>();
  set data(ListBuilder<PrivilegedAccessRequest>? data) => _$this._data = data;

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

  AccessRequestPageBuilder() {
    AccessRequestPage._defaults(this);
  }

  AccessRequestPageBuilder get _$this {
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
  void replace(AccessRequestPage other) {
    _$v = other as _$AccessRequestPage;
  }

  @override
  void update(void Function(AccessRequestPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccessRequestPage build() => _build();

  _$AccessRequestPage _build() {
    _$AccessRequestPage _$result;
    try {
      _$result = _$v ??
          _$AccessRequestPage._(
            data: data.build(),
            currentPage: BuiltValueNullFieldError.checkNotNull(
                currentPage, r'AccessRequestPage', 'currentPage'),
            lastPage: BuiltValueNullFieldError.checkNotNull(
                lastPage, r'AccessRequestPage', 'lastPage'),
            perPage: BuiltValueNullFieldError.checkNotNull(
                perPage, r'AccessRequestPage', 'perPage'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'AccessRequestPage', 'total'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AccessRequestPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
