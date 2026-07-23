// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_rejection.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccessRejection extends AccessRejection {
  @override
  final String note;

  factory _$AccessRejection([void Function(AccessRejectionBuilder)? updates]) =>
      (AccessRejectionBuilder()..update(updates))._build();

  _$AccessRejection._({required this.note}) : super._();
  @override
  AccessRejection rebuild(void Function(AccessRejectionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccessRejectionBuilder toBuilder() => AccessRejectionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccessRejection && note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccessRejection')..add('note', note))
        .toString();
  }
}

class AccessRejectionBuilder
    implements Builder<AccessRejection, AccessRejectionBuilder> {
  _$AccessRejection? _$v;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  AccessRejectionBuilder() {
    AccessRejection._defaults(this);
  }

  AccessRejectionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccessRejection other) {
    _$v = other as _$AccessRejection;
  }

  @override
  void update(void Function(AccessRejectionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccessRejection build() => _build();

  _$AccessRejection _build() {
    final _$result = _$v ??
        _$AccessRejection._(
          note: BuiltValueNullFieldError.checkNotNull(
              note, r'AccessRejection', 'note'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
