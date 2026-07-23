//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'initiate_file_request.g.dart';

/// InitiateFileRequest
///
/// Properties:
/// * [purpose]
/// * [originalName]
/// * [mimeType]
/// * [size]
/// * [checksumSha256]
@BuiltValue()
abstract class InitiateFileRequest implements Built<InitiateFileRequest, InitiateFileRequestBuilder> {
  @BuiltValueField(wireName: r'purpose')
  InitiateFileRequestPurposeEnum get purpose;
  // enum purposeEnum {  checklist_evidence,  vehicle_document,  work_order_attachment,  };

  @BuiltValueField(wireName: r'original_name')
  String get originalName;

  @BuiltValueField(wireName: r'mime_type')
  InitiateFileRequestMimeTypeEnum get mimeType;
  // enum mimeTypeEnum {  application/pdf,  image/jpeg,  image/png,  image/webp,  };

  @BuiltValueField(wireName: r'size')
  int get size;

  @BuiltValueField(wireName: r'checksum_sha256')
  String get checksumSha256;

  InitiateFileRequest._();

  factory InitiateFileRequest([void updates(InitiateFileRequestBuilder b)]) = _$InitiateFileRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InitiateFileRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InitiateFileRequest> get serializer => _$InitiateFileRequestSerializer();
}

class _$InitiateFileRequestSerializer implements PrimitiveSerializer<InitiateFileRequest> {
  @override
  final Iterable<Type> types = const [InitiateFileRequest, _$InitiateFileRequest];

  @override
  final String wireName = r'InitiateFileRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InitiateFileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'purpose';
    yield serializers.serialize(
      object.purpose,
      specifiedType: const FullType(InitiateFileRequestPurposeEnum),
    );
    yield r'original_name';
    yield serializers.serialize(
      object.originalName,
      specifiedType: const FullType(String),
    );
    yield r'mime_type';
    yield serializers.serialize(
      object.mimeType,
      specifiedType: const FullType(InitiateFileRequestMimeTypeEnum),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    InitiateFileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InitiateFileRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'purpose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(InitiateFileRequestPurposeEnum),
          ) as InitiateFileRequestPurposeEnum;
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
            specifiedType: const FullType(InitiateFileRequestMimeTypeEnum),
          ) as InitiateFileRequestMimeTypeEnum;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InitiateFileRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InitiateFileRequestBuilder();
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

class InitiateFileRequestPurposeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'checklist_evidence')
  static const InitiateFileRequestPurposeEnum checklistEvidence = _$initiateFileRequestPurposeEnum_checklistEvidence;
  @BuiltValueEnumConst(wireName: r'vehicle_document')
  static const InitiateFileRequestPurposeEnum vehicleDocument = _$initiateFileRequestPurposeEnum_vehicleDocument;
  @BuiltValueEnumConst(wireName: r'work_order_attachment')
  static const InitiateFileRequestPurposeEnum workOrderAttachment = _$initiateFileRequestPurposeEnum_workOrderAttachment;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const InitiateFileRequestPurposeEnum unknownDefaultOpenApi = _$initiateFileRequestPurposeEnum_unknownDefaultOpenApi;

  static Serializer<InitiateFileRequestPurposeEnum> get serializer => _$initiateFileRequestPurposeEnumSerializer;

  const InitiateFileRequestPurposeEnum._(String name): super(name);

  static BuiltSet<InitiateFileRequestPurposeEnum> get values => _$initiateFileRequestPurposeEnumValues;
  static InitiateFileRequestPurposeEnum valueOf(String name) => _$initiateFileRequestPurposeEnumValueOf(name);
}

class InitiateFileRequestMimeTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'application/pdf')
  static const InitiateFileRequestMimeTypeEnum applicationSlashPdf = _$initiateFileRequestMimeTypeEnum_applicationSlashPdf;
  @BuiltValueEnumConst(wireName: r'image/jpeg')
  static const InitiateFileRequestMimeTypeEnum imageSlashJpeg = _$initiateFileRequestMimeTypeEnum_imageSlashJpeg;
  @BuiltValueEnumConst(wireName: r'image/png')
  static const InitiateFileRequestMimeTypeEnum imageSlashPng = _$initiateFileRequestMimeTypeEnum_imageSlashPng;
  @BuiltValueEnumConst(wireName: r'image/webp')
  static const InitiateFileRequestMimeTypeEnum imageSlashWebp = _$initiateFileRequestMimeTypeEnum_imageSlashWebp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const InitiateFileRequestMimeTypeEnum unknownDefaultOpenApi = _$initiateFileRequestMimeTypeEnum_unknownDefaultOpenApi;

  static Serializer<InitiateFileRequestMimeTypeEnum> get serializer => _$initiateFileRequestMimeTypeEnumSerializer;

  const InitiateFileRequestMimeTypeEnum._(String name): super(name);

  static BuiltSet<InitiateFileRequestMimeTypeEnum> get values => _$initiateFileRequestMimeTypeEnumValues;
  static InitiateFileRequestMimeTypeEnum valueOf(String name) => _$initiateFileRequestMimeTypeEnumValueOf(name);
}
