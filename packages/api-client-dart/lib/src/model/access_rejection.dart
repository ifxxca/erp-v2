//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'access_rejection.g.dart';

/// AccessRejection
///
/// Properties:
/// * [note]
@BuiltValue()
abstract class AccessRejection implements Built<AccessRejection, AccessRejectionBuilder> {
  @BuiltValueField(wireName: r'note')
  String get note;

  AccessRejection._();

  factory AccessRejection([void updates(AccessRejectionBuilder b)]) = _$AccessRejection;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccessRejectionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccessRejection> get serializer => _$AccessRejectionSerializer();
}

class _$AccessRejectionSerializer implements PrimitiveSerializer<AccessRejection> {
  @override
  final Iterable<Type> types = const [AccessRejection, _$AccessRejection];

  @override
  final String wireName = r'AccessRejection';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccessRejection object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'note';
    yield serializers.serialize(
      object.note,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccessRejection object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccessRejectionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccessRejection deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccessRejectionBuilder();
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
