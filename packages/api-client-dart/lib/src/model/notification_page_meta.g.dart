// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_page_meta.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationPageMeta extends NotificationPageMeta {
  @override
  final int currentPage;
  @override
  final int lastPage;
  @override
  final int perPage;
  @override
  final int total;
  @override
  final int unreadCount;

  factory _$NotificationPageMeta(
          [void Function(NotificationPageMetaBuilder)? updates]) =>
      (NotificationPageMetaBuilder()..update(updates))._build();

  _$NotificationPageMeta._(
      {required this.currentPage,
      required this.lastPage,
      required this.perPage,
      required this.total,
      required this.unreadCount})
      : super._();
  @override
  NotificationPageMeta rebuild(
          void Function(NotificationPageMetaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationPageMetaBuilder toBuilder() =>
      NotificationPageMetaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationPageMeta &&
        currentPage == other.currentPage &&
        lastPage == other.lastPage &&
        perPage == other.perPage &&
        total == other.total &&
        unreadCount == other.unreadCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, currentPage.hashCode);
    _$hash = $jc(_$hash, lastPage.hashCode);
    _$hash = $jc(_$hash, perPage.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationPageMeta')
          ..add('currentPage', currentPage)
          ..add('lastPage', lastPage)
          ..add('perPage', perPage)
          ..add('total', total)
          ..add('unreadCount', unreadCount))
        .toString();
  }
}

class NotificationPageMetaBuilder
    implements Builder<NotificationPageMeta, NotificationPageMetaBuilder> {
  _$NotificationPageMeta? _$v;

  int? _currentPage;
  int? get currentPage => _$this._currentPage;
  set currentPage(int? currentPage) => _$this._currentPage = currentPage;

  int? _lastPage;
  int? get lastPage => _$this._lastPage;
  set lastPage(int? lastPage) => _$this._lastPage = lastPage;

  int? _perPage;
  int? get perPage => _$this._perPage;
  set perPage(int? perPage) => _$this._perPage = perPage;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  NotificationPageMetaBuilder() {
    NotificationPageMeta._defaults(this);
  }

  NotificationPageMetaBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentPage = $v.currentPage;
      _lastPage = $v.lastPage;
      _perPage = $v.perPage;
      _total = $v.total;
      _unreadCount = $v.unreadCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationPageMeta other) {
    _$v = other as _$NotificationPageMeta;
  }

  @override
  void update(void Function(NotificationPageMetaBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationPageMeta build() => _build();

  _$NotificationPageMeta _build() {
    final _$result = _$v ??
        _$NotificationPageMeta._(
          currentPage: BuiltValueNullFieldError.checkNotNull(
              currentPage, r'NotificationPageMeta', 'currentPage'),
          lastPage: BuiltValueNullFieldError.checkNotNull(
              lastPage, r'NotificationPageMeta', 'lastPage'),
          perPage: BuiltValueNullFieldError.checkNotNull(
              perPage, r'NotificationPageMeta', 'perPage'),
          total: BuiltValueNullFieldError.checkNotNull(
              total, r'NotificationPageMeta', 'total'),
          unreadCount: BuiltValueNullFieldError.checkNotNull(
              unreadCount, r'NotificationPageMeta', 'unreadCount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
