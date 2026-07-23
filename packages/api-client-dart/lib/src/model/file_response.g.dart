// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FileResponse extends FileResponse {
  @override
  final FileAsset data;

  factory _$FileResponse([void Function(FileResponseBuilder)? updates]) =>
      (FileResponseBuilder()..update(updates))._build();

  _$FileResponse._({required this.data}) : super._();
  @override
  FileResponse rebuild(void Function(FileResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FileResponseBuilder toBuilder() => FileResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FileResponse && data == other.data;
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
    return (newBuiltValueToStringHelper(r'FileResponse')..add('data', data))
        .toString();
  }
}

class FileResponseBuilder
    implements Builder<FileResponse, FileResponseBuilder> {
  _$FileResponse? _$v;

  FileAssetBuilder? _data;
  FileAssetBuilder get data => _$this._data ??= FileAssetBuilder();
  set data(FileAssetBuilder? data) => _$this._data = data;

  FileResponseBuilder() {
    FileResponse._defaults(this);
  }

  FileResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FileResponse other) {
    _$v = other as _$FileResponse;
  }

  @override
  void update(void Function(FileResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FileResponse build() => _build();

  _$FileResponse _build() {
    _$FileResponse _$result;
    try {
      _$result = _$v ??
          _$FileResponse._(
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FileResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
