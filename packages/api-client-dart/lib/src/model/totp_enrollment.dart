//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'totp_enrollment.g.dart';

/// TotpEnrollment
///
/// Properties:
/// * [secret] - Setup secret returned only while enrollment is pending.
/// * [otpauthUrl]
/// * [status]
@BuiltValue()
abstract class TotpEnrollment implements Built<TotpEnrollment, TotpEnrollmentBuilder> {
  /// Setup secret returned only while enrollment is pending.
  @BuiltValueField(wireName: r'secret')
  String get secret;

  @BuiltValueField(wireName: r'otpauth_url')
  String get otpauthUrl;

  @BuiltValueField(wireName: r'status')
  JsonObject? get status;

  TotpEnrollment._();

  factory TotpEnrollment([void updates(TotpEnrollmentBuilder b)]) = _$TotpEnrollment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TotpEnrollmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TotpEnrollment> get serializer => _$TotpEnrollmentSerializer();
}

class _$TotpEnrollmentSerializer implements PrimitiveSerializer<TotpEnrollment> {
  @override
  final Iterable<Type> types = const [TotpEnrollment, _$TotpEnrollment];

  @override
  final String wireName = r'TotpEnrollment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TotpEnrollment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'secret';
    yield serializers.serialize(
      object.secret,
      specifiedType: const FullType(String),
    );
    yield r'otpauth_url';
    yield serializers.serialize(
      object.otpauthUrl,
      specifiedType: const FullType(String),
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
    TotpEnrollment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TotpEnrollmentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'secret':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.secret = valueDes;
          break;
        case r'otpauth_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.otpauthUrl = valueDes;
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
  TotpEnrollment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TotpEnrollmentBuilder();
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
