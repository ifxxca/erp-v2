//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'access_decision.g.dart';

/// AccessDecision
///
/// Properties:
/// * [note]
@BuiltValue()
abstract class AccessDecision implements Built<AccessDecision, AccessDecisionBuilder> {
  @BuiltValueField(wireName: r'note')
  String? get note;

  AccessDecision._();

  factory AccessDecision([void updates(AccessDecisionBuilder b)]) = _$AccessDecision;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccessDecisionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccessDecision> get serializer => _$AccessDecisionSerializer();
}

class _$AccessDecisionSerializer implements PrimitiveSerializer<AccessDecision> {
  @override
  final Iterable<Type> types = const [AccessDecision, _$AccessDecision];

  @override
  final String wireName = r'AccessDecision';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccessDecision object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccessDecision object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccessDecisionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
  AccessDecision deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccessDecisionBuilder();
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
