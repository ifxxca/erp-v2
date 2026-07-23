//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rajawali_api_client/src/model/date.dart';
import 'package:rajawali_api_client/src/model/location_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'location_membership.g.dart';

/// LocationMembership
///
/// Properties:
/// * [id]
/// * [location]
/// * [validFrom]
/// * [validUntil]
@BuiltValue()
abstract class LocationMembership implements Built<LocationMembership, LocationMembershipBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'location')
  LocationSummary get location;

  @BuiltValueField(wireName: r'valid_from')
  Date get validFrom;

  @BuiltValueField(wireName: r'valid_until')
  Date? get validUntil;

  LocationMembership._();

  factory LocationMembership([void updates(LocationMembershipBuilder b)]) = _$LocationMembership;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LocationMembershipBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LocationMembership> get serializer => _$LocationMembershipSerializer();
}

class _$LocationMembershipSerializer implements PrimitiveSerializer<LocationMembership> {
  @override
  final Iterable<Type> types = const [LocationMembership, _$LocationMembership];

  @override
  final String wireName = r'LocationMembership';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LocationMembership object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'location';
    yield serializers.serialize(
      object.location,
      specifiedType: const FullType(LocationSummary),
    );
    yield r'valid_from';
    yield serializers.serialize(
      object.validFrom,
      specifiedType: const FullType(Date),
    );
    yield r'valid_until';
    yield object.validUntil == null ? null : serializers.serialize(
      object.validUntil,
      specifiedType: const FullType.nullable(Date),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LocationMembership object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LocationMembershipBuilder result,
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
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LocationSummary),
          ) as LocationSummary;
          result.location.replace(valueDes);
          break;
        case r'valid_from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.validFrom = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.validUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LocationMembership deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LocationMembershipBuilder();
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
