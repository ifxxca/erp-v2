//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rajawali_api_client/src/model/privileged_role_assignment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'role_assignment_page.g.dart';

/// RoleAssignmentPage
///
/// Properties:
/// * [data]
/// * [currentPage]
/// * [lastPage]
/// * [perPage]
/// * [total]
@BuiltValue()
abstract class RoleAssignmentPage implements Built<RoleAssignmentPage, RoleAssignmentPageBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<PrivilegedRoleAssignment> get data;

  @BuiltValueField(wireName: r'current_page')
  int get currentPage;

  @BuiltValueField(wireName: r'last_page')
  int get lastPage;

  @BuiltValueField(wireName: r'per_page')
  int get perPage;

  @BuiltValueField(wireName: r'total')
  int get total;

  RoleAssignmentPage._();

  factory RoleAssignmentPage([void updates(RoleAssignmentPageBuilder b)]) = _$RoleAssignmentPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RoleAssignmentPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RoleAssignmentPage> get serializer => _$RoleAssignmentPageSerializer();
}

class _$RoleAssignmentPageSerializer implements PrimitiveSerializer<RoleAssignmentPage> {
  @override
  final Iterable<Type> types = const [RoleAssignmentPage, _$RoleAssignmentPage];

  @override
  final String wireName = r'RoleAssignmentPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RoleAssignmentPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(PrivilegedRoleAssignment)]),
    );
    yield r'current_page';
    yield serializers.serialize(
      object.currentPage,
      specifiedType: const FullType(int),
    );
    yield r'last_page';
    yield serializers.serialize(
      object.lastPage,
      specifiedType: const FullType(int),
    );
    yield r'per_page';
    yield serializers.serialize(
      object.perPage,
      specifiedType: const FullType(int),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RoleAssignmentPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RoleAssignmentPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PrivilegedRoleAssignment)]),
          ) as BuiltList<PrivilegedRoleAssignment>;
          result.data.replace(valueDes);
          break;
        case r'current_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.currentPage = valueDes;
          break;
        case r'last_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lastPage = valueDes;
          break;
        case r'per_page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.perPage = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RoleAssignmentPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RoleAssignmentPageBuilder();
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
