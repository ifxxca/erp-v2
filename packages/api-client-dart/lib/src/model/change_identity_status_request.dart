//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'change_identity_status_request.g.dart';

/// ChangeIdentityStatusRequest
///
/// Properties:
/// * [status]
/// * [reason]
@BuiltValue()
abstract class ChangeIdentityStatusRequest implements Built<ChangeIdentityStatusRequest, ChangeIdentityStatusRequestBuilder> {
  @BuiltValueField(wireName: r'status')
  ChangeIdentityStatusRequestStatusEnum get status;
  // enum statusEnum {  active,  suspended,  disabled,  };

  @BuiltValueField(wireName: r'reason')
  String get reason;

  ChangeIdentityStatusRequest._();

  factory ChangeIdentityStatusRequest([void updates(ChangeIdentityStatusRequestBuilder b)]) = _$ChangeIdentityStatusRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChangeIdentityStatusRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChangeIdentityStatusRequest> get serializer => _$ChangeIdentityStatusRequestSerializer();
}

class _$ChangeIdentityStatusRequestSerializer implements PrimitiveSerializer<ChangeIdentityStatusRequest> {
  @override
  final Iterable<Type> types = const [ChangeIdentityStatusRequest, _$ChangeIdentityStatusRequest];

  @override
  final String wireName = r'ChangeIdentityStatusRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChangeIdentityStatusRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(ChangeIdentityStatusRequestStatusEnum),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChangeIdentityStatusRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChangeIdentityStatusRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChangeIdentityStatusRequestStatusEnum),
          ) as ChangeIdentityStatusRequestStatusEnum;
          result.status = valueDes;
          break;
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
  ChangeIdentityStatusRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChangeIdentityStatusRequestBuilder();
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

class ChangeIdentityStatusRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'active')
  static const ChangeIdentityStatusRequestStatusEnum active = _$changeIdentityStatusRequestStatusEnum_active;
  @BuiltValueEnumConst(wireName: r'suspended')
  static const ChangeIdentityStatusRequestStatusEnum suspended = _$changeIdentityStatusRequestStatusEnum_suspended;
  @BuiltValueEnumConst(wireName: r'disabled')
  static const ChangeIdentityStatusRequestStatusEnum disabled = _$changeIdentityStatusRequestStatusEnum_disabled;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ChangeIdentityStatusRequestStatusEnum unknownDefaultOpenApi = _$changeIdentityStatusRequestStatusEnum_unknownDefaultOpenApi;

  static Serializer<ChangeIdentityStatusRequestStatusEnum> get serializer => _$changeIdentityStatusRequestStatusEnumSerializer;

  const ChangeIdentityStatusRequestStatusEnum._(String name): super(name);

  static BuiltSet<ChangeIdentityStatusRequestStatusEnum> get values => _$changeIdentityStatusRequestStatusEnumValues;
  static ChangeIdentityStatusRequestStatusEnum valueOf(String name) => _$changeIdentityStatusRequestStatusEnumValueOf(name);
}
