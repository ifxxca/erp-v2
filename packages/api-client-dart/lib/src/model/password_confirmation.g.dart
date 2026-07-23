// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_confirmation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PasswordConfirmation extends PasswordConfirmation {
  @override
  final String password;

  factory _$PasswordConfirmation(
          [void Function(PasswordConfirmationBuilder)? updates]) =>
      (PasswordConfirmationBuilder()..update(updates))._build();

  _$PasswordConfirmation._({required this.password}) : super._();
  @override
  PasswordConfirmation rebuild(
          void Function(PasswordConfirmationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PasswordConfirmationBuilder toBuilder() =>
      PasswordConfirmationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PasswordConfirmation && password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PasswordConfirmation')
          ..add('password', password))
        .toString();
  }
}

class PasswordConfirmationBuilder
    implements Builder<PasswordConfirmation, PasswordConfirmationBuilder> {
  _$PasswordConfirmation? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  PasswordConfirmationBuilder() {
    PasswordConfirmation._defaults(this);
  }

  PasswordConfirmationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PasswordConfirmation other) {
    _$v = other as _$PasswordConfirmation;
  }

  @override
  void update(void Function(PasswordConfirmationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PasswordConfirmation build() => _build();

  _$PasswordConfirmation _build() {
    final _$result = _$v ??
        _$PasswordConfirmation._(
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'PasswordConfirmation', 'password'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
