//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'platform_notification.g.dart';

/// PlatformNotification
///
/// Properties:
/// * [id]
/// * [companyId]
/// * [kind]
/// * [title]
/// * [body]
/// * [data]
/// * [actionUrl] - Relative first-party application path.
/// * [readAt]
/// * [createdAt]
/// * [deliveries]
@BuiltValue()
abstract class PlatformNotification implements Built<PlatformNotification, PlatformNotificationBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'company_id')
  String? get companyId;

  @BuiltValueField(wireName: r'kind')
  String get kind;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'body')
  String get body;

  @BuiltValueField(wireName: r'data')
  BuiltMap<String, JsonObject?> get data;

  /// Relative first-party application path.
  @BuiltValueField(wireName: r'action_url')
  String? get actionUrl;

  @BuiltValueField(wireName: r'read_at')
  DateTime? get readAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'deliveries')
  BuiltMap<String, PlatformNotificationDeliveriesEnum> get deliveries;
  // enum deliveriesEnum {  pending,  processing,  delivered,  dead_letter,  };

  PlatformNotification._();

  factory PlatformNotification([void updates(PlatformNotificationBuilder b)]) = _$PlatformNotification;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PlatformNotificationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PlatformNotification> get serializer => _$PlatformNotificationSerializer();
}

class _$PlatformNotificationSerializer implements PrimitiveSerializer<PlatformNotification> {
  @override
  final Iterable<Type> types = const [PlatformNotification, _$PlatformNotification];

  @override
  final String wireName = r'PlatformNotification';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PlatformNotification object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'company_id';
    yield object.companyId == null ? null : serializers.serialize(
      object.companyId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(String),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
    );
    yield r'action_url';
    yield object.actionUrl == null ? null : serializers.serialize(
      object.actionUrl,
      specifiedType: const FullType.nullable(String),
    );
    yield r'read_at';
    yield object.readAt == null ? null : serializers.serialize(
      object.readAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'deliveries';
    yield serializers.serialize(
      object.deliveries,
      specifiedType: const FullType(BuiltMap, [FullType(String), FullType(PlatformNotificationDeliveriesEnum)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PlatformNotification object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PlatformNotificationBuilder result,
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
        case r'company_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.companyId = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.kind = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.body = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          ) as BuiltMap<String, JsonObject?>;
          result.data.replace(valueDes);
          break;
        case r'action_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.actionUrl = valueDes;
          break;
        case r'read_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.readAt = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'deliveries':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType(PlatformNotificationDeliveriesEnum)]),
          ) as BuiltMap<String, PlatformNotificationDeliveriesEnum>;
          result.deliveries.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PlatformNotification deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PlatformNotificationBuilder();
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

class PlatformNotificationDeliveriesEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const PlatformNotificationDeliveriesEnum pending = _$platformNotificationDeliveriesEnum_pending;
  @BuiltValueEnumConst(wireName: r'processing')
  static const PlatformNotificationDeliveriesEnum processing = _$platformNotificationDeliveriesEnum_processing;
  @BuiltValueEnumConst(wireName: r'delivered')
  static const PlatformNotificationDeliveriesEnum delivered = _$platformNotificationDeliveriesEnum_delivered;
  @BuiltValueEnumConst(wireName: r'dead_letter')
  static const PlatformNotificationDeliveriesEnum deadLetter = _$platformNotificationDeliveriesEnum_deadLetter;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PlatformNotificationDeliveriesEnum unknownDefaultOpenApi = _$platformNotificationDeliveriesEnum_unknownDefaultOpenApi;

  static Serializer<PlatformNotificationDeliveriesEnum> get serializer => _$platformNotificationDeliveriesEnumSerializer;

  const PlatformNotificationDeliveriesEnum._(String name): super(name);

  static BuiltSet<PlatformNotificationDeliveriesEnum> get values => _$platformNotificationDeliveriesEnumValues;
  static PlatformNotificationDeliveriesEnum valueOf(String name) => _$platformNotificationDeliveriesEnumValueOf(name);
}
