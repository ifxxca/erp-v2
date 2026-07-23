// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_decision.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccessDecision extends AccessDecision {
  @override
  final String? note;

  factory _$AccessDecision([void Function(AccessDecisionBuilder)? updates]) =>
      (AccessDecisionBuilder()..update(updates))._build();

  _$AccessDecision._({this.note}) : super._();
  @override
  AccessDecision rebuild(void Function(AccessDecisionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccessDecisionBuilder toBuilder() => AccessDecisionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccessDecision && note == other.note;
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
    return (newBuiltValueToStringHelper(r'AccessDecision')..add('note', note))
        .toString();
  }
}

class AccessDecisionBuilder
    implements Builder<AccessDecision, AccessDecisionBuilder> {
  _$AccessDecision? _$v;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  AccessDecisionBuilder() {
    AccessDecision._defaults(this);
  }

  AccessDecisionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccessDecision other) {
    _$v = other as _$AccessDecision;
  }

  @override
  void update(void Function(AccessDecisionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccessDecision build() => _build();

  _$AccessDecision _build() {
    final _$result = _$v ??
        _$AccessDecision._(
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
