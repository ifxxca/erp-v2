//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'totp_code.g.dart';

/// TotpCode
///
/// Properties:
/// * [code]
@BuiltValue()
abstract class TotpCode implements Built<TotpCode, TotpCodeBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  TotpCode._();

  factory TotpCode([void updates(TotpCodeBuilder b)]) = _$TotpCode;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TotpCodeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TotpCode> get serializer => _$TotpCodeSerializer();
}

class _$TotpCodeSerializer implements PrimitiveSerializer<TotpCode> {
  @override
  final Iterable<Type> types = const [TotpCode, _$TotpCode];

  @override
  final String wireName = r'TotpCode';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TotpCode object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TotpCode object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TotpCodeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TotpCode deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TotpCodeBuilder();
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
