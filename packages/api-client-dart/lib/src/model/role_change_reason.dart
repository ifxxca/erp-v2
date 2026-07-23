//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_change_reason.g.dart';

/// RoleChangeReason
///
/// Properties:
/// * [reason]
@BuiltValue(instantiable: false)
abstract class RoleChangeReason  {
  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleChangeReason> get serializer => _$RoleChangeReasonSerializer();
}

class _$RoleChangeReasonSerializer implements PrimitiveSerializer<RoleChangeReason> {
  @override
  final Iterable<Type> types = const [RoleChangeReason];

  @override
  final String wireName = r'RoleChangeReason';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleChangeReason object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleChangeReason object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  RoleChangeReason deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($RoleChangeReason)) as $RoleChangeReason;
  }
}

/// a concrete implementation of [RoleChangeReason], since [RoleChangeReason] is not instantiable
@BuiltValue(instantiable: true)
abstract class $RoleChangeReason implements RoleChangeReason, Built<$RoleChangeReason, $RoleChangeReasonBuilder> {
  $RoleChangeReason._();

  factory $RoleChangeReason([void Function($RoleChangeReasonBuilder)? updates]) = _$$RoleChangeReason;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($RoleChangeReasonBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$RoleChangeReason> get serializer => _$$RoleChangeReasonSerializer();
}

class _$$RoleChangeReasonSerializer implements PrimitiveSerializer<$RoleChangeReason> {
  @override
  final Iterable<Type> types = const [$RoleChangeReason, _$$RoleChangeReason];

  @override
  final String wireName = r'$RoleChangeReason';

  @override
  Object serialize(
    Serializers serializers,
    $RoleChangeReason object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(RoleChangeReason))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RoleChangeReasonBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $RoleChangeReason deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $RoleChangeReasonBuilder();
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
