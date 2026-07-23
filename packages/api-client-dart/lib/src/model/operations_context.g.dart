// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations_context.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OperationsContext extends OperationsContext {
  @override
  final OperationsContextCompany company;
  @override
  final OperationsContextLocation location;
  @override
  final OperationsCapabilities capabilities;

  factory _$OperationsContext(
          [void Function(OperationsContextBuilder)? updates]) =>
      (OperationsContextBuilder()..update(updates))._build();

  _$OperationsContext._(
      {required this.company,
      required this.location,
      required this.capabilities})
      : super._();
  @override
  OperationsContext rebuild(void Function(OperationsContextBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OperationsContextBuilder toBuilder() =>
      OperationsContextBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OperationsContext &&
        company == other.company &&
        location == other.location &&
        capabilities == other.capabilities;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, company.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, capabilities.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OperationsContext')
          ..add('company', company)
          ..add('location', location)
          ..add('capabilities', capabilities))
        .toString();
  }
}

class OperationsContextBuilder
    implements Builder<OperationsContext, OperationsContextBuilder> {
  _$OperationsContext? _$v;

  OperationsContextCompanyBuilder? _company;
  OperationsContextCompanyBuilder get company =>
      _$this._company ??= OperationsContextCompanyBuilder();
  set company(OperationsContextCompanyBuilder? company) =>
      _$this._company = company;

  OperationsContextLocationBuilder? _location;
  OperationsContextLocationBuilder get location =>
      _$this._location ??= OperationsContextLocationBuilder();
  set location(OperationsContextLocationBuilder? location) =>
      _$this._location = location;

  OperationsCapabilitiesBuilder? _capabilities;
  OperationsCapabilitiesBuilder get capabilities =>
      _$this._capabilities ??= OperationsCapabilitiesBuilder();
  set capabilities(OperationsCapabilitiesBuilder? capabilities) =>
      _$this._capabilities = capabilities;

  OperationsContextBuilder() {
    OperationsContext._defaults(this);
  }

  OperationsContextBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _company = $v.company.toBuilder();
      _location = $v.location.toBuilder();
      _capabilities = $v.capabilities.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OperationsContext other) {
    _$v = other as _$OperationsContext;
  }

  @override
  void update(void Function(OperationsContextBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OperationsContext build() => _build();

  _$OperationsContext _build() {
    _$OperationsContext _$result;
    try {
      _$result = _$v ??
          _$OperationsContext._(
            company: company.build(),
            location: location.build(),
            capabilities: capabilities.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'company';
        company.build();
        _$failedField = 'location';
        location.build();
        _$failedField = 'capabilities';
        capabilities.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'OperationsContext', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
