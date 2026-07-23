// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_file_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const InitiateFileRequestPurposeEnum
    _$initiateFileRequestPurposeEnum_checklistEvidence =
    const InitiateFileRequestPurposeEnum._('checklistEvidence');
const InitiateFileRequestPurposeEnum
    _$initiateFileRequestPurposeEnum_vehicleDocument =
    const InitiateFileRequestPurposeEnum._('vehicleDocument');
const InitiateFileRequestPurposeEnum
    _$initiateFileRequestPurposeEnum_workOrderAttachment =
    const InitiateFileRequestPurposeEnum._('workOrderAttachment');
const InitiateFileRequestPurposeEnum
    _$initiateFileRequestPurposeEnum_unknownDefaultOpenApi =
    const InitiateFileRequestPurposeEnum._('unknownDefaultOpenApi');

InitiateFileRequestPurposeEnum _$initiateFileRequestPurposeEnumValueOf(
    String name) {
  switch (name) {
    case 'checklistEvidence':
      return _$initiateFileRequestPurposeEnum_checklistEvidence;
    case 'vehicleDocument':
      return _$initiateFileRequestPurposeEnum_vehicleDocument;
    case 'workOrderAttachment':
      return _$initiateFileRequestPurposeEnum_workOrderAttachment;
    case 'unknownDefaultOpenApi':
      return _$initiateFileRequestPurposeEnum_unknownDefaultOpenApi;
    default:
      return _$initiateFileRequestPurposeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<InitiateFileRequestPurposeEnum>
    _$initiateFileRequestPurposeEnumValues = BuiltSet<
        InitiateFileRequestPurposeEnum>(const <InitiateFileRequestPurposeEnum>[
  _$initiateFileRequestPurposeEnum_checklistEvidence,
  _$initiateFileRequestPurposeEnum_vehicleDocument,
  _$initiateFileRequestPurposeEnum_workOrderAttachment,
  _$initiateFileRequestPurposeEnum_unknownDefaultOpenApi,
]);

const InitiateFileRequestMimeTypeEnum
    _$initiateFileRequestMimeTypeEnum_applicationSlashPdf =
    const InitiateFileRequestMimeTypeEnum._('applicationSlashPdf');
const InitiateFileRequestMimeTypeEnum
    _$initiateFileRequestMimeTypeEnum_imageSlashJpeg =
    const InitiateFileRequestMimeTypeEnum._('imageSlashJpeg');
const InitiateFileRequestMimeTypeEnum
    _$initiateFileRequestMimeTypeEnum_imageSlashPng =
    const InitiateFileRequestMimeTypeEnum._('imageSlashPng');
const InitiateFileRequestMimeTypeEnum
    _$initiateFileRequestMimeTypeEnum_imageSlashWebp =
    const InitiateFileRequestMimeTypeEnum._('imageSlashWebp');
const InitiateFileRequestMimeTypeEnum
    _$initiateFileRequestMimeTypeEnum_unknownDefaultOpenApi =
    const InitiateFileRequestMimeTypeEnum._('unknownDefaultOpenApi');

InitiateFileRequestMimeTypeEnum _$initiateFileRequestMimeTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'applicationSlashPdf':
      return _$initiateFileRequestMimeTypeEnum_applicationSlashPdf;
    case 'imageSlashJpeg':
      return _$initiateFileRequestMimeTypeEnum_imageSlashJpeg;
    case 'imageSlashPng':
      return _$initiateFileRequestMimeTypeEnum_imageSlashPng;
    case 'imageSlashWebp':
      return _$initiateFileRequestMimeTypeEnum_imageSlashWebp;
    case 'unknownDefaultOpenApi':
      return _$initiateFileRequestMimeTypeEnum_unknownDefaultOpenApi;
    default:
      return _$initiateFileRequestMimeTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<InitiateFileRequestMimeTypeEnum>
    _$initiateFileRequestMimeTypeEnumValues = BuiltSet<
        InitiateFileRequestMimeTypeEnum>(const <InitiateFileRequestMimeTypeEnum>[
  _$initiateFileRequestMimeTypeEnum_applicationSlashPdf,
  _$initiateFileRequestMimeTypeEnum_imageSlashJpeg,
  _$initiateFileRequestMimeTypeEnum_imageSlashPng,
  _$initiateFileRequestMimeTypeEnum_imageSlashWebp,
  _$initiateFileRequestMimeTypeEnum_unknownDefaultOpenApi,
]);

Serializer<InitiateFileRequestPurposeEnum>
    _$initiateFileRequestPurposeEnumSerializer =
    _$InitiateFileRequestPurposeEnumSerializer();
Serializer<InitiateFileRequestMimeTypeEnum>
    _$initiateFileRequestMimeTypeEnumSerializer =
    _$InitiateFileRequestMimeTypeEnumSerializer();

class _$InitiateFileRequestPurposeEnumSerializer
    implements PrimitiveSerializer<InitiateFileRequestPurposeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'checklistEvidence': 'checklist_evidence',
    'vehicleDocument': 'vehicle_document',
    'workOrderAttachment': 'work_order_attachment',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'checklist_evidence': 'checklistEvidence',
    'vehicle_document': 'vehicleDocument',
    'work_order_attachment': 'workOrderAttachment',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[InitiateFileRequestPurposeEnum];
  @override
  final String wireName = 'InitiateFileRequestPurposeEnum';

  @override
  Object serialize(
          Serializers serializers, InitiateFileRequestPurposeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  InitiateFileRequestPurposeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      InitiateFileRequestPurposeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$InitiateFileRequestMimeTypeEnumSerializer
    implements PrimitiveSerializer<InitiateFileRequestMimeTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'applicationSlashPdf': 'application/pdf',
    'imageSlashJpeg': 'image/jpeg',
    'imageSlashPng': 'image/png',
    'imageSlashWebp': 'image/webp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'application/pdf': 'applicationSlashPdf',
    'image/jpeg': 'imageSlashJpeg',
    'image/png': 'imageSlashPng',
    'image/webp': 'imageSlashWebp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[InitiateFileRequestMimeTypeEnum];
  @override
  final String wireName = 'InitiateFileRequestMimeTypeEnum';

  @override
  Object serialize(
          Serializers serializers, InitiateFileRequestMimeTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  InitiateFileRequestMimeTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      InitiateFileRequestMimeTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$InitiateFileRequest extends InitiateFileRequest {
  @override
  final InitiateFileRequestPurposeEnum purpose;
  @override
  final String originalName;
  @override
  final InitiateFileRequestMimeTypeEnum mimeType;
  @override
  final int size;
  @override
  final String checksumSha256;

  factory _$InitiateFileRequest(
          [void Function(InitiateFileRequestBuilder)? updates]) =>
      (InitiateFileRequestBuilder()..update(updates))._build();

  _$InitiateFileRequest._(
      {required this.purpose,
      required this.originalName,
      required this.mimeType,
      required this.size,
      required this.checksumSha256})
      : super._();
  @override
  InitiateFileRequest rebuild(
          void Function(InitiateFileRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InitiateFileRequestBuilder toBuilder() =>
      InitiateFileRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InitiateFileRequest &&
        purpose == other.purpose &&
        originalName == other.originalName &&
        mimeType == other.mimeType &&
        size == other.size &&
        checksumSha256 == other.checksumSha256;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, purpose.hashCode);
    _$hash = $jc(_$hash, originalName.hashCode);
    _$hash = $jc(_$hash, mimeType.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, checksumSha256.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InitiateFileRequest')
          ..add('purpose', purpose)
          ..add('originalName', originalName)
          ..add('mimeType', mimeType)
          ..add('size', size)
          ..add('checksumSha256', checksumSha256))
        .toString();
  }
}

class InitiateFileRequestBuilder
    implements Builder<InitiateFileRequest, InitiateFileRequestBuilder> {
  _$InitiateFileRequest? _$v;

  InitiateFileRequestPurposeEnum? _purpose;
  InitiateFileRequestPurposeEnum? get purpose => _$this._purpose;
  set purpose(InitiateFileRequestPurposeEnum? purpose) =>
      _$this._purpose = purpose;

  String? _originalName;
  String? get originalName => _$this._originalName;
  set originalName(String? originalName) => _$this._originalName = originalName;

  InitiateFileRequestMimeTypeEnum? _mimeType;
  InitiateFileRequestMimeTypeEnum? get mimeType => _$this._mimeType;
  set mimeType(InitiateFileRequestMimeTypeEnum? mimeType) =>
      _$this._mimeType = mimeType;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  String? _checksumSha256;
  String? get checksumSha256 => _$this._checksumSha256;
  set checksumSha256(String? checksumSha256) =>
      _$this._checksumSha256 = checksumSha256;

  InitiateFileRequestBuilder() {
    InitiateFileRequest._defaults(this);
  }

  InitiateFileRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _purpose = $v.purpose;
      _originalName = $v.originalName;
      _mimeType = $v.mimeType;
      _size = $v.size;
      _checksumSha256 = $v.checksumSha256;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InitiateFileRequest other) {
    _$v = other as _$InitiateFileRequest;
  }

  @override
  void update(void Function(InitiateFileRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InitiateFileRequest build() => _build();

  _$InitiateFileRequest _build() {
    final _$result = _$v ??
        _$InitiateFileRequest._(
          purpose: BuiltValueNullFieldError.checkNotNull(
              purpose, r'InitiateFileRequest', 'purpose'),
          originalName: BuiltValueNullFieldError.checkNotNull(
              originalName, r'InitiateFileRequest', 'originalName'),
          mimeType: BuiltValueNullFieldError.checkNotNull(
              mimeType, r'InitiateFileRequest', 'mimeType'),
          size: BuiltValueNullFieldError.checkNotNull(
              size, r'InitiateFileRequest', 'size'),
          checksumSha256: BuiltValueNullFieldError.checkNotNull(
              checksumSha256, r'InitiateFileRequest', 'checksumSha256'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
