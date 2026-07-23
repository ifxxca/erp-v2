//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'company_summary.g.dart';

/// CompanySummary
///
/// Properties:
/// * [id]
/// * [code]
/// * [legalName]
@BuiltValue(instantiable: false)
abstract class CompanySummary  {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'legal_name')
  String get legalName;

  @BuiltValueSerializer(custom: true)
  static Serializer<CompanySummary> get serializer => _$CompanySummarySerializer();
}

class _$CompanySummarySerializer implements PrimitiveSerializer<CompanySummary> {
  @override
  final Iterable<Type> types = const [CompanySummary];

  @override
  final String wireName = r'CompanySummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CompanySummary object, {
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
    yield r'legal_name';
    yield serializers.serialize(
      object.legalName,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CompanySummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  CompanySummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($CompanySummary)) as $CompanySummary;
  }
}

/// a concrete implementation of [CompanySummary], since [CompanySummary] is not instantiable
@BuiltValue(instantiable: true)
abstract class $CompanySummary implements CompanySummary, Built<$CompanySummary, $CompanySummaryBuilder> {
  $CompanySummary._();

  factory $CompanySummary([void Function($CompanySummaryBuilder)? updates]) = _$$CompanySummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($CompanySummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$CompanySummary> get serializer => _$$CompanySummarySerializer();
}

class _$$CompanySummarySerializer implements PrimitiveSerializer<$CompanySummary> {
  @override
  final Iterable<Type> types = const [$CompanySummary, _$$CompanySummary];

  @override
  final String wireName = r'$CompanySummary';

  @override
  Object serialize(
    Serializers serializers,
    $CompanySummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(CompanySummary))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CompanySummaryBuilder result,
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
        case r'legal_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.legalName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $CompanySummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $CompanySummaryBuilder();
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
