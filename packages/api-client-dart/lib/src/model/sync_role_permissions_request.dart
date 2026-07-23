//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/role_change_reason.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'sync_role_permissions_request.g.dart';

/// SyncRolePermissionsRequest
///
/// Properties:
/// * [reason]
/// * [permissionIds]
@BuiltValue()
abstract class SyncRolePermissionsRequest implements RoleChangeReason, Built<SyncRolePermissionsRequest, SyncRolePermissionsRequestBuilder> {
  @BuiltValueField(wireName: r'permission_ids')
  BuiltSet<String> get permissionIds;

  SyncRolePermissionsRequest._();

  factory SyncRolePermissionsRequest([void updates(SyncRolePermissionsRequestBuilder b)]) = _$SyncRolePermissionsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SyncRolePermissionsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SyncRolePermissionsRequest> get serializer => _$SyncRolePermissionsRequestSerializer();
}

class _$SyncRolePermissionsRequestSerializer implements PrimitiveSerializer<SyncRolePermissionsRequest> {
  @override
  final Iterable<Type> types = const [SyncRolePermissionsRequest, _$SyncRolePermissionsRequest];

  @override
  final String wireName = r'SyncRolePermissionsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SyncRolePermissionsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    yield r'permission_ids';
    yield serializers.serialize(
      object.permissionIds,
      specifiedType: const FullType(BuiltSet, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SyncRolePermissionsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SyncRolePermissionsRequestBuilder result,
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
        case r'permission_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>;
          result.permissionIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SyncRolePermissionsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SyncRolePermissionsRequestBuilder();
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
