// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_all_notifications_read200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MarkAllNotificationsRead200Response
    extends MarkAllNotificationsRead200Response {
  @override
  final int updated;

  factory _$MarkAllNotificationsRead200Response(
          [void Function(MarkAllNotificationsRead200ResponseBuilder)?
              updates]) =>
      (MarkAllNotificationsRead200ResponseBuilder()..update(updates))._build();

  _$MarkAllNotificationsRead200Response._({required this.updated}) : super._();
  @override
  MarkAllNotificationsRead200Response rebuild(
          void Function(MarkAllNotificationsRead200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MarkAllNotificationsRead200ResponseBuilder toBuilder() =>
      MarkAllNotificationsRead200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MarkAllNotificationsRead200Response &&
        updated == other.updated;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, updated.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MarkAllNotificationsRead200Response')
          ..add('updated', updated))
        .toString();
  }
}

class MarkAllNotificationsRead200ResponseBuilder
    implements
        Builder<MarkAllNotificationsRead200Response,
            MarkAllNotificationsRead200ResponseBuilder> {
  _$MarkAllNotificationsRead200Response? _$v;

  int? _updated;
  int? get updated => _$this._updated;
  set updated(int? updated) => _$this._updated = updated;

  MarkAllNotificationsRead200ResponseBuilder() {
    MarkAllNotificationsRead200Response._defaults(this);
  }

  MarkAllNotificationsRead200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _updated = $v.updated;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MarkAllNotificationsRead200Response other) {
    _$v = other as _$MarkAllNotificationsRead200Response;
  }

  @override
  void update(
      void Function(MarkAllNotificationsRead200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MarkAllNotificationsRead200Response build() => _build();

  _$MarkAllNotificationsRead200Response _build() {
    final _$result = _$v ??
        _$MarkAllNotificationsRead200Response._(
          updated: BuiltValueNullFieldError.checkNotNull(
              updated, r'MarkAllNotificationsRead200Response', 'updated'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
