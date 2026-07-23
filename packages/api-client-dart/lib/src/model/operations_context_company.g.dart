// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations_context_company.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OperationsContextCompany extends OperationsContextCompany {
  @override
  final String id;
  @override
  final String code;
  @override
  final String legalName;

  factory _$OperationsContextCompany(
          [void Function(OperationsContextCompanyBuilder)? updates]) =>
      (OperationsContextCompanyBuilder()..update(updates))._build();

  _$OperationsContextCompany._(
      {required this.id, required this.code, required this.legalName})
      : super._();
  @override
  OperationsContextCompany rebuild(
          void Function(OperationsContextCompanyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OperationsContextCompanyBuilder toBuilder() =>
      OperationsContextCompanyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OperationsContextCompany &&
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
    return (newBuiltValueToStringHelper(r'OperationsContextCompany')
          ..add('id', id)
          ..add('code', code)
          ..add('legalName', legalName))
        .toString();
  }
}

class OperationsContextCompanyBuilder
    implements
        Builder<OperationsContextCompany, OperationsContextCompanyBuilder> {
  _$OperationsContextCompany? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _legalName;
  String? get legalName => _$this._legalName;
  set legalName(String? legalName) => _$this._legalName = legalName;

  OperationsContextCompanyBuilder() {
    OperationsContextCompany._defaults(this);
  }

  OperationsContextCompanyBuilder get _$this {
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
  void replace(OperationsContextCompany other) {
    _$v = other as _$OperationsContextCompany;
  }

  @override
  void update(void Function(OperationsContextCompanyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OperationsContextCompany build() => _build();

  _$OperationsContextCompany _build() {
    final _$result = _$v ??
        _$OperationsContextCompany._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'OperationsContextCompany', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'OperationsContextCompany', 'code'),
          legalName: BuiltValueNullFieldError.checkNotNull(
              legalName, r'OperationsContextCompany', 'legalName'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
