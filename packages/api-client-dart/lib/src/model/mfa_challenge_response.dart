//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mfa_challenge_response.g.dart';

/// MfaChallengeResponse
///
/// Properties:
/// * [status]
/// * [method]
/// * [stepUpExpiresAt]
@BuiltValue()
abstract class MfaChallengeResponse implements Built<MfaChallengeResponse, MfaChallengeResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  JsonObject? get status;

  @BuiltValueField(wireName: r'method')
  MfaChallengeResponseMethodEnum get method;
  // enum methodEnum {  totp,  recovery_code,  };

  @BuiltValueField(wireName: r'step_up_expires_at')
  DateTime get stepUpExpiresAt;

  MfaChallengeResponse._();

  factory MfaChallengeResponse([void updates(MfaChallengeResponseBuilder b)]) = _$MfaChallengeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MfaChallengeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MfaChallengeResponse> get serializer => _$MfaChallengeResponseSerializer();
}

class _$MfaChallengeResponseSerializer implements PrimitiveSerializer<MfaChallengeResponse> {
  @override
  final Iterable<Type> types = const [MfaChallengeResponse, _$MfaChallengeResponse];

  @override
  final String wireName = r'MfaChallengeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MfaChallengeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield object.status == null ? null : serializers.serialize(
      object.status,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'method';
    yield serializers.serialize(
      object.method,
      specifiedType: const FullType(MfaChallengeResponseMethodEnum),
    );
    yield r'step_up_expires_at';
    yield serializers.serialize(
      object.stepUpExpiresAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MfaChallengeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MfaChallengeResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MfaChallengeResponseMethodEnum),
          ) as MfaChallengeResponseMethodEnum;
          result.method = valueDes;
          break;
        case r'step_up_expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.stepUpExpiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MfaChallengeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MfaChallengeResponseBuilder();
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

class MfaChallengeResponseMethodEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'totp')
  static const MfaChallengeResponseMethodEnum totp = _$mfaChallengeResponseMethodEnum_totp;
  @BuiltValueEnumConst(wireName: r'recovery_code')
  static const MfaChallengeResponseMethodEnum recoveryCode = _$mfaChallengeResponseMethodEnum_recoveryCode;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MfaChallengeResponseMethodEnum unknownDefaultOpenApi = _$mfaChallengeResponseMethodEnum_unknownDefaultOpenApi;

  static Serializer<MfaChallengeResponseMethodEnum> get serializer => _$mfaChallengeResponseMethodEnumSerializer;

  const MfaChallengeResponseMethodEnum._(String name): super(name);

  static BuiltSet<MfaChallengeResponseMethodEnum> get values => _$mfaChallengeResponseMethodEnumValues;
  static MfaChallengeResponseMethodEnum valueOf(String name) => _$mfaChallengeResponseMethodEnumValueOf(name);
}
