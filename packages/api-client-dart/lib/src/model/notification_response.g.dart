// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationResponse extends NotificationResponse {
  @override
  final PlatformNotification data;

  factory _$NotificationResponse(
          [void Function(NotificationResponseBuilder)? updates]) =>
      (NotificationResponseBuilder()..update(updates))._build();

  _$NotificationResponse._({required this.data}) : super._();
  @override
  NotificationResponse rebuild(
          void Function(NotificationResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationResponseBuilder toBuilder() =>
      NotificationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationResponse && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationResponse')
          ..add('data', data))
        .toString();
  }
}

class NotificationResponseBuilder
    implements Builder<NotificationResponse, NotificationResponseBuilder> {
  _$NotificationResponse? _$v;

  PlatformNotificationBuilder? _data;
  PlatformNotificationBuilder get data =>
      _$this._data ??= PlatformNotificationBuilder();
  set data(PlatformNotificationBuilder? data) => _$this._data = data;

  NotificationResponseBuilder() {
    NotificationResponse._defaults(this);
  }

  NotificationResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationResponse other) {
    _$v = other as _$NotificationResponse;
  }

  @override
  void update(void Function(NotificationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationResponse build() => _build();

  _$NotificationResponse _build() {
    _$NotificationResponse _$result;
    try {
      _$result = _$v ??
          _$NotificationResponse._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'NotificationResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
