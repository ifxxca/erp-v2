//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'password_confirmation.g.dart';

/// PasswordConfirmation
///
/// Properties:
/// * [password]
@BuiltValue()
abstract class PasswordConfirmation implements Built<PasswordConfirmation, PasswordConfirmationBuilder> {
  @BuiltValueField(wireName: r'password')
  String get password;

  PasswordConfirmation._();

  factory PasswordConfirmation([void updates(PasswordConfirmationBuilder b)]) = _$PasswordConfirmation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PasswordConfirmationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PasswordConfirmation> get serializer => _$PasswordConfirmationSerializer();
}

class _$PasswordConfirmationSerializer implements PrimitiveSerializer<PasswordConfirmation> {
  @override
  final Iterable<Type> types = const [PasswordConfirmation, _$PasswordConfirmation];

  @override
  final String wireName = r'PasswordConfirmation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PasswordConfirmation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PasswordConfirmation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PasswordConfirmationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PasswordConfirmation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PasswordConfirmationBuilder();
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
