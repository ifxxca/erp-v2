// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LocationSummary extends LocationSummary {
  @override
  final String id;
  @override
  final String code;
  @override
  final String name;
  @override
  final String timezone;

  factory _$LocationSummary([void Function(LocationSummaryBuilder)? updates]) =>
      (LocationSummaryBuilder()..update(updates))._build();

  _$LocationSummary._(
      {required this.id,
      required this.code,
      required this.name,
      required this.timezone})
      : super._();
  @override
  LocationSummary rebuild(void Function(LocationSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LocationSummaryBuilder toBuilder() => LocationSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LocationSummary &&
        id == other.id &&
        code == other.code &&
        name == other.name &&
        timezone == other.timezone;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, timezone.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LocationSummary')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('timezone', timezone))
        .toString();
  }
}

class LocationSummaryBuilder
    implements Builder<LocationSummary, LocationSummaryBuilder> {
  _$LocationSummary? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _timezone;
  String? get timezone => _$this._timezone;
  set timezone(String? timezone) => _$this._timezone = timezone;

  LocationSummaryBuilder() {
    LocationSummary._defaults(this);
  }

  LocationSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _timezone = $v.timezone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LocationSummary other) {
    _$v = other as _$LocationSummary;
  }

  @override
  void update(void Function(LocationSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LocationSummary build() => _build();

  _$LocationSummary _build() {
    final _$result = _$v ??
        _$LocationSummary._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'LocationSummary', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'LocationSummary', 'code'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'LocationSummary', 'name'),
          timezone: BuiltValueNullFieldError.checkNotNull(
              timezone, r'LocationSummary', 'timezone'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
