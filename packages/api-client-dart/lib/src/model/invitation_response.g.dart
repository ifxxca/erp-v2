// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InvitationResponse extends InvitationResponse {
  @override
  final String id;
  @override
  final String userId;
  @override
  final JsonObject? status;
  @override
  final DateTime expiresAt;

  factory _$InvitationResponse(
          [void Function(InvitationResponseBuilder)? updates]) =>
      (InvitationResponseBuilder()..update(updates))._build();

  _$InvitationResponse._(
      {required this.id,
      required this.userId,
      this.status,
      required this.expiresAt})
      : super._();
  @override
  InvitationResponse rebuild(
          void Function(InvitationResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvitationResponseBuilder toBuilder() =>
      InvitationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvitationResponse &&
        id == other.id &&
        userId == other.userId &&
        status == other.status &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InvitationResponse')
          ..add('id', id)
          ..add('userId', userId)
          ..add('status', status)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class InvitationResponseBuilder
    implements Builder<InvitationResponse, InvitationResponseBuilder> {
  _$InvitationResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  JsonObject? _status;
  JsonObject? get status => _$this._status;
  set status(JsonObject? status) => _$this._status = status;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  InvitationResponseBuilder() {
    InvitationResponse._defaults(this);
  }

  InvitationResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _status = $v.status;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvitationResponse other) {
    _$v = other as _$InvitationResponse;
  }

  @override
  void update(void Function(InvitationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvitationResponse build() => _build();

  _$InvitationResponse _build() {
    final _$result = _$v ??
        _$InvitationResponse._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'InvitationResponse', 'id'),
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'InvitationResponse', 'userId'),
          status: status,
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'InvitationResponse', 'expiresAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
