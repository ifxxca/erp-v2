// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_work_order_request_jobs_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateWorkOrderRequestJobsInner
    extends CreateWorkOrderRequestJobsInner {
  @override
  final String description;
  @override
  final num laborCost;
  @override
  final String? note;

  factory _$CreateWorkOrderRequestJobsInner(
          [void Function(CreateWorkOrderRequestJobsInnerBuilder)? updates]) =>
      (CreateWorkOrderRequestJobsInnerBuilder()..update(updates))._build();

  _$CreateWorkOrderRequestJobsInner._(
      {required this.description, required this.laborCost, this.note})
      : super._();
  @override
  CreateWorkOrderRequestJobsInner rebuild(
          void Function(CreateWorkOrderRequestJobsInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateWorkOrderRequestJobsInnerBuilder toBuilder() =>
      CreateWorkOrderRequestJobsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateWorkOrderRequestJobsInner &&
        description == other.description &&
        laborCost == other.laborCost &&
        note == other.note;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, laborCost.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateWorkOrderRequestJobsInner')
          ..add('description', description)
          ..add('laborCost', laborCost)
          ..add('note', note))
        .toString();
  }
}

class CreateWorkOrderRequestJobsInnerBuilder
    implements
        Builder<CreateWorkOrderRequestJobsInner,
            CreateWorkOrderRequestJobsInnerBuilder> {
  _$CreateWorkOrderRequestJobsInner? _$v;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  num? _laborCost;
  num? get laborCost => _$this._laborCost;
  set laborCost(num? laborCost) => _$this._laborCost = laborCost;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  CreateWorkOrderRequestJobsInnerBuilder() {
    CreateWorkOrderRequestJobsInner._defaults(this);
  }

  CreateWorkOrderRequestJobsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _description = $v.description;
      _laborCost = $v.laborCost;
      _note = $v.note;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateWorkOrderRequestJobsInner other) {
    _$v = other as _$CreateWorkOrderRequestJobsInner;
  }

  @override
  void update(void Function(CreateWorkOrderRequestJobsInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateWorkOrderRequestJobsInner build() => _build();

  _$CreateWorkOrderRequestJobsInner _build() {
    final _$result = _$v ??
        _$CreateWorkOrderRequestJobsInner._(
          description: BuiltValueNullFieldError.checkNotNull(
              description, r'CreateWorkOrderRequestJobsInner', 'description'),
          laborCost: BuiltValueNullFieldError.checkNotNull(
              laborCost, r'CreateWorkOrderRequestJobsInner', 'laborCost'),
          note: note,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
