//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_asset.g.dart';

/// FileAsset
///
/// Properties:
/// * [id]
/// * [companyId]
/// * [createdBy]
/// * [purpose]
/// * [originalName]
/// * [mimeType]
/// * [size]
/// * [checksumSha256]
/// * [status]
/// * [scanStatus]
/// * [rejectionReason]
/// * [attachedType]
/// * [attachedId]
/// * [pendingExpiresAt]
/// * [retentionUntil]
/// * [uploadedAt]
/// * [finalizedAt]
/// * [createdAt]
@BuiltValue()
abstract class FileAsset implements Built<FileAsset, FileAssetBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'company_id')
  String get companyId;

  @BuiltValueField(wireName: r'created_by')
  String get createdBy;

  @BuiltValueField(wireName: r'purpose')
  String get purpose;

  @BuiltValueField(wireName: r'original_name')
  String get originalName;

  @BuiltValueField(wireName: r'mime_type')
  String get mimeType;

  @BuiltValueField(wireName: r'size')
  int get size;

  @BuiltValueField(wireName: r'checksum_sha256')
  String get checksumSha256;

  @BuiltValueField(wireName: r'status')
  FileAssetStatusEnum get status;
  // enum statusEnum {  pending,  uploaded,  quarantined,  ready,  rejected,  deleted,  expired,  };

  @BuiltValueField(wireName: r'scan_status')
  FileAssetScanStatusEnum get scanStatus;
  // enum scanStatusEnum {  not_started,  pending,  clean,  infected,  failed,  skipped,  };

  @BuiltValueField(wireName: r'rejection_reason')
  String? get rejectionReason;

  @BuiltValueField(wireName: r'attached_type')
  String? get attachedType;

  @BuiltValueField(wireName: r'attached_id')
  String? get attachedId;

  @BuiltValueField(wireName: r'pending_expires_at')
  DateTime get pendingExpiresAt;

  @BuiltValueField(wireName: r'retention_until')
  DateTime? get retentionUntil;

  @BuiltValueField(wireName: r'uploaded_at')
  DateTime? get uploadedAt;

  @BuiltValueField(wireName: r'finalized_at')
  DateTime? get finalizedAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  FileAsset._();

  factory FileAsset([void updates(FileAssetBuilder b)]) = _$FileAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileAsset> get serializer => _$FileAssetSerializer();
}

class _$FileAssetSerializer implements PrimitiveSerializer<FileAsset> {
  @override
  final Iterable<Type> types = const [FileAsset, _$FileAsset];

