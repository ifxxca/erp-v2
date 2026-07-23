//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/file_asset.dart';
import 'package:rajawali_api_client/src/model/file_initiated_response_upload.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_initiated_response.g.dart';

/// FileInitiatedResponse
///
/// Properties:
/// * [data]
/// * [upload]
@BuiltValue()
abstract class FileInitiatedResponse implements Built<FileInitiatedResponse, FileInitiatedResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  FileAsset get data;

  @BuiltValueField(wireName: r'upload')
  FileInitiatedResponseUpload get upload;

  FileInitiatedResponse._();

  factory FileInitiatedResponse([void updates(FileInitiatedResponseBuilder b)]) = _$FileInitiatedResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileInitiatedResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileInitiatedResponse> get serializer => _$FileInitiatedResponseSerializer();
}

class _$FileInitiatedResponseSerializer implements PrimitiveSerializer<FileInitiatedResponse> {
  @override
  final Iterable<Type> types = const [FileInitiatedResponse, _$FileInitiatedResponse];

  @override
  final String wireName = r'FileInitiatedResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileInitiatedResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(FileAsset),
    );
    yield r'upload';
    yield serializers.serialize(
      object.upload,
      specifiedType: const FullType(FileInitiatedResponseUpload),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FileInitiatedResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FileInitiatedResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FileAsset),
          ) as FileAsset;
          result.data.replace(valueDes);
          break;
        case r'upload':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FileInitiatedResponseUpload),
          ) as FileInitiatedResponseUpload;
          result.upload.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FileInitiatedResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileInitiatedResponseBuilder();
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
