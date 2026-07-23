// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class IdentitySummaryBuilder {
  void replace(IdentitySummary other);
  void update(void Function(IdentitySummaryBuilder) updates);
  String? get id;
  set id(String? id);

  String? get name;
  set name(String? name);

  String? get email;
  set email(String? email);

  IdentityStatus? get status;
  set status(IdentityStatus? status);
}

class _$$IdentitySummary extends $IdentitySummary {
  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final IdentityStatus status;

  factory _$$IdentitySummary(
          [void Function($IdentitySummaryBuilder)? updates]) =>
      ($IdentitySummaryBuilder()..update(updates))._build();

  _$$IdentitySummary._(
      {required this.id,
      required this.name,
      required this.email,
      required this.status})
      : super._();
  @override
  $IdentitySummary rebuild(void Function($IdentitySummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $IdentitySummaryBuilder toBuilder() =>
      $IdentitySummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $IdentitySummary &&
        id == other.id &&
        name == other.name &&
        email == other.email &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$IdentitySummary')
          ..add('id', id)
          ..add('name', name)
          ..add('email', email)
          ..add('status', status))
        .toString();
  }
}

class $IdentitySummaryBuilder
    implements
        Builder<$IdentitySummary, $IdentitySummaryBuilder>,
        IdentitySummaryBuilder {
  _$$IdentitySummary? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(covariant String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(covariant String? email) => _$this._email = email;

  IdentityStatus? _status;
  IdentityStatus? get status => _$this._status;
  set status(covariant IdentityStatus? status) => _$this._status = status;

  $IdentitySummaryBuilder() {
    $IdentitySummary._defaults(this);
  }

  $IdentitySummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _email = $v.email;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $IdentitySummary other) {
    _$v = other as _$$IdentitySummary;
  }

  @override
  void update(void Function($IdentitySummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $IdentitySummary build() => _build();

  _$$IdentitySummary _build() {
    final _$result = _$v ??
        _$$IdentitySummary._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'$IdentitySummary', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'$IdentitySummary', 'name'),
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'$IdentitySummary', 'email'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'$IdentitySummary', 'status'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
