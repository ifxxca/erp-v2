// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_trip_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VehicleTripPage extends VehicleTripPage {
  @override
  final BuiltList<VehicleTrip> data;
  @override
  final int currentPage;
  @override
  final int lastPage;
  @override
  final int total;

  factory _$VehicleTripPage([void Function(VehicleTripPageBuilder)? updates]) =>
      (VehicleTripPageBuilder()..update(updates))._build();

  _$VehicleTripPage._(
      {required this.data,
      required this.currentPage,
      required this.lastPage,
      required this.total})
      : super._();
  @override
  VehicleTripPage rebuild(void Function(VehicleTripPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VehicleTripPageBuilder toBuilder() => VehicleTripPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VehicleTripPage &&
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
    return (newBuiltValueToStringHelper(r'VehicleTripPage')
          ..add('data', data)
          ..add('currentPage', currentPage)
          ..add('lastPage', lastPage)
          ..add('total', total))
        .toString();
  }
}

class VehicleTripPageBuilder
    implements Builder<VehicleTripPage, VehicleTripPageBuilder> {
  _$VehicleTripPage? _$v;

  ListBuilder<VehicleTrip>? _data;
  ListBuilder<VehicleTrip> get data =>
      _$this._data ??= ListBuilder<VehicleTrip>();
  set data(ListBuilder<VehicleTrip>? data) => _$this._data = data;

  int? _currentPage;
  int? get currentPage => _$this._currentPage;
  set currentPage(int? currentPage) => _$this._currentPage = currentPage;

  int? _lastPage;
  int? get lastPage => _$this._lastPage;
  set lastPage(int? lastPage) => _$this._lastPage = lastPage;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  VehicleTripPageBuilder() {
    VehicleTripPage._defaults(this);
  }

  VehicleTripPageBuilder get _$this {
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
  void replace(VehicleTripPage other) {
    _$v = other as _$VehicleTripPage;
  }

  @override
  void update(void Function(VehicleTripPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VehicleTripPage build() => _build();

  _$VehicleTripPage _build() {
    _$VehicleTripPage _$result;
    try {
      _$result = _$v ??
          _$VehicleTripPage._(
            data: data.build(),
            currentPage: BuiltValueNullFieldError.checkNotNull(
                currentPage, r'VehicleTripPage', 'currentPage'),
            lastPage: BuiltValueNullFieldError.checkNotNull(
                lastPage, r'VehicleTripPage', 'lastPage'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'VehicleTripPage', 'total'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'VehicleTripPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
