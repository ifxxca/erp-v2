//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mfa_status.g.dart';

/// MfaStatus
///
/// Properties:
/// * [required_]
/// * [enabled]
/// * [status]
/// * [confirmedAt]
/// * [unusedRecoveryCodes]
/// * [currentTokenVerifiedAt]
@BuiltValue()
abstract class MfaStatus implements Built<MfaStatus, MfaStatusBuilder> {
  @BuiltValueField(wireName: r'required')
  bool get required_;

  @BuiltValueField(wireName: r'enabled')
  bool get enabled;

  @BuiltValueField(wireName: r'status')
  MfaStatusStatusEnum get status;
  // enum statusEnum {  not_configured,  pending,  active,  disabled,  };

  @BuiltValueField(wireName: r'confirmed_at')
  DateTime? get confirmedAt;

  @BuiltValueField(wireName: r'unused_recovery_codes')
  int get unusedRecoveryCodes;

  @BuiltValueField(wireName: r'current_token_verified_at')
  DateTime? get currentTokenVerifiedAt;

  MfaStatus._();

  factory MfaStatus([void updates(MfaStatusBuilder b)]) = _$MfaStatus;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MfaStatusBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MfaStatus> get serializer => _$MfaStatusSerializer();
}

class _$MfaStatusSerializer implements PrimitiveSerializer<MfaStatus> {
  @override
  final Iterable<Type> types = const [MfaStatus, _$MfaStatus];

  @override
  final String wireName = r'MfaStatus';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MfaStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'required';
    yield serializers.serialize(
      object.required_,
      specifiedType: const FullType(bool),
    );
    yield r'enabled';
    yield serializers.serialize(
      object.enabled,
      specifiedType: const FullType(bool),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(MfaStatusStatusEnum),
    );
    yield r'confirmed_at';
    yield object.confirmedAt == null ? null : serializers.serialize(
      object.confirmedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'unused_recovery_codes';
    yield serializers.serialize(
      object.unusedRecoveryCodes,
      specifiedType: const FullType(int),
    );
    yield r'current_token_verified_at';
    yield object.currentTokenVerifiedAt == null ? null : serializers.serialize(
      object.currentTokenVerifiedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MfaStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MfaStatusBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.required_ = valueDes;
          break;
        case r'enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enabled = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MfaStatusStatusEnum),
          ) as MfaStatusStatusEnum;
          result.status = valueDes;
          break;
        case r'confirmed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.confirmedAt = valueDes;
          break;
        case r'unused_recovery_codes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unusedRecoveryCodes = valueDes;
          break;
        case r'current_token_verified_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.currentTokenVerifiedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MfaStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MfaStatusBuilder();
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

class MfaStatusStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'not_configured')
  static const MfaStatusStatusEnum notConfigured = _$mfaStatusStatusEnum_notConfigured;
  @BuiltValueEnumConst(wireName: r'pending')
  static const MfaStatusStatusEnum pending = _$mfaStatusStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'active')
  static const MfaStatusStatusEnum active = _$mfaStatusStatusEnum_active;
  @BuiltValueEnumConst(wireName: r'disabled')
  static const MfaStatusStatusEnum disabled = _$mfaStatusStatusEnum_disabled;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MfaStatusStatusEnum unknownDefaultOpenApi = _$mfaStatusStatusEnum_unknownDefaultOpenApi;

  static Serializer<MfaStatusStatusEnum> get serializer => _$mfaStatusStatusEnumSerializer;

  const MfaStatusStatusEnum._(String name): super(name);

  static BuiltSet<MfaStatusStatusEnum> get values => _$mfaStatusStatusEnumValues;
  static MfaStatusStatusEnum valueOf(String name) => _$mfaStatusStatusEnumValueOf(name);
}
