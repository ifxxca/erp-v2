// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_initiated_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FileInitiatedResponse extends FileInitiatedResponse {
  @override
  final FileAsset data;
  @override
  final FileInitiatedResponseUpload upload;

  factory _$FileInitiatedResponse(
          [void Function(FileInitiatedResponseBuilder)? updates]) =>
      (FileInitiatedResponseBuilder()..update(updates))._build();

  _$FileInitiatedResponse._({required this.data, required this.upload})
      : super._();
  @override
  FileInitiatedResponse rebuild(
          void Function(FileInitiatedResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FileInitiatedResponseBuilder toBuilder() =>
      FileInitiatedResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FileInitiatedResponse &&
        data == other.data &&
        upload == other.upload;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, upload.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FileInitiatedResponse')
          ..add('data', data)
          ..add('upload', upload))
        .toString();
  }
}

class FileInitiatedResponseBuilder
    implements Builder<FileInitiatedResponse, FileInitiatedResponseBuilder> {
  _$FileInitiatedResponse? _$v;

  FileAssetBuilder? _data;
  FileAssetBuilder get data => _$this._data ??= FileAssetBuilder();
  set data(FileAssetBuilder? data) => _$this._data = data;

  FileInitiatedResponseUploadBuilder? _upload;
  FileInitiatedResponseUploadBuilder get upload =>
      _$this._upload ??= FileInitiatedResponseUploadBuilder();
  set upload(FileInitiatedResponseUploadBuilder? upload) =>
      _$this._upload = upload;

  FileInitiatedResponseBuilder() {
    FileInitiatedResponse._defaults(this);
  }

  FileInitiatedResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _upload = $v.upload.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FileInitiatedResponse other) {
    _$v = other as _$FileInitiatedResponse;
  }

  @override
  void update(void Function(FileInitiatedResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FileInitiatedResponse build() => _build();

  _$FileInitiatedResponse _build() {
    _$FileInitiatedResponse _$result;
    try {
      _$result = _$v ??
          _$FileInitiatedResponse._(
            data: data.build(),
            upload: upload.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
        _$failedField = 'upload';
        upload.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FileInitiatedResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
