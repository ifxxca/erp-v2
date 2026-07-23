//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mfa_challenge.g.dart';

/// MfaChallenge
///
/// Properties:
/// * [credential] - Six-digit TOTP or formatted recovery code.
@BuiltValue()
abstract class MfaChallenge implements Built<MfaChallenge, MfaChallengeBuilder> {
  /// Six-digit TOTP or formatted recovery code.
  @BuiltValueField(wireName: r'credential')
  String get credential;

  MfaChallenge._();

  factory MfaChallenge([void updates(MfaChallengeBuilder b)]) = _$MfaChallenge;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MfaChallengeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MfaChallenge> get serializer => _$MfaChallengeSerializer();
}

class _$MfaChallengeSerializer implements PrimitiveSerializer<MfaChallenge> {
  @override
  final Iterable<Type> types = const [MfaChallenge, _$MfaChallenge];

  @override
  final String wireName = r'MfaChallenge';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MfaChallenge object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'credential';
    yield serializers.serialize(
      object.credential,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MfaChallenge object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MfaChallengeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'credential':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.credential = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MfaChallenge deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MfaChallengeBuilder();
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
