// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_role_profile.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CustomRoleProfileAssignmentScopeEnum
    _$customRoleProfileAssignmentScopeEnum_company =
    const CustomRoleProfileAssignmentScopeEnum._('company');
const CustomRoleProfileAssignmentScopeEnum
    _$customRoleProfileAssignmentScopeEnum_department =
    const CustomRoleProfileAssignmentScopeEnum._('department');
const CustomRoleProfileAssignmentScopeEnum
    _$customRoleProfileAssignmentScopeEnum_location =
    const CustomRoleProfileAssignmentScopeEnum._('location');
const CustomRoleProfileAssignmentScopeEnum
    _$customRoleProfileAssignmentScopeEnum_unknownDefaultOpenApi =
    const CustomRoleProfileAssignmentScopeEnum._('unknownDefaultOpenApi');

CustomRoleProfileAssignmentScopeEnum
    _$customRoleProfileAssignmentScopeEnumValueOf(String name) {
  switch (name) {
    case 'company':
      return _$customRoleProfileAssignmentScopeEnum_company;
    case 'department':
      return _$customRoleProfileAssignmentScopeEnum_department;
    case 'location':
      return _$customRoleProfileAssignmentScopeEnum_location;
    case 'unknownDefaultOpenApi':
      return _$customRoleProfileAssignmentScopeEnum_unknownDefaultOpenApi;
    default:
      return _$customRoleProfileAssignmentScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CustomRoleProfileAssignmentScopeEnum>
    _$customRoleProfileAssignmentScopeEnumValues = BuiltSet<
        CustomRoleProfileAssignmentScopeEnum>(const <CustomRoleProfileAssignmentScopeEnum>[
  _$customRoleProfileAssignmentScopeEnum_company,
  _$customRoleProfileAssignmentScopeEnum_department,
  _$customRoleProfileAssignmentScopeEnum_location,
  _$customRoleProfileAssignmentScopeEnum_unknownDefaultOpenApi,
]);

Serializer<CustomRoleProfileAssignmentScopeEnum>
    _$customRoleProfileAssignmentScopeEnumSerializer =
    _$CustomRoleProfileAssignmentScopeEnumSerializer();

class _$CustomRoleProfileAssignmentScopeEnumSerializer
    implements PrimitiveSerializer<CustomRoleProfileAssignmentScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'company': 'company',
    'department': 'department',
    'location': 'location',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'company': 'company',
    'department': 'department',
    'location': 'location',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CustomRoleProfileAssignmentScopeEnum
  ];
  @override
  final String wireName = 'CustomRoleProfileAssignmentScopeEnum';

  @override
  Object serialize(
          Serializers serializers, CustomRoleProfileAssignmentScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CustomRoleProfileAssignmentScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CustomRoleProfileAssignmentScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

abstract class CustomRoleProfileBuilder {
  void replace(CustomRoleProfile other);
  void update(void Function(CustomRoleProfileBuilder) updates);
  String? get name;
  set name(String? name);

  String? get description;
  set description(String? description);

  bool? get isPrivileged;
  set isPrivileged(bool? isPrivileged);

  CustomRoleProfileAssignmentScopeEnum? get assignmentScope;
  set assignmentScope(CustomRoleProfileAssignmentScopeEnum? assignmentScope);

  String? get reason;
  set reason(String? reason);
}

class _$$CustomRoleProfile extends $CustomRoleProfile {
  @override
  final String name;
  @override
  final String? description;
  @override
  final bool isPrivileged;
  @override
  final CustomRoleProfileAssignmentScopeEnum assignmentScope;
  @override
  final String reason;

  factory _$$CustomRoleProfile(
          [void Function($CustomRoleProfileBuilder)? updates]) =>
      ($CustomRoleProfileBuilder()..update(updates))._build();

  _$$CustomRoleProfile._(
      {required this.name,
      this.description,
      required this.isPrivileged,
      required this.assignmentScope,
      required this.reason})
      : super._();
  @override
  $CustomRoleProfile rebuild(
          void Function($CustomRoleProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $CustomRoleProfileBuilder toBuilder() =>
      $CustomRoleProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $CustomRoleProfile &&
        name == other.name &&
        description == other.description &&
        isPrivileged == other.isPrivileged &&
        assignmentScope == other.assignmentScope &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isPrivileged.hashCode);
    _$hash = $jc(_$hash, assignmentScope.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$CustomRoleProfile')
          ..add('name', name)
          ..add('description', description)
          ..add('isPrivileged', isPrivileged)
          ..add('assignmentScope', assignmentScope)
          ..add('reason', reason))
        .toString();
  }
}

class $CustomRoleProfileBuilder
    implements
        Builder<$CustomRoleProfile, $CustomRoleProfileBuilder>,
        CustomRoleProfileBuilder {
  _$$CustomRoleProfile? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(covariant String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(covariant String? description) =>
      _$this._description = description;

  bool? _isPrivileged;
  bool? get isPrivileged => _$this._isPrivileged;
  set isPrivileged(covariant bool? isPrivileged) =>
      _$this._isPrivileged = isPrivileged;

  CustomRoleProfileAssignmentScopeEnum? _assignmentScope;
  CustomRoleProfileAssignmentScopeEnum? get assignmentScope =>
      _$this._assignmentScope;
  set assignmentScope(
          covariant CustomRoleProfileAssignmentScopeEnum? assignmentScope) =>
      _$this._assignmentScope = assignmentScope;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(covariant String? reason) => _$this._reason = reason;

  $CustomRoleProfileBuilder() {
    $CustomRoleProfile._defaults(this);
  }

  $CustomRoleProfileBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _isPrivileged = $v.isPrivileged;
      _assignmentScope = $v.assignmentScope;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $CustomRoleProfile other) {
    _$v = other as _$$CustomRoleProfile;
  }

  @override
  void update(void Function($CustomRoleProfileBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $CustomRoleProfile build() => _build();

  _$$CustomRoleProfile _build() {
    final _$result = _$v ??
        _$$CustomRoleProfile._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'$CustomRoleProfile', 'name'),
          description: description,
          isPrivileged: BuiltValueNullFieldError.checkNotNull(
              isPrivileged, r'$CustomRoleProfile', 'isPrivileged'),
          assignmentScope: BuiltValueNullFieldError.checkNotNull(
              assignmentScope, r'$CustomRoleProfile', 'assignmentScope'),
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'$CustomRoleProfile', 'reason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
