//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_summary.g.dart';

/// RoleSummary
///
/// Properties:
/// * [id]
/// * [code]
/// * [name]
@BuiltValue(instantiable: false)
abstract class RoleSummary  {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleSummary> get serializer => _$RoleSummarySerializer();
}

class _$RoleSummarySerializer implements PrimitiveSerializer<RoleSummary> {
  @override
  final Iterable<Type> types = const [RoleSummary];

  @override
  final String wireName = r'RoleSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  RoleSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($RoleSummary)) as $RoleSummary;
  }
}

/// a concrete implementation of [RoleSummary], since [RoleSummary] is not instantiable
@BuiltValue(instantiable: true)
abstract class $RoleSummary implements RoleSummary, Built<$RoleSummary, $RoleSummaryBuilder> {
  $RoleSummary._();

  factory $RoleSummary([void Function($RoleSummaryBuilder)? updates]) = _$$RoleSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($RoleSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$RoleSummary> get serializer => _$$RoleSummarySerializer();
}

class _$$RoleSummarySerializer implements PrimitiveSerializer<$RoleSummary> {
  @override
  final Iterable<Type> types = const [$RoleSummary, _$$RoleSummary];

  @override
  final String wireName = r'$RoleSummary';

  @override
  Object serialize(
    Serializers serializers,
    $RoleSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(RoleSummary))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RoleSummaryBuilder result,
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
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $RoleSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $RoleSummaryBuilder();
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
