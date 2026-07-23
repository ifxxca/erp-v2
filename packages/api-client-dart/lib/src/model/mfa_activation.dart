//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/recovery_code_set.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mfa_activation.g.dart';

/// MfaActivation
///
/// Properties:
/// * [recoveryCodes]
/// * [status]
@BuiltValue()
abstract class MfaActivation implements RecoveryCodeSet, Built<MfaActivation, MfaActivationBuilder> {
  @BuiltValueField(wireName: r'status')
  JsonObject? get status;

  MfaActivation._();

  factory MfaActivation([void updates(MfaActivationBuilder b)]) = _$MfaActivation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MfaActivationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MfaActivation> get serializer => _$MfaActivationSerializer();
}

class _$MfaActivationSerializer implements PrimitiveSerializer<MfaActivation> {
  @override
  final Iterable<Type> types = const [MfaActivation, _$MfaActivation];

  @override
  final String wireName = r'MfaActivation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MfaActivation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'recovery_codes';
    yield serializers.serialize(
      object.recoveryCodes,
      specifiedType: const FullType(BuiltSet, [FullType(String)]),
    );
    yield r'status';
    yield object.status == null ? null : serializers.serialize(
      object.status,
      specifiedType: const FullType.nullable(JsonObject),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MfaActivation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MfaActivationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'recovery_codes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>;
          result.recoveryCodes.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MfaActivation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MfaActivationBuilder();
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
