//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/user_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'access_catalog_user.g.dart';

/// AccessCatalogUser
///
/// Properties:
/// * [id]
/// * [name]
/// * [email]
/// * [mfaEnabled]
/// * [departmentIds]
/// * [locationIds]
@BuiltValue()
abstract class AccessCatalogUser implements UserSummary, Built<AccessCatalogUser, AccessCatalogUserBuilder> {
  @BuiltValueField(wireName: r'location_ids')
  BuiltSet<String> get locationIds;

  @BuiltValueField(wireName: r'mfa_enabled')
  bool get mfaEnabled;

  @BuiltValueField(wireName: r'department_ids')
  BuiltSet<String> get departmentIds;

  AccessCatalogUser._();

  factory AccessCatalogUser([void updates(AccessCatalogUserBuilder b)]) = _$AccessCatalogUser;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccessCatalogUserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccessCatalogUser> get serializer => _$AccessCatalogUserSerializer();
}

class _$AccessCatalogUserSerializer implements PrimitiveSerializer<AccessCatalogUser> {
  @override
  final Iterable<Type> types = const [AccessCatalogUser, _$AccessCatalogUser];

  @override
  final String wireName = r'AccessCatalogUser';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccessCatalogUser object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'location_ids';
    yield serializers.serialize(
      object.locationIds,
      specifiedType: const FullType(BuiltSet, [FullType(String)]),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'mfa_enabled';
    yield serializers.serialize(
      object.mfaEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'department_ids';
    yield serializers.serialize(
      object.departmentIds,
      specifiedType: const FullType(BuiltSet, [FullType(String)]),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccessCatalogUser object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccessCatalogUserBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'location_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>;
          result.locationIds.replace(valueDes);
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'mfa_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mfaEnabled = valueDes;
          break;
        case r'department_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>;
          result.departmentIds.replace(valueDes);
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccessCatalogUser deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccessCatalogUserBuilder();
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