  @override
  final String wireName = r'FileAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'company_id';
    yield serializers.serialize(
      object.companyId,
      specifiedType: const FullType(String),
    );
    yield r'created_by';
    yield serializers.serialize(
      object.createdBy,
      specifiedType: const FullType(String),
    );
    yield r'purpose';
    yield serializers.serialize(
      object.purpose,
      specifiedType: const FullType(String),
    );
    yield r'original_name';
    yield serializers.serialize(
      object.originalName,
      specifiedType: const FullType(String),
    );
    yield r'mime_type';
    yield serializers.serialize(
      object.mimeType,
      specifiedType: const FullType(String),
    );
    yield r'size';
    yield serializers.serialize(
      object.size,
      specifiedType: const FullType(int),
    );
    yield r'checksum_sha256';
    yield serializers.serialize(
      object.checksumSha256,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(FileAssetStatusEnum),
    );
    yield r'scan_status';
    yield serializers.serialize(
      object.scanStatus,
      specifiedType: const FullType(FileAssetScanStatusEnum),
    );
    if (object.rejectionReason != null) {
      yield r'rejection_reason';
      yield serializers.serialize(
        object.rejectionReason,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.attachedType != null) {
      yield r'attached_type';
      yield serializers.serialize(
        object.attachedType,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.attachedId != null) {
      yield r'attached_id';
      yield serializers.serialize(
        object.attachedId,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'pending_expires_at';
    yield serializers.serialize(
      object.pendingExpiresAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.retentionUntil != null) {
      yield r'retention_until';
      yield serializers.serialize(
        object.retentionUntil,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.uploadedAt != null) {
      yield r'uploaded_at';
      yield serializers.serialize(
        object.uploadedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.finalizedAt != null) {
      yield r'finalized_at';
      yield serializers.serialize(
        object.finalizedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FileAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FileAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'company_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.companyId = valueDes;
          break;
        case r'created_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdBy = valueDes;
          break;
        case r'purpose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.purpose = valueDes;
          break;
        case r'original_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.originalName = valueDes;
          break;
        case r'mime_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mimeType = valueDes;
          break;
        case r'size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.size = valueDes;
          break;
        case r'checksum_sha256':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.checksumSha256 = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FileAssetStatusEnum),
          ) as FileAssetStatusEnum;
          result.status = valueDes;
          break;
        case r'scan_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FileAssetScanStatusEnum),
          ) as FileAssetScanStatusEnum;
          result.scanStatus = valueDes;
          break;
        case r'rejection_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.rejectionReason = valueDes;
          break;
        case r'attached_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.attachedType = valueDes;
          break;
        case r'attached_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.attachedId = valueDes;
          break;
        case r'pending_expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.pendingExpiresAt = valueDes;
          break;
        case r'retention_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.retentionUntil = valueDes;
          break;
        case r'uploaded_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.uploadedAt = valueDes;
          break;
        case r'finalized_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.finalizedAt = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FileAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileAssetBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class FileAssetStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const FileAssetStatusEnum pending = _$fileAssetStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'uploaded')
  static const FileAssetStatusEnum uploaded = _$fileAssetStatusEnum_uploaded;
  @BuiltValueEnumConst(wireName: r'quarantined')
  static const FileAssetStatusEnum quarantined = _$fileAssetStatusEnum_quarantined;
  @BuiltValueEnumConst(wireName: r'ready')
  static const FileAssetStatusEnum ready = _$fileAssetStatusEnum_ready;
  @BuiltValueEnumConst(wireName: r'rejected')
  static const FileAssetStatusEnum rejected = _$fileAssetStatusEnum_rejected;
  @BuiltValueEnumConst(wireName: r'deleted')
  static const FileAssetStatusEnum deleted = _$fileAssetStatusEnum_deleted;
  @BuiltValueEnumConst(wireName: r'expired')
  static const FileAssetStatusEnum expired = _$fileAssetStatusEnum_expired;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FileAssetStatusEnum unknownDefaultOpenApi = _$fileAssetStatusEnum_unknownDefaultOpenApi;

  static Serializer<FileAssetStatusEnum> get serializer => _$fileAssetStatusEnumSerializer;

  const FileAssetStatusEnum._(String name): super(name);

  static BuiltSet<FileAssetStatusEnum> get values => _$fileAssetStatusEnumValues;
  static FileAssetStatusEnum valueOf(String name) => _$fileAssetStatusEnumValueOf(name);
}

class FileAssetScanStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'not_started')
  static const FileAssetScanStatusEnum notStarted = _$fileAssetScanStatusEnum_notStarted;
  @BuiltValueEnumConst(wireName: r'pending')
  static const FileAssetScanStatusEnum pending = _$fileAssetScanStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'clean')
  static const FileAssetScanStatusEnum clean = _$fileAssetScanStatusEnum_clean;
  @BuiltValueEnumConst(wireName: r'infected')
  static const FileAssetScanStatusEnum infected = _$fileAssetScanStatusEnum_infected;
  @BuiltValueEnumConst(wireName: r'failed')
  static const FileAssetScanStatusEnum failed = _$fileAssetScanStatusEnum_failed;
  @BuiltValueEnumConst(wireName: r'skipped')
  static const FileAssetScanStatusEnum skipped = _$fileAssetScanStatusEnum_skipped;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FileAssetScanStatusEnum unknownDefaultOpenApi = _$fileAssetScanStatusEnum_unknownDefaultOpenApi;

  static Serializer<FileAssetScanStatusEnum> get serializer => _$fileAssetScanStatusEnumSerializer;

  const FileAssetScanStatusEnum._(String name): super(name);

  static BuiltSet<FileAssetScanStatusEnum> get values => _$fileAssetScanStatusEnumValues;
  static FileAssetScanStatusEnum valueOf(String name) => _$fileAssetScanStatusEnumValueOf(name);
}
