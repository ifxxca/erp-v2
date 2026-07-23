// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class CompanySummaryBuilder {
  void replace(CompanySummary other);
  void update(void Function(CompanySummaryBuilder) updates);
  String? get id;
  set id(String? id);

  String? get code;
  set code(String? code);

  String? get legalName;
  set legalName(String? legalName);
}

class _$$CompanySummary extends $CompanySummary {
  @override
  final String id;
  @override
  final String code;
  @override
  final String legalName;

  factory _$$CompanySummary([void Function($CompanySummaryBuilder)? updates]) =>
      ($CompanySummaryBuilder()..update(updates))._build();

  _$$CompanySummary._(
      {required this.id, required this.code, required this.legalName})
      : super._();
  @override
  $CompanySummary rebuild(void Function($CompanySummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $CompanySummaryBuilder toBuilder() => $CompanySummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $CompanySummary &&
        id == other.id &&
        code == other.code &&
        legalName == other.legalName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, legalName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$CompanySummary')
          ..add('id', id)
          ..add('code', code)
          ..add('legalName', legalName))
        .toString();
  }
}

class $CompanySummaryBuilder
    implements
        Builder<$CompanySummary, $CompanySummaryBuilder>,
        CompanySummaryBuilder {
  _$$CompanySummary? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(covariant String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(covariant String? code) => _$this._code = code;

  String? _legalName;
  String? get legalName => _$this._legalName;
  set legalName(covariant String? legalName) => _$this._legalName = legalName;

  $CompanySummaryBuilder() {
    $CompanySummary._defaults(this);
  }

  $CompanySummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _legalName = $v.legalName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $CompanySummary other) {
    _$v = other as _$$CompanySummary;
  }

  @override
  void update(void Function($CompanySummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $CompanySummary build() => _build();

  _$$CompanySummary _build() {
    final _$result = _$v ??
        _$$CompanySummary._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'$CompanySummary', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'$CompanySummary', 'code'),
          legalName: BuiltValueNullFieldError.checkNotNull(
              legalName, r'$CompanySummary', 'legalName'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
