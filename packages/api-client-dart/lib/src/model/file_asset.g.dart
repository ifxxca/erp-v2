// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_asset.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FileAssetStatusEnum _$fileAssetStatusEnum_pending =
    const FileAssetStatusEnum._('pending');
const FileAssetStatusEnum _$fileAssetStatusEnum_uploaded =
    const FileAssetStatusEnum._('uploaded');
const FileAssetStatusEnum _$fileAssetStatusEnum_quarantined =
    const FileAssetStatusEnum._('quarantined');
const FileAssetStatusEnum _$fileAssetStatusEnum_ready =
    const FileAssetStatusEnum._('ready');
const FileAssetStatusEnum _$fileAssetStatusEnum_rejected =
    const FileAssetStatusEnum._('rejected');
const FileAssetStatusEnum _$fileAssetStatusEnum_deleted =
    const FileAssetStatusEnum._('deleted');
const FileAssetStatusEnum _$fileAssetStatusEnum_expired =
    const FileAssetStatusEnum._('expired');
const FileAssetStatusEnum _$fileAssetStatusEnum_unknownDefaultOpenApi =
    const FileAssetStatusEnum._('unknownDefaultOpenApi');

FileAssetStatusEnum _$fileAssetStatusEnumValueOf(String name) {
  switch (name) {
    case 'pending':
      return _$fileAssetStatusEnum_pending;
    case 'uploaded':
      return _$fileAssetStatusEnum_uploaded;
    case 'quarantined':
      return _$fileAssetStatusEnum_quarantined;
    case 'ready':
      return _$fileAssetStatusEnum_ready;
    case 'rejected':
      return _$fileAssetStatusEnum_rejected;
    case 'deleted':
      return _$fileAssetStatusEnum_deleted;
    case 'expired':
      return _$fileAssetStatusEnum_expired;
    case 'unknownDefaultOpenApi':
      return _$fileAssetStatusEnum_unknownDefaultOpenApi;
    default:
      return _$fileAssetStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FileAssetStatusEnum> _$fileAssetStatusEnumValues =
    BuiltSet<FileAssetStatusEnum>(const <FileAssetStatusEnum>[
  _$fileAssetStatusEnum_pending,
  _$fileAssetStatusEnum_uploaded,
  _$fileAssetStatusEnum_quarantined,
  _$fileAssetStatusEnum_ready,
  _$fileAssetStatusEnum_rejected,
  _$fileAssetStatusEnum_deleted,
  _$fileAssetStatusEnum_expired,
  _$fileAssetStatusEnum_unknownDefaultOpenApi,
]);

const FileAssetScanStatusEnum _$fileAssetScanStatusEnum_notStarted =
    const FileAssetScanStatusEnum._('notStarted');
const FileAssetScanStatusEnum _$fileAssetScanStatusEnum_pending =
    const FileAssetScanStatusEnum._('pending');
const FileAssetScanStatusEnum _$fileAssetScanStatusEnum_clean =
    const FileAssetScanStatusEnum._('clean');
const FileAssetScanStatusEnum _$fileAssetScanStatusEnum_infected =
    const FileAssetScanStatusEnum._('infected');
const FileAssetScanStatusEnum _$fileAssetScanStatusEnum_failed =
    const FileAssetScanStatusEnum._('failed');
const FileAssetScanStatusEnum _$fileAssetScanStatusEnum_skipped =
    const FileAssetScanStatusEnum._('skipped');
const FileAssetScanStatusEnum _$fileAssetScanStatusEnum_unknownDefaultOpenApi =
    const FileAssetScanStatusEnum._('unknownDefaultOpenApi');

FileAssetScanStatusEnum _$fileAssetScanStatusEnumValueOf(String name) {
  switch (name) {
    case 'notStarted':
      return _$fileAssetScanStatusEnum_notStarted;
    case 'pending':
      return _$fileAssetScanStatusEnum_pending;
    case 'clean':
      return _$fileAssetScanStatusEnum_clean;
    case 'infected':
      return _$fileAssetScanStatusEnum_infected;
    case 'failed':
      return _$fileAssetScanStatusEnum_failed;
    case 'skipped':
      return _$fileAssetScanStatusEnum_skipped;
    case 'unknownDefaultOpenApi':
      return _$fileAssetScanStatusEnum_unknownDefaultOpenApi;
    default:
      return _$fileAssetScanStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FileAssetScanStatusEnum> _$fileAssetScanStatusEnumValues =
    BuiltSet<FileAssetScanStatusEnum>(const <FileAssetScanStatusEnum>[
  _$fileAssetScanStatusEnum_notStarted,
  _$fileAssetScanStatusEnum_pending,
  _$fileAssetScanStatusEnum_clean,
  _$fileAssetScanStatusEnum_infected,
  _$fileAssetScanStatusEnum_failed,
  _$fileAssetScanStatusEnum_skipped,
  _$fileAssetScanStatusEnum_unknownDefaultOpenApi,
]);

Serializer<FileAssetStatusEnum> _$fileAssetStatusEnumSerializer =
    _$FileAssetStatusEnumSerializer();
Serializer<FileAssetScanStatusEnum> _$fileAssetScanStatusEnumSerializer =
    _$FileAssetScanStatusEnumSerializer();

class _$FileAssetStatusEnumSerializer
    implements PrimitiveSerializer<FileAssetStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'uploaded': 'uploaded',
    'quarantined': 'quarantined',
    'ready': 'ready',
    'rejected': 'rejected',
    'deleted': 'deleted',
    'expired': 'expired',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'uploaded': 'uploaded',
    'quarantined': 'quarantined',
    'ready': 'ready',
    'rejected': 'rejected',
    'deleted': 'deleted',
    'expired': 'expired',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FileAssetStatusEnum];
  @override
  final String wireName = 'FileAssetStatusEnum';

  @override
  Object serialize(Serializers serializers, FileAssetStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FileAssetStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FileAssetStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FileAssetScanStatusEnumSerializer
    implements PrimitiveSerializer<FileAssetScanStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'notStarted': 'not_started',
    'pending': 'pending',
    'clean': 'clean',
    'infected': 'infected',
    'failed': 'failed',
    'skipped': 'skipped',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'not_started': 'notStarted',
    'pending': 'pending',
    'clean': 'clean',
    'infected': 'infected',
    'failed': 'failed',
    'skipped': 'skipped',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FileAssetScanStatusEnum];
  @override
  final String wireName = 'FileAssetScanStatusEnum';

  @override
  Object serialize(Serializers serializers, FileAssetScanStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FileAssetScanStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FileAssetScanStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FileAsset extends FileAsset {
  @override
  final String id;
  @override
  final String companyId;
  @override
  final String createdBy;
  @override
  final String purpose;
  @override
  final String originalName;
  @override
  final String mimeType;
  @override
  final int size;
  @override
  final String checksumSha256;
  @override
  final FileAssetStatusEnum status;
  @override
  final FileAssetScanStatusEnum scanStatus;
  @override
  final String? rejectionReason;
  @override
  final String? attachedType;
  @override
  final String? attachedId;
  @override
  final DateTime pendingExpiresAt;
  @override
  final DateTime? retentionUntil;
  @override
  final DateTime? uploadedAt;
  @override
  final DateTime? finalizedAt;
  @override
  final DateTime createdAt;

  factory _$FileAsset([void Function(FileAssetBuilder)? updates]) =>
      (FileAssetBuilder()..update(updates))._build();

  _$FileAsset._(
      {required this.id,
      required this.companyId,
      required this.createdBy,
      required this.purpose,
      required this.originalName,
      required this.mimeType,
      required this.size,
      required this.checksumSha256,
      required this.status,
      required this.scanStatus,
      this.rejectionReason,
      this.attachedType,
      this.attachedId,
      required this.pendingExpiresAt,
      this.retentionUntil,
      this.uploadedAt,
      this.finalizedAt,
      required this.createdAt})
      : super._();
  @override
  FileAsset rebuild(void Function(FileAssetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FileAssetBuilder toBuilder() => FileAssetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FileAsset &&
        id == other.id &&
        companyId == other.companyId &&
        createdBy == other.createdBy &&
        purpose == other.purpose &&
        originalName == other.originalName &&
        mimeType == other.mimeType &&
        size == other.size &&
        checksumSha256 == other.checksumSha256 &&
        status == other.status &&
        scanStatus == other.scanStatus &&
        rejectionReason == other.rejectionReason &&
        attachedType == other.attachedType &&
        attachedId == other.attachedId &&
        pendingExpiresAt == other.pendingExpiresAt &&
        retentionUntil == other.retentionUntil &&
        uploadedAt == other.uploadedAt &&
        finalizedAt == other.finalizedAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, companyId.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, purpose.hashCode);
    _$hash = $jc(_$hash, originalName.hashCode);
    _$hash = $jc(_$hash, mimeType.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, checksumSha256.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, scanStatus.hashCode);
    _$hash = $jc(_$hash, rejectionReason.hashCode);
    _$hash = $jc(_$hash, attachedType.hashCode);
    _$hash = $jc(_$hash, attachedId.hashCode);
    _$hash = $jc(_$hash, pendingExpiresAt.hashCode);
    _$hash = $jc(_$hash, retentionUntil.hashCode);
    _$hash = $jc(_$hash, uploadedAt.hashCode);
    _$hash = $jc(_$hash, finalizedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FileAsset')
          ..add('id', id)
          ..add('companyId', companyId)
          ..add('createdBy', createdBy)
          ..add('purpose', purpose)
          ..add('originalName', originalName)
          ..add('mimeType', mimeType)
          ..add('size', size)
          ..add('checksumSha256', checksumSha256)
          ..add('status', status)
          ..add('scanStatus', scanStatus)
          ..add('rejectionReason', rejectionReason)
          ..add('attachedType', attachedType)
          ..add('attachedId', attachedId)
          ..add('pendingExpiresAt', pendingExpiresAt)
          ..add('retentionUntil', retentionUntil)
          ..add('uploadedAt', uploadedAt)
          ..add('finalizedAt', finalizedAt)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class FileAssetBuilder implements Builder<FileAsset, FileAssetBuilder> {
  _$FileAsset? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _companyId;
  String? get companyId => _$this._companyId;
  set companyId(String? companyId) => _$this._companyId = companyId;

  String? _createdBy;
  String? get createdBy => _$this._createdBy;
  set createdBy(String? createdBy) => _$this._createdBy = createdBy;

  String? _purpose;
  String? get purpose => _$this._purpose;
  set purpose(String? purpose) => _$this._purpose = purpose;

  String? _originalName;
  String? get originalName => _$this._originalName;
  set originalName(String? originalName) => _$this._originalName = originalName;

  String? _mimeType;
  String? get mimeType => _$this._mimeType;
  set mimeType(String? mimeType) => _$this._mimeType = mimeType;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  String? _checksumSha256;
  String? get checksumSha256 => _$this._checksumSha256;
  set checksumSha256(String? checksumSha256) =>
      _$this._checksumSha256 = checksumSha256;

  FileAssetStatusEnum? _status;
  FileAssetStatusEnum? get status => _$this._status;
  set status(FileAssetStatusEnum? status) => _$this._status = status;

  FileAssetScanStatusEnum? _scanStatus;
  FileAssetScanStatusEnum? get scanStatus => _$this._scanStatus;
  set scanStatus(FileAssetScanStatusEnum? scanStatus) =>
      _$this._scanStatus = scanStatus;

  String? _rejectionReason;
  String? get rejectionReason => _$this._rejectionReason;
  set rejectionReason(String? rejectionReason) =>
      _$this._rejectionReason = rejectionReason;

  String? _attachedType;
  String? get attachedType => _$this._attachedType;
  set attachedType(String? attachedType) => _$this._attachedType = attachedType;

  String? _attachedId;
  String? get attachedId => _$this._attachedId;
  set attachedId(String? attachedId) => _$this._attachedId = attachedId;

  DateTime? _pendingExpiresAt;
  DateTime? get pendingExpiresAt => _$this._pendingExpiresAt;
  set pendingExpiresAt(DateTime? pendingExpiresAt) =>
      _$this._pendingExpiresAt = pendingExpiresAt;

  DateTime? _retentionUntil;
  DateTime? get retentionUntil => _$this._retentionUntil;
  set retentionUntil(DateTime? retentionUntil) =>
      _$this._retentionUntil = retentionUntil;

  DateTime? _uploadedAt;
  DateTime? get uploadedAt => _$this._uploadedAt;
  set uploadedAt(DateTime? uploadedAt) => _$this._uploadedAt = uploadedAt;

  DateTime? _finalizedAt;
  DateTime? get finalizedAt => _$this._finalizedAt;
  set finalizedAt(DateTime? finalizedAt) => _$this._finalizedAt = finalizedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  FileAssetBuilder() {
    FileAsset._defaults(this);
  }

  FileAssetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _companyId = $v.companyId;
      _createdBy = $v.createdBy;
      _purpose = $v.purpose;
      _originalName = $v.originalName;
      _mimeType = $v.mimeType;
      _size = $v.size;
      _checksumSha256 = $v.checksumSha256;
      _status = $v.status;
      _scanStatus = $v.scanStatus;
      _rejectionReason = $v.rejectionReason;
      _attachedType = $v.attachedType;
      _attachedId = $v.attachedId;
      _pendingExpiresAt = $v.pendingExpiresAt;
      _retentionUntil = $v.retentionUntil;
      _uploadedAt = $v.uploadedAt;
      _finalizedAt = $v.finalizedAt;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FileAsset other) {
    _$v = other as _$FileAsset;
  }

  @override
  void update(void Function(FileAssetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FileAsset build() => _build();

  _$FileAsset _build() {
    final _$result = _$v ??
        _$FileAsset._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'FileAsset', 'id'),
          companyId: BuiltValueNullFieldError.checkNotNull(
              companyId, r'FileAsset', 'companyId'),
          createdBy: BuiltValueNullFieldError.checkNotNull(
              createdBy, r'FileAsset', 'createdBy'),
          purpose: BuiltValueNullFieldError.checkNotNull(
              purpose, r'FileAsset', 'purpose'),
          originalName: BuiltValueNullFieldError.checkNotNull(
              originalName, r'FileAsset', 'originalName'),
          mimeType: BuiltValueNullFieldError.checkNotNull(
              mimeType, r'FileAsset', 'mimeType'),
          size:
              BuiltValueNullFieldError.checkNotNull(size, r'FileAsset', 'size'),
          checksumSha256: BuiltValueNullFieldError.checkNotNull(
              checksumSha256, r'FileAsset', 'checksumSha256'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'FileAsset', 'status'),
          scanStatus: BuiltValueNullFieldError.checkNotNull(
              scanStatus, r'FileAsset', 'scanStatus'),
          rejectionReason: rejectionReason,
          attachedType: attachedType,
          attachedId: attachedId,
          pendingExpiresAt: BuiltValueNullFieldError.checkNotNull(
              pendingExpiresAt, r'FileAsset', 'pendingExpiresAt'),
          retentionUntil: retentionUntil,
          uploadedAt: uploadedAt,
          finalizedAt: finalizedAt,
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'FileAsset', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
