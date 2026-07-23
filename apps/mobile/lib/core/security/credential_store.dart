import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rajawali_mobile/core/security/mobile_credentials.dart';

abstract interface class CredentialStore {
  Future<MobileCredentials?> read();

  Future<void> write(MobileCredentials credentials);

  Future<void> clear();
}

abstract interface class SecureValueStore {
  Future<String?> read(String key);

  Future<void> write(String key, String value);

  Future<void> delete(String key);
}

final class FlutterSecureValueStore implements SecureValueStore {
  FlutterSecureValueStore([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}

final class SecureCredentialStore implements CredentialStore {
  SecureCredentialStore(this._store);

  static const _credentialKey = 'rajawali.mobile.credentials.v1';

  final SecureValueStore _store;

  @override
  Future<MobileCredentials?> read() async {
    final encoded = await _store.read(_credentialKey);
    if (encoded == null) return null;

    try {
      final decoded = jsonDecode(encoded);
      if (decoded is! Map<String, Object?>) {
        throw const FormatException('Credential payload is not an object.');
      }
      return MobileCredentials.fromJson(decoded);
    } on FormatException {
      await clear();
      return null;
    }
  }

  @override
  Future<void> write(MobileCredentials credentials) {
    return _store.write(_credentialKey, jsonEncode(credentials.toJson()));
  }

  @override
  Future<void> clear() => _store.delete(_credentialKey);
}
