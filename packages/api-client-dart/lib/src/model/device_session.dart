//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'device_session.g.dart';

/// DeviceSession
///
/// Properties:
/// * [id]
/// * [deviceName]
/// * [surface]
/// * [createdAt]
/// * [lastUsedAt]
/// * [expiresAt]
/// * [mfaVerifiedAt]
/// * [current]
@BuiltValue()
abstract class DeviceSession implements Built<DeviceSession, DeviceSessionBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'device_name')
  String get deviceName;

  @BuiltValueField(wireName: r'surface')
  DeviceSessionSurfaceEnum get surface;
  // enum surfaceEnum {  erp_web,  ops_web,  mobile,  unknown,  };

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'last_used_at')
  DateTime? get lastUsedAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime? get expiresAt;

  @BuiltValueField(wireName: r'mfa_verified_at')
  DateTime? get mfaVerifiedAt;

  @BuiltValueField(wireName: r'current')
  bool get current;

  DeviceSession._();

  factory DeviceSession([void updates(DeviceSessionBuilder b)]) = _$DeviceSession;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeviceSessionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeviceSession> get serializer => _$DeviceSessionSerializer();
}

class _$DeviceSessionSerializer implements PrimitiveSerializer<DeviceSession> {
  @override
  final Iterable<Type> types = const [DeviceSession, _$DeviceSession];

  @override
  final String wireName = r'DeviceSession';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeviceSession object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'device_name';
    yield serializers.serialize(
      object.deviceName,
      specifiedType: const FullType(String),
    );
    yield r'surface';
    yield serializers.serialize(
      object.surface,
      specifiedType: const FullType(DeviceSessionSurfaceEnum),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'last_used_at';
    yield object.lastUsedAt == null ? null : serializers.serialize(
      object.lastUsedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'expires_at';
    yield object.expiresAt == null ? null : serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'mfa_verified_at';
    yield object.mfaVerifiedAt == null ? null : serializers.serialize(
      object.mfaVerifiedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'current';
    yield serializers.serialize(
      object.current,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeviceSession object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeviceSessionBuilder result,
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
        case r'device_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deviceName = valueDes;
          break;
        case r'surface':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DeviceSessionSurfaceEnum),
          ) as DeviceSessionSurfaceEnum;
          result.surface = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'last_used_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastUsedAt = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expiresAt = valueDes;
          break;
        case r'mfa_verified_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.mfaVerifiedAt = valueDes;
          break;
        case r'current':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.current = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeviceSession deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeviceSessionBuilder();
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

class DeviceSessionSurfaceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'erp_web')
  static const DeviceSessionSurfaceEnum erpWeb = _$deviceSessionSurfaceEnum_erpWeb;
  @BuiltValueEnumConst(wireName: r'ops_web')
  static const DeviceSessionSurfaceEnum opsWeb = _$deviceSessionSurfaceEnum_opsWeb;
  @BuiltValueEnumConst(wireName: r'mobile')
  static const DeviceSessionSurfaceEnum mobile = _$deviceSessionSurfaceEnum_mobile;
  @BuiltValueEnumConst(wireName: r'unknown')
  static const DeviceSessionSurfaceEnum unknown = _$deviceSessionSurfaceEnum_unknown;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DeviceSessionSurfaceEnum unknownDefaultOpenApi = _$deviceSessionSurfaceEnum_unknownDefaultOpenApi;

  static Serializer<DeviceSessionSurfaceEnum> get serializer => _$deviceSessionSurfaceEnumSerializer;

  const DeviceSessionSurfaceEnum._(String name): super(name);

  static BuiltSet<DeviceSessionSurfaceEnum> get values => _$deviceSessionSurfaceEnumValues;
  static DeviceSessionSurfaceEnum valueOf(String name) => _$deviceSessionSurfaceEnumValueOf(name);
}
