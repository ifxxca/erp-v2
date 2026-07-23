//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_summary.g.dart';

/// UserSummary
///
/// Properties:
/// * [id]
/// * [name]
/// * [email]
@BuiltValue(instantiable: false)
abstract class UserSummary  {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserSummary> get serializer => _$UserSummarySerializer();
}

class _$UserSummarySerializer implements PrimitiveSerializer<UserSummary> {
  @override
  final Iterable<Type> types = const [UserSummary];

  @override
  final String wireName = r'UserSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  UserSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($UserSummary)) as $UserSummary;
  }
}

/// a concrete implementation of [UserSummary], since [UserSummary] is not instantiable
@BuiltValue(instantiable: true)
abstract class $UserSummary implements UserSummary, Built<$UserSummary, $UserSummaryBuilder> {
  $UserSummary._();

  factory $UserSummary([void Function($UserSummaryBuilder)? updates]) = _$$UserSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($UserSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$UserSummary> get serializer => _$$UserSummarySerializer();
}

class _$$UserSummarySerializer implements PrimitiveSerializer<$UserSummary> {
  @override
  final Iterable<Type> types = const [$UserSummary, _$$UserSummary];

  @override
  final String wireName = r'$UserSummary';

  @override
  Object serialize(
    Serializers serializers,
    $UserSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(UserSummary))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $UserSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $UserSummaryBuilder();
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
