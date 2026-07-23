// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_initiated_response_upload.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FileInitiatedResponseUpload extends FileInitiatedResponseUpload {
  @override
  final JsonObject? method;
  @override
  final String url;
  @override
  final JsonObject? contentType;
  @override
  final JsonObject? field;
  @override
  final DateTime expiresAt;

  factory _$FileInitiatedResponseUpload(
          [void Function(FileInitiatedResponseUploadBuilder)? updates]) =>
      (FileInitiatedResponseUploadBuilder()..update(updates))._build();

  _$FileInitiatedResponseUpload._(
      {this.method,
      required this.url,
      this.contentType,
      this.field,
      required this.expiresAt})
      : super._();
  @override
  FileInitiatedResponseUpload rebuild(
          void Function(FileInitiatedResponseUploadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FileInitiatedResponseUploadBuilder toBuilder() =>
      FileInitiatedResponseUploadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FileInitiatedResponseUpload &&
        method == other.method &&
        url == other.url &&
        contentType == other.contentType &&
        field == other.field &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, contentType.hashCode);
    _$hash = $jc(_$hash, field.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FileInitiatedResponseUpload')
          ..add('method', method)
          ..add('url', url)
          ..add('contentType', contentType)
          ..add('field', field)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class FileInitiatedResponseUploadBuilder
    implements
        Builder<FileInitiatedResponseUpload,
            FileInitiatedResponseUploadBuilder> {
  _$FileInitiatedResponseUpload? _$v;

  JsonObject? _method;
  JsonObject? get method => _$this._method;
  set method(JsonObject? method) => _$this._method = method;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  JsonObject? _contentType;
  JsonObject? get contentType => _$this._contentType;
  set contentType(JsonObject? contentType) => _$this._contentType = contentType;

  JsonObject? _field;
  JsonObject? get field => _$this._field;
  set field(JsonObject? field) => _$this._field = field;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  FileInitiatedResponseUploadBuilder() {
    FileInitiatedResponseUpload._defaults(this);
  }

  FileInitiatedResponseUploadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _method = $v.method;
      _url = $v.url;
      _contentType = $v.contentType;
      _field = $v.field;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FileInitiatedResponseUpload other) {
    _$v = other as _$FileInitiatedResponseUpload;
  }

  @override
  void update(void Function(FileInitiatedResponseUploadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FileInitiatedResponseUpload build() => _build();

  _$FileInitiatedResponseUpload _build() {
    final _$result = _$v ??
        _$FileInitiatedResponseUpload._(
          method: method,
          url: BuiltValueNullFieldError.checkNotNull(
              url, r'FileInitiatedResponseUpload', 'url'),
          contentType: contentType,
          field: field,
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'FileInitiatedResponseUpload', 'expiresAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
