// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkOrderPage extends WorkOrderPage {
  @override
  final BuiltList<MaintenanceWorkOrder> data;
  @override
  final int currentPage;
  @override
  final int lastPage;
  @override
  final int total;

  factory _$WorkOrderPage([void Function(WorkOrderPageBuilder)? updates]) =>
      (WorkOrderPageBuilder()..update(updates))._build();

  _$WorkOrderPage._(
      {required this.data,
      required this.currentPage,
      required this.lastPage,
      required this.total})
      : super._();
  @override
  WorkOrderPage rebuild(void Function(WorkOrderPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkOrderPageBuilder toBuilder() => WorkOrderPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkOrderPage &&
        data == other.data &&
        currentPage == other.currentPage &&
        lastPage == other.lastPage &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, currentPage.hashCode);
    _$hash = $jc(_$hash, lastPage.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkOrderPage')
          ..add('data', data)
          ..add('currentPage', currentPage)
          ..add('lastPage', lastPage)
          ..add('total', total))
        .toString();
  }
}

class WorkOrderPageBuilder
    implements Builder<WorkOrderPage, WorkOrderPageBuilder> {
  _$WorkOrderPage? _$v;

  ListBuilder<MaintenanceWorkOrder>? _data;
  ListBuilder<MaintenanceWorkOrder> get data =>
      _$this._data ??= ListBuilder<MaintenanceWorkOrder>();
  set data(ListBuilder<MaintenanceWorkOrder>? data) => _$this._data = data;

  int? _currentPage;
  int? get currentPage => _$this._currentPage;
  set currentPage(int? currentPage) => _$this._currentPage = currentPage;

  int? _lastPage;
  int? get lastPage => _$this._lastPage;
  set lastPage(int? lastPage) => _$this._lastPage = lastPage;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  WorkOrderPageBuilder() {
    WorkOrderPage._defaults(this);
  }

  WorkOrderPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _currentPage = $v.currentPage;
      _lastPage = $v.lastPage;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkOrderPage other) {
    _$v = other as _$WorkOrderPage;
  }

  @override
  void update(void Function(WorkOrderPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkOrderPage build() => _build();

  _$WorkOrderPage _build() {
    _$WorkOrderPage _$result;
    try {
      _$result = _$v ??
          _$WorkOrderPage._(
            data: data.build(),
            currentPage: BuiltValueNullFieldError.checkNotNull(
                currentPage, r'WorkOrderPage', 'currentPage'),
            lastPage: BuiltValueNullFieldError.checkNotNull(
                lastPage, r'WorkOrderPage', 'lastPage'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'WorkOrderPage', 'total'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'WorkOrderPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
