//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/identity_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'identity_summary.g.dart';

/// IdentitySummary
///
/// Properties:
/// * [id]
/// * [name]
/// * [email]
/// * [status]
@BuiltValue(instantiable: false)
abstract class IdentitySummary  {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'status')
  IdentityStatus get status;
  // enum statusEnum {  invited,  active,  suspended,  disabled,  };

  @BuiltValueSerializer(custom: true)
  static Serializer<IdentitySummary> get serializer => _$IdentitySummarySerializer();
}

class _$IdentitySummarySerializer implements PrimitiveSerializer<IdentitySummary> {
  @override
  final Iterable<Type> types = const [IdentitySummary];

  @override
  final String wireName = r'IdentitySummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IdentitySummary object, {
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
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(IdentityStatus),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    IdentitySummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  IdentitySummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($IdentitySummary)) as $IdentitySummary;
  }
}

/// a concrete implementation of [IdentitySummary], since [IdentitySummary] is not instantiable
@BuiltValue(instantiable: true)
abstract class $IdentitySummary implements IdentitySummary, Built<$IdentitySummary, $IdentitySummaryBuilder> {
  $IdentitySummary._();

  factory $IdentitySummary([void Function($IdentitySummaryBuilder)? updates]) = _$$IdentitySummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($IdentitySummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$IdentitySummary> get serializer => _$$IdentitySummarySerializer();
}

class _$$IdentitySummarySerializer implements PrimitiveSerializer<$IdentitySummary> {
  @override
  final Iterable<Type> types = const [$IdentitySummary, _$$IdentitySummary];

  @override
  final String wireName = r'$IdentitySummary';

  @override
  Object serialize(
    Serializers serializers,
    $IdentitySummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(IdentitySummary))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IdentitySummaryBuilder result,
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IdentityStatus),
          ) as IdentityStatus;
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
  $IdentitySummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $IdentitySummaryBuilder();
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
