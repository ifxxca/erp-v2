//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recovery_code_set.g.dart';

/// RecoveryCodeSet
///
/// Properties:
/// * [recoveryCodes]
@BuiltValue(instantiable: false)
abstract class RecoveryCodeSet  {
  @BuiltValueField(wireName: r'recovery_codes')
  BuiltSet<String> get recoveryCodes;

  @BuiltValueSerializer(custom: true)
  static Serializer<RecoveryCodeSet> get serializer => _$RecoveryCodeSetSerializer();
}

class _$RecoveryCodeSetSerializer implements PrimitiveSerializer<RecoveryCodeSet> {
  @override
  final Iterable<Type> types = const [RecoveryCodeSet];

  @override
  final String wireName = r'RecoveryCodeSet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RecoveryCodeSet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'recovery_codes';
    yield serializers.serialize(
      object.recoveryCodes,
      specifiedType: const FullType(BuiltSet, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RecoveryCodeSet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  RecoveryCodeSet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($RecoveryCodeSet)) as $RecoveryCodeSet;
  }
}

/// a concrete implementation of [RecoveryCodeSet], since [RecoveryCodeSet] is not instantiable
@BuiltValue(instantiable: true)
abstract class $RecoveryCodeSet implements RecoveryCodeSet, Built<$RecoveryCodeSet, $RecoveryCodeSetBuilder> {
  $RecoveryCodeSet._();

  factory $RecoveryCodeSet([void Function($RecoveryCodeSetBuilder)? updates]) = _$$RecoveryCodeSet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($RecoveryCodeSetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$RecoveryCodeSet> get serializer => _$$RecoveryCodeSetSerializer();
}

class _$$RecoveryCodeSetSerializer implements PrimitiveSerializer<$RecoveryCodeSet> {
  @override
  final Iterable<Type> types = const [$RecoveryCodeSet, _$$RecoveryCodeSet];

  @override
  final String wireName = r'$RecoveryCodeSet';

  @override
  Object serialize(
    Serializers serializers,
    $RecoveryCodeSet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(RecoveryCodeSet))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RecoveryCodeSetBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $RecoveryCodeSet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $RecoveryCodeSetBuilder();
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
