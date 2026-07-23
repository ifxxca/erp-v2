// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CurrentUser extends CurrentUser {
  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final IdentityStatus status;

  factory _$CurrentUser([void Function(CurrentUserBuilder)? updates]) =>
      (CurrentUserBuilder()..update(updates))._build();

  _$CurrentUser._(
      {required this.id,
      required this.name,
      required this.email,
      required this.status})
      : super._();
  @override
  CurrentUser rebuild(void Function(CurrentUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrentUserBuilder toBuilder() => CurrentUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrentUser &&
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
    return (newBuiltValueToStringHelper(r'CurrentUser')
          ..add('id', id)
          ..add('name', name)
          ..add('email', email)
          ..add('status', status))
        .toString();
  }
}

class CurrentUserBuilder implements Builder<CurrentUser, CurrentUserBuilder> {
  _$CurrentUser? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  IdentityStatus? _status;
  IdentityStatus? get status => _$this._status;
  set status(IdentityStatus? status) => _$this._status = status;

  CurrentUserBuilder() {
    CurrentUser._defaults(this);
  }

  CurrentUserBuilder get _$this {
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
  void replace(CurrentUser other) {
    _$v = other as _$CurrentUser;
  }

  @override
  void update(void Function(CurrentUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CurrentUser build() => _build();

  _$CurrentUser _build() {
    final _$result = _$v ??
        _$CurrentUser._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'CurrentUser', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'CurrentUser', 'name'),
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'CurrentUser', 'email'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'CurrentUser', 'status'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
