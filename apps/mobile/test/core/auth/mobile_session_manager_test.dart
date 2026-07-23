import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:rajawali_mobile/core/auth/mobile_auth_gateway.dart';
import 'package:rajawali_mobile/core/auth/mobile_session_manager.dart';
import 'package:rajawali_mobile/core/security/credential_store.dart';
import 'package:rajawali_mobile/core/security/mobile_credentials.dart';

void main() {
  final now = DateTime.utc(2026, 7, 23, 9);

  test('returns a valid access token without refresh', () async {
    final store = MemoryCredentialStore(
      credentials(accessExpiresAt: now.add(const Duration(minutes: 5))),
    );
    final gateway = FakeAuthGateway();
    final manager = MobileSessionManager(store, gateway, clock: () => now);
    await manager.restore();

    expect(await manager.accessToken(), 'access-old');
    expect(gateway.refreshCalls, 0);
  });

  test('concurrent refresh requests share one rotation', () async {
    final store = MemoryCredentialStore(
      credentials(accessExpiresAt: now.subtract(const Duration(seconds: 1))),
    );
    final gateway = FakeAuthGateway();
    final refresh = Completer<MobileCredentials>();
    gateway.refreshResult = refresh.future;
    final manager = MobileSessionManager(store, gateway, clock: () => now);
    await manager.restore();

    final first = manager.accessToken();
    final second = manager.accessToken();
    final third = manager.accessToken(forceRefresh: true);
    expect(gateway.refreshCalls, 1);

    refresh.complete(
      credentials(
        accessToken: 'access-rotated',
        refreshToken: 'refresh-rotated',
        accessExpiresAt: now.add(const Duration(minutes: 10)),
      ),
    );

    expect(await Future.wait([first, second, third]), [
      'access-rotated',
      'access-rotated',
      'access-rotated',
    ]);
    expect(gateway.refreshCalls, 1);
    expect(store.value?.refreshToken, 'refresh-rotated');
    expect(store.writeCount, 1);
  });

  test('refresh replay rejection clears the whole local session', () async {
    final store = MemoryCredentialStore(
      credentials(accessExpiresAt: now.subtract(const Duration(seconds: 1))),
    );
    final gateway = FakeAuthGateway()..rejectRefresh = true;
    final manager = MobileSessionManager(store, gateway, clock: () => now);
    await manager.restore();

    expect(await manager.accessToken(), isNull);
    expect(manager.hasSession, isFalse);
    expect(store.value, isNull);
  });

  test('logout clears credentials even if remote revocation fails', () async {
    final store = MemoryCredentialStore(credentials());
    final gateway = FakeAuthGateway()..logoutError = StateError('offline');
    final manager = MobileSessionManager(store, gateway, clock: () => now);
    await manager.restore();

    await expectLater(manager.signOut(), throwsStateError);
    expect(store.value, isNull);
    expect(manager.hasSession, isFalse);
  });

  test('late refresh result cannot resurrect a logged-out session', () async {
    final store = MemoryCredentialStore(
      credentials(accessExpiresAt: now.subtract(const Duration(seconds: 1))),
    );
    final gateway = FakeAuthGateway();
    final refresh = Completer<MobileCredentials>();
    gateway.refreshResult = refresh.future;
    final manager = MobileSessionManager(store, gateway, clock: () => now);
    await manager.restore();

    final accessToken = manager.accessToken();
    await manager.signOut();
    refresh.complete(
      credentials(accessToken: 'late-access', refreshToken: 'late-refresh'),
    );

    expect(await accessToken, isNull);
    expect(store.value, isNull);
    expect(manager.hasSession, isFalse);
  });

  test('late login result cannot resurrect a cleared session', () async {
    final store = MemoryCredentialStore(null);
    final gateway = FakeAuthGateway();
    final login = Completer<MobileCredentials>();
    final loginStarted = Completer<void>();
    gateway.loginResult = login.future;
    gateway.loginStarted = loginStarted;
    final manager = MobileSessionManager(store, gateway, clock: () => now);

    final signIn = manager.signIn(
      email: 'driver@example.test',
      password: 'password',
      deviceName: 'Driver Phone',
    );
    final expectation = expectLater(
      signIn,
      throwsA(isA<AuthenticationOperationSuperseded>()),
    );
    await loginStarted.future;
    await manager.clear();
    login.complete(credentials(accessToken: 'late-login-access'));

    await expectation;
    expect(store.value, isNull);
    expect(manager.hasSession, isFalse);
  });

  test('MFA verification updates the secure credential atomically', () async {
    final store = MemoryCredentialStore(credentials(mfaRequired: true));
    final gateway = FakeAuthGateway();
    final manager = MobileSessionManager(store, gateway, clock: () => now);
    await manager.restore();

    await manager.verifyMfa(' 123456 ');

    expect(gateway.challengeAccessToken, 'access-old');
    expect(gateway.challengeCredential, '123456');
    expect(manager.mfaRequired, isFalse);
    expect(store.value?.mfaRequired, isFalse);
  });

  test('rejected MFA session clears all local credentials', () async {
    final store = MemoryCredentialStore(credentials(mfaRequired: true));
    final gateway = FakeAuthGateway()..rejectChallenge = true;
    final manager = MobileSessionManager(store, gateway, clock: () => now);
    await manager.restore();

    await expectLater(
      manager.verifyMfa('123456'),
      throwsA(isA<AuthenticationRejected>()),
    );

    expect(manager.hasSession, isFalse);
    expect(store.value, isNull);
  });
}

final class MemoryCredentialStore implements CredentialStore {
  MemoryCredentialStore(this.value);

  MobileCredentials? value;
  var writeCount = 0;

  @override
  Future<void> clear() async => value = null;

  @override
  Future<MobileCredentials?> read() async => value;

  @override
  Future<void> write(MobileCredentials credentials) async {
    writeCount += 1;
    value = credentials;
  }
}

final class FakeAuthGateway implements MobileAuthGateway {
  Future<MobileCredentials>? loginResult;
  Completer<void>? loginStarted;
  Future<MobileCredentials>? refreshResult;
  Object? logoutError;
  var rejectRefresh = false;
  var rejectChallenge = false;
  var refreshCalls = 0;
  String? challengeAccessToken;
  String? challengeCredential;

  @override
  Future<void> challengeMfa({
    required String accessToken,
    required String credential,
  }) async {
    challengeAccessToken = accessToken;
    challengeCredential = credential;
    if (rejectChallenge) throw const AuthenticationRejected();
  }

  @override
  Future<MobileCredentials> login({
    required String email,
    required String password,
    required String deviceName,
  }) {
    loginStarted?.complete();
    return loginResult ?? Future.value(credentials());
  }

  @override
  Future<void> logout(String accessToken) async {
    if (logoutError case final error?) throw error;
  }

  @override
  Future<MobileCredentials> refresh(String refreshToken) {
    refreshCalls += 1;
    if (rejectRefresh) throw const AuthenticationRejected();
    return refreshResult ?? Future.value(credentials());
  }
}

MobileCredentials credentials({
  String accessToken = 'access-old',
  String refreshToken = 'refresh-old',
  DateTime? accessExpiresAt,
  bool mfaRequired = false,
}) {
  return MobileCredentials(
    accessToken: accessToken,
    refreshToken: refreshToken,
    accessExpiresAt: accessExpiresAt ?? DateTime.utc(2026, 7, 23, 10),
    refreshExpiresAt: DateTime.utc(2026, 8, 22, 9),
    mfaRequired: mfaRequired,
  );
}
