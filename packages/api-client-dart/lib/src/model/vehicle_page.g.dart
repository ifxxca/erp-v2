// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VehiclePage extends VehiclePage {
  @override
  final BuiltList<Vehicle> data;
  @override
  final int currentPage;
  @override
  final int lastPage;
  @override
  final int total;

  factory _$VehiclePage([void Function(VehiclePageBuilder)? updates]) =>
      (VehiclePageBuilder()..update(updates))._build();

  _$VehiclePage._(
      {required this.data,
      required this.currentPage,
      required this.lastPage,
      required this.total})
      : super._();
  @override
  VehiclePage rebuild(void Function(VehiclePageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VehiclePageBuilder toBuilder() => VehiclePageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VehiclePage &&
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
    return (newBuiltValueToStringHelper(r'VehiclePage')
          ..add('data', data)
          ..add('currentPage', currentPage)
          ..add('lastPage', lastPage)
          ..add('total', total))
        .toString();
  }
}

class VehiclePageBuilder implements Builder<VehiclePage, VehiclePageBuilder> {
  _$VehiclePage? _$v;

  ListBuilder<Vehicle>? _data;
  ListBuilder<Vehicle> get data => _$this._data ??= ListBuilder<Vehicle>();
  set data(ListBuilder<Vehicle>? data) => _$this._data = data;

  int? _currentPage;
  int? get currentPage => _$this._currentPage;
  set currentPage(int? currentPage) => _$this._currentPage = currentPage;

  int? _lastPage;
  int? get lastPage => _$this._lastPage;
  set lastPage(int? lastPage) => _$this._lastPage = lastPage;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  VehiclePageBuilder() {
    VehiclePage._defaults(this);
  }

  VehiclePageBuilder get _$this {
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
  void replace(VehiclePage other) {
    _$v = other as _$VehiclePage;
  }

  @override
  void update(void Function(VehiclePageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VehiclePage build() => _build();

  _$VehiclePage _build() {
    _$VehiclePage _$result;
    try {
      _$result = _$v ??
          _$VehiclePage._(
            data: data.build(),
            currentPage: BuiltValueNullFieldError.checkNotNull(
                currentPage, r'VehiclePage', 'currentPage'),
            lastPage: BuiltValueNullFieldError.checkNotNull(
                lastPage, r'VehiclePage', 'lastPage'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'VehiclePage', 'total'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'VehiclePage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
