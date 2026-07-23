// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_evidence.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChecklistEvidenceScanStatusEnum _$checklistEvidenceScanStatusEnum_clean =
    const ChecklistEvidenceScanStatusEnum._('clean');
const ChecklistEvidenceScanStatusEnum
    _$checklistEvidenceScanStatusEnum_skipped =
    const ChecklistEvidenceScanStatusEnum._('skipped');
const ChecklistEvidenceScanStatusEnum
    _$checklistEvidenceScanStatusEnum_unknownDefaultOpenApi =
    const ChecklistEvidenceScanStatusEnum._('unknownDefaultOpenApi');

ChecklistEvidenceScanStatusEnum _$checklistEvidenceScanStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'clean':
      return _$checklistEvidenceScanStatusEnum_clean;
    case 'skipped':
      return _$checklistEvidenceScanStatusEnum_skipped;
    case 'unknownDefaultOpenApi':
      return _$checklistEvidenceScanStatusEnum_unknownDefaultOpenApi;
    default:
      return _$checklistEvidenceScanStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ChecklistEvidenceScanStatusEnum>
    _$checklistEvidenceScanStatusEnumValues = BuiltSet<
        ChecklistEvidenceScanStatusEnum>(const <ChecklistEvidenceScanStatusEnum>[
  _$checklistEvidenceScanStatusEnum_clean,
  _$checklistEvidenceScanStatusEnum_skipped,
  _$checklistEvidenceScanStatusEnum_unknownDefaultOpenApi,
]);

Serializer<ChecklistEvidenceScanStatusEnum>
    _$checklistEvidenceScanStatusEnumSerializer =
    _$ChecklistEvidenceScanStatusEnumSerializer();

class _$ChecklistEvidenceScanStatusEnumSerializer
    implements PrimitiveSerializer<ChecklistEvidenceScanStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'clean': 'clean',
    'skipped': 'skipped',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'clean': 'clean',
    'skipped': 'skipped',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ChecklistEvidenceScanStatusEnum];
  @override
  final String wireName = 'ChecklistEvidenceScanStatusEnum';

  @override
  Object serialize(
          Serializers serializers, ChecklistEvidenceScanStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ChecklistEvidenceScanStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ChecklistEvidenceScanStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ChecklistEvidence extends ChecklistEvidence {
  @override
  final String id;
  @override
  final String attachedId;
  @override
  final String originalName;
  @override
  final String? declaredMimeType;
  @override
  final String? detectedMimeType;
  @override
  final int? expectedSize;
  @override
  final int? actualSize;
  @override
  final JsonObject? status;
  @override
  final ChecklistEvidenceScanStatusEnum scanStatus;
  @override
  final DateTime? createdAt;

  factory _$ChecklistEvidence(
          [void Function(ChecklistEvidenceBuilder)? updates]) =>
      (ChecklistEvidenceBuilder()..update(updates))._build();

  _$ChecklistEvidence._(
      {required this.id,
      required this.attachedId,
      required this.originalName,
      this.declaredMimeType,
      this.detectedMimeType,
      this.expectedSize,
      this.actualSize,
      this.status,
      required this.scanStatus,
      this.createdAt})
      : super._();
  @override
  ChecklistEvidence rebuild(void Function(ChecklistEvidenceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChecklistEvidenceBuilder toBuilder() =>
      ChecklistEvidenceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChecklistEvidence &&
        id == other.id &&
        attachedId == other.attachedId &&
        originalName == other.originalName &&
        declaredMimeType == other.declaredMimeType &&
        detectedMimeType == other.detectedMimeType &&
        expectedSize == other.expectedSize &&
        actualSize == other.actualSize &&
        status == other.status &&
        scanStatus == other.scanStatus &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, attachedId.hashCode);
    _$hash = $jc(_$hash, originalName.hashCode);
    _$hash = $jc(_$hash, declaredMimeType.hashCode);
    _$hash = $jc(_$hash, detectedMimeType.hashCode);
    _$hash = $jc(_$hash, expectedSize.hashCode);
    _$hash = $jc(_$hash, actualSize.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, scanStatus.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChecklistEvidence')
          ..add('id', id)
          ..add('attachedId', attachedId)
          ..add('originalName', originalName)
          ..add('declaredMimeType', declaredMimeType)
          ..add('detectedMimeType', detectedMimeType)
          ..add('expectedSize', expectedSize)
          ..add('actualSize', actualSize)
          ..add('status', status)
          ..add('scanStatus', scanStatus)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ChecklistEvidenceBuilder
    implements Builder<ChecklistEvidence, ChecklistEvidenceBuilder> {
  _$ChecklistEvidence? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _attachedId;
  String? get attachedId => _$this._attachedId;
  set attachedId(String? attachedId) => _$this._attachedId = attachedId;

  String? _originalName;
  String? get originalName => _$this._originalName;
  set originalName(String? originalName) => _$this._originalName = originalName;

  String? _declaredMimeType;
  String? get declaredMimeType => _$this._declaredMimeType;
  set declaredMimeType(String? declaredMimeType) =>
      _$this._declaredMimeType = declaredMimeType;

  String? _detectedMimeType;
  String? get detectedMimeType => _$this._detectedMimeType;
  set detectedMimeType(String? detectedMimeType) =>
      _$this._detectedMimeType = detectedMimeType;

  int? _expectedSize;
  int? get expectedSize => _$this._expectedSize;
  set expectedSize(int? expectedSize) => _$this._expectedSize = expectedSize;

  int? _actualSize;
  int? get actualSize => _$this._actualSize;
  set actualSize(int? actualSize) => _$this._actualSize = actualSize;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(JsonObject? status) => _$this._status = status;

  ChecklistEvidenceScanStatusEnum? _scanStatus;
  ChecklistEvidenceScanStatusEnum? get scanStatus => _$this._scanStatus;
  set scanStatus(ChecklistEvidenceScanStatusEnum? scanStatus) =>
      _$this._scanStatus = scanStatus;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ChecklistEvidenceBuilder() {
    ChecklistEvidence._defaults(this);
  }

  ChecklistEvidenceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _attachedId = $v.attachedId;
      _originalName = $v.originalName;
      _declaredMimeType = $v.declaredMimeType;
      _detectedMimeType = $v.detectedMimeType;
      _expectedSize = $v.expectedSize;
      _actualSize = $v.actualSize;
      _status = $v.status;
      _scanStatus = $v.scanStatus;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChecklistEvidence other) {
    _$v = other as _$ChecklistEvidence;
  }

  @override
  void update(void Function(ChecklistEvidenceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChecklistEvidence build() => _build();

  _$ChecklistEvidence _build() {
    final _$result = _$v ??
        _$ChecklistEvidence._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'ChecklistEvidence', 'id'),
          attachedId: BuiltValueNullFieldError.checkNotNull(
              attachedId, r'ChecklistEvidence', 'attachedId'),
          originalName: BuiltValueNullFieldError.checkNotNull(
              originalName, r'ChecklistEvidence', 'originalName'),
          declaredMimeType: declaredMimeType,
          detectedMimeType: detectedMimeType,
          expectedSize: expectedSize,
          actualSize: actualSize,
          status: status,
          scanStatus: BuiltValueNullFieldError.checkNotNull(
              scanStatus, r'ChecklistEvidence', 'scanStatus'),
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
