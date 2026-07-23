//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'terminate_company_membership_request.g.dart';

/// TerminateCompanyMembershipRequest
///
/// Properties:
/// * [reason]
@BuiltValue()
abstract class TerminateCompanyMembershipRequest implements Built<TerminateCompanyMembershipRequest, TerminateCompanyMembershipRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  String get reason;

  TerminateCompanyMembershipRequest._();

  factory TerminateCompanyMembershipRequest([void updates(TerminateCompanyMembershipRequestBuilder b)]) = _$TerminateCompanyMembershipRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TerminateCompanyMembershipRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TerminateCompanyMembershipRequest> get serializer => _$TerminateCompanyMembershipRequestSerializer();
}

class _$TerminateCompanyMembershipRequestSerializer implements PrimitiveSerializer<TerminateCompanyMembershipRequest> {
  @override
  final Iterable<Type> types = const [TerminateCompanyMembershipRequest, _$TerminateCompanyMembershipRequest];

  @override
  final String wireName = r'TerminateCompanyMembershipRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TerminateCompanyMembershipRequest object, {
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
    TerminateCompanyMembershipRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TerminateCompanyMembershipRequestBuilder result,
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
  TerminateCompanyMembershipRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TerminateCompanyMembershipRequestBuilder();
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
