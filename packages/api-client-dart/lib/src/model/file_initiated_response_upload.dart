//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_initiated_response_upload.g.dart';

/// FileInitiatedResponseUpload
///
/// Properties:
/// * [method]
/// * [url]
/// * [contentType]
/// * [field]
/// * [expiresAt]
@BuiltValue()
abstract class FileInitiatedResponseUpload implements Built<FileInitiatedResponseUpload, FileInitiatedResponseUploadBuilder> {
  @BuiltValueField(wireName: r'method')
  JsonObject? get method;

  @BuiltValueField(wireName: r'url')
  String get url;

  @BuiltValueField(wireName: r'content_type')
  JsonObject? get contentType;

  @BuiltValueField(wireName: r'field')
  JsonObject? get field;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  FileInitiatedResponseUpload._();

  factory FileInitiatedResponseUpload([void updates(FileInitiatedResponseUploadBuilder b)]) = _$FileInitiatedResponseUpload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileInitiatedResponseUploadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileInitiatedResponseUpload> get serializer => _$FileInitiatedResponseUploadSerializer();
}

class _$FileInitiatedResponseUploadSerializer implements PrimitiveSerializer<FileInitiatedResponseUpload> {
  @override
  final Iterable<Type> types = const [FileInitiatedResponseUpload, _$FileInitiatedResponseUpload];

  @override
  final String wireName = r'FileInitiatedResponseUpload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileInitiatedResponseUpload object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'method';
    yield object.method == null ? null : serializers.serialize(
      object.method,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'url';
    yield serializers.serialize(
      object.url,
      specifiedType: const FullType(String),
    );
    yield r'content_type';
    yield object.contentType == null ? null : serializers.serialize(
      object.contentType,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'field';
    yield object.field == null ? null : serializers.serialize(
      object.field,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FileInitiatedResponseUpload object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FileInitiatedResponseUploadBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.method = valueDes;
          break;
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        case r'content_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.contentType = valueDes;
          break;
        case r'field':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.field = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FileInitiatedResponseUpload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileInitiatedResponseUploadBuilder();
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
