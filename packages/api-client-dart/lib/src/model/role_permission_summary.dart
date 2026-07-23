//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_permission_summary.g.dart';

/// RolePermissionSummary
///
/// Properties:
/// * [id]
/// * [code]
/// * [module]
/// * [resource]
/// * [action]
/// * [description]
@BuiltValue(instantiable: false)
abstract class RolePermissionSummary  {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'module')
  String get module;

  @BuiltValueField(wireName: r'resource')
  String get resource;

  @BuiltValueField(wireName: r'action')
  String get action;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueSerializer(custom: true)
  static Serializer<RolePermissionSummary> get serializer => _$RolePermissionSummarySerializer();
}

class _$RolePermissionSummarySerializer implements PrimitiveSerializer<RolePermissionSummary> {
  @override
  final Iterable<Type> types = const [RolePermissionSummary];

  @override
  final String wireName = r'RolePermissionSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RolePermissionSummary object, {
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
    yield r'module';
    yield serializers.serialize(
      object.module,
      specifiedType: const FullType(String),
    );
    yield r'resource';
    yield serializers.serialize(
      object.resource,
      specifiedType: const FullType(String),
    );
    yield r'action';
    yield serializers.serialize(
      object.action,
      specifiedType: const FullType(String),
    );
    yield r'description';
    yield object.description == null ? null : serializers.serialize(
      object.description,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RolePermissionSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  @override
  RolePermissionSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($RolePermissionSummary)) as $RolePermissionSummary;
  }
}

/// a concrete implementation of [RolePermissionSummary], since [RolePermissionSummary] is not instantiable
@BuiltValue(instantiable: true)
abstract class $RolePermissionSummary implements RolePermissionSummary, Built<$RolePermissionSummary, $RolePermissionSummaryBuilder> {
  $RolePermissionSummary._();

  factory $RolePermissionSummary([void Function($RolePermissionSummaryBuilder)? updates]) = _$$RolePermissionSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($RolePermissionSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$RolePermissionSummary> get serializer => _$$RolePermissionSummarySerializer();
}

class _$$RolePermissionSummarySerializer implements PrimitiveSerializer<$RolePermissionSummary> {
  @override
  final Iterable<Type> types = const [$RolePermissionSummary, _$$RolePermissionSummary];

  @override
  final String wireName = r'$RolePermissionSummary';

  @override
  Object serialize(
    Serializers serializers,
    $RolePermissionSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(RolePermissionSummary))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RolePermissionSummaryBuilder result,
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
        case r'module':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.module = valueDes;
          break;
        case r'resource':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.resource = valueDes;
          break;
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.action = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $RolePermissionSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $RolePermissionSummaryBuilder();
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
