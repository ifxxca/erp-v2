//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/file_asset.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_response.g.dart';

/// FileResponse
///
/// Properties:
/// * [data]
@BuiltValue()
abstract class FileResponse implements Built<FileResponse, FileResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  FileAsset get data;

  FileResponse._();

  factory FileResponse([void updates(FileResponseBuilder b)]) = _$FileResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileResponse> get serializer => _$FileResponseSerializer();
}

class _$FileResponseSerializer implements PrimitiveSerializer<FileResponse> {
  @override
  final Iterable<Type> types = const [FileResponse, _$FileResponse];

  @override
  final String wireName = r'FileResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(FileAsset),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FileResponseBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FileResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileResponseBuilder();
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
