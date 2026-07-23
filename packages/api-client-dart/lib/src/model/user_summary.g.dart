// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class UserSummaryBuilder {
  void replace(UserSummary other);
  void update(void Function(UserSummaryBuilder) updates);
  String? get id;
  set id(String? id);

  String? get name;
  set name(String? name);

  String? get email;
  set email(String? email);
}

class _$$UserSummary extends $UserSummary {
  @override
  final String id;
  @override
  final String name;
  @override
  final String? email;

  factory _$$UserSummary([void Function($UserSummaryBuilder)? updates]) =>
      ($UserSummaryBuilder()..update(updates))._build();

  _$$UserSummary._({required this.id, required this.name, this.email})
      : super._();
  @override
  $UserSummary rebuild(void Function($UserSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $UserSummaryBuilder toBuilder() => $UserSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $UserSummary &&
        id == other.id &&
        name == other.name &&
        email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$UserSummary')
          ..add('id', id)
          ..add('name', name)
          ..add('email', email))
        .toString();
  }
}

class $UserSummaryBuilder
    implements Builder<$UserSummary, $UserSummaryBuilder>, UserSummaryBuilder {
  _$$UserSummary? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(covariant String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(covariant String? email) => _$this._email = email;

  $UserSummaryBuilder() {
    $UserSummary._defaults(this);
  }

  $UserSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $UserSummary other) {
    _$v = other as _$$UserSummary;
  }

  @override
  void update(void Function($UserSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $UserSummary build() => _build();

  _$$UserSummary _build() {
    final _$result = _$v ??
        _$$UserSummary._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'$UserSummary', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'$UserSummary', 'name'),
          email: email,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
