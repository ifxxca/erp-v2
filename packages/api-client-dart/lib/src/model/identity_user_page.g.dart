// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_user_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IdentityUserPage extends IdentityUserPage {
  @override
  final BuiltList<IdentityUser> data;
  @override
  final int currentPage;
  @override
  final int perPage;
  @override
  final int total;
  @override
  final int? lastPage;
  @override
  final int? from;
  @override
  final int? to;

  factory _$IdentityUserPage(
          [void Function(IdentityUserPageBuilder)? updates]) =>
      (IdentityUserPageBuilder()..update(updates))._build();

  _$IdentityUserPage._(
      {required this.data,
      required this.currentPage,
      required this.perPage,
      required this.total,
      this.lastPage,
      this.from,
      this.to})
      : super._();
  @override
  IdentityUserPage rebuild(void Function(IdentityUserPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IdentityUserPageBuilder toBuilder() =>
      IdentityUserPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IdentityUserPage &&
        data == other.data &&
        currentPage == other.currentPage &&
        perPage == other.perPage &&
        total == other.total &&
        lastPage == other.lastPage &&
        from == other.from &&
        to == other.to;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, currentPage.hashCode);
    _$hash = $jc(_$hash, perPage.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, lastPage.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IdentityUserPage')
          ..add('data', data)
          ..add('currentPage', currentPage)
          ..add('perPage', perPage)
          ..add('total', total)
          ..add('lastPage', lastPage)
          ..add('from', from)
          ..add('to', to))
        .toString();
  }
}

class IdentityUserPageBuilder
    implements Builder<IdentityUserPage, IdentityUserPageBuilder> {
  _$IdentityUserPage? _$v;

  ListBuilder<IdentityUser>? _data;
  ListBuilder<IdentityUser> get data =>
      _$this._data ??= ListBuilder<IdentityUser>();
  set data(ListBuilder<IdentityUser>? data) => _$this._data = data;

  int? _currentPage;
  int? get currentPage => _$this._currentPage;
  set currentPage(int? currentPage) => _$this._currentPage = currentPage;

  int? _perPage;
  int? get perPage => _$this._perPage;
  set perPage(int? perPage) => _$this._perPage = perPage;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _lastPage;
  int? get lastPage => _$this._lastPage;
  set lastPage(int? lastPage) => _$this._lastPage = lastPage;

  int? _from;
  int? get from => _$this._from;
  set from(int? from) => _$this._from = from;

  int? _to;
  int? get to => _$this._to;
  set to(int? to) => _$this._to = to;

  IdentityUserPageBuilder() {
    IdentityUserPage._defaults(this);
  }

  IdentityUserPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _currentPage = $v.currentPage;
      _perPage = $v.perPage;
      _total = $v.total;
      _lastPage = $v.lastPage;
      _from = $v.from;
      _to = $v.to;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IdentityUserPage other) {
    _$v = other as _$IdentityUserPage;
  }

  @override
  void update(void Function(IdentityUserPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IdentityUserPage build() => _build();

  _$IdentityUserPage _build() {
    _$IdentityUserPage _$result;
    try {
      _$result = _$v ??
          _$IdentityUserPage._(
            data: data.build(),
            currentPage: BuiltValueNullFieldError.checkNotNull(
                currentPage, r'IdentityUserPage', 'currentPage'),
            perPage: BuiltValueNullFieldError.checkNotNull(
                perPage, r'IdentityUserPage', 'perPage'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'IdentityUserPage', 'total'),
            lastPage: lastPage,
            from: from,
            to: to,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'IdentityUserPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
