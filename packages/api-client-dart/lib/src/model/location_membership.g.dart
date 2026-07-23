// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_membership.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LocationMembership extends LocationMembership {
  @override
  final String id;
  @override
  final LocationSummary location;
  @override
  final Date validFrom;
  @override
  final Date? validUntil;

  factory _$LocationMembership(
          [void Function(LocationMembershipBuilder)? updates]) =>
      (LocationMembershipBuilder()..update(updates))._build();

  _$LocationMembership._(
      {required this.id,
      required this.location,
      required this.validFrom,
      this.validUntil})
      : super._();
  @override
  LocationMembership rebuild(
          void Function(LocationMembershipBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LocationMembershipBuilder toBuilder() =>
      LocationMembershipBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LocationMembership &&
        id == other.id &&
        location == other.location &&
        validFrom == other.validFrom &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, validFrom.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LocationMembership')
          ..add('id', id)
          ..add('location', location)
          ..add('validFrom', validFrom)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class LocationMembershipBuilder
    implements Builder<LocationMembership, LocationMembershipBuilder> {
  _$LocationMembership? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  LocationSummaryBuilder? _location;
  LocationSummaryBuilder get location =>
      _$this._location ??= LocationSummaryBuilder();
  set location(LocationSummaryBuilder? location) => _$this._location = location;

  Date? _validFrom;
  Date? get validFrom => _$this._validFrom;
  set validFrom(Date? validFrom) => _$this._validFrom = validFrom;

  Date? _validUntil;
  Date? get validUntil => _$this._validUntil;
  set validUntil(Date? validUntil) => _$this._validUntil = validUntil;

  LocationMembershipBuilder() {
    LocationMembership._defaults(this);
  }

  LocationMembershipBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _location = $v.location.toBuilder();
      _validFrom = $v.validFrom;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LocationMembership other) {
    _$v = other as _$LocationMembership;
  }

  @override
  void update(void Function(LocationMembershipBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LocationMembership build() => _build();

  _$LocationMembership _build() {
    _$LocationMembership _$result;
    try {
      _$result = _$v ??
          _$LocationMembership._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'LocationMembership', 'id'),
            location: location.build(),
            validFrom: BuiltValueNullFieldError.checkNotNull(
                validFrom, r'LocationMembership', 'validFrom'),
            validUntil: validUntil,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        location.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'LocationMembership', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
