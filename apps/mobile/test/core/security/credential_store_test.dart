import 'package:flutter_test/flutter_test.dart';
import 'package:rajawali_mobile/core/security/credential_store.dart';
import 'package:rajawali_mobile/core/security/mobile_credentials.dart';

void main() {
  test('credentials are persisted as one secure value', () async {
    final values = MemorySecureValueStore();
    final store = SecureCredentialStore(values);
    final credentials = sampleCredentials();

    await store.write(credentials);
    final restored = await store.read();

    expect(values.values, hasLength(1));
    expect(restored?.accessToken, credentials.accessToken);
    expect(restored?.refreshToken, credentials.refreshToken);
    expect(restored?.refreshExpiresAt, credentials.refreshExpiresAt);
  });

  test('corrupt credential payload is deleted', () async {
    final values = MemorySecureValueStore()..values['bad'] = 'unused';
    final store = SecureCredentialStore(values);
    await store.write(sampleCredentials());
    values.values[values.values.keys.last] = '{invalid';

    expect(await store.read(), isNull);
    expect(values.values, isNot(containsValue('{invalid')));
    expect(values.deleteCount, 1);
  });
}

final class MemorySecureValueStore implements SecureValueStore {
  final values = <String, String>{};
  var deleteCount = 0;

  @override
  Future<void> delete(String key) async {
    deleteCount += 1;
    values.remove(key);
  }

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async {
    values[key] = value;
  }
}

MobileCredentials sampleCredentials() => MobileCredentials(
  accessToken: 'access-token',
  refreshToken: 'refresh-token',
  accessExpiresAt: DateTime.utc(2026, 7, 23, 12),
  refreshExpiresAt: DateTime.utc(2026, 8, 22, 12),
  mfaRequired: false,
);
