import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rajawali_mobile/core/auth/mobile_auth_gateway.dart';
import 'package:rajawali_mobile/core/auth/mobile_session_manager.dart';
import 'package:rajawali_mobile/core/security/credential_store.dart';
import 'package:rajawali_mobile/core/security/mobile_credentials.dart';
import 'package:rajawali_mobile/features/auth/auth_screens.dart';
import 'package:rajawali_mobile/features/auth/mobile_auth_controller.dart';

void main() {
  testWidgets('login, MFA, authenticated shell, and logout form one flow', (
    tester,
  ) async {
    final harness = await AuthHarness.create();
    await tester.pumpWidget(harness.app());

    expect(find.text('Masuk ke Rajawali Operations'), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('login-email')),
      'driver@example.test',
    );
    await tester.enterText(
      find.byKey(const Key('login-password')),
      'correct-password',
    );
    await tester.tap(find.byKey(const Key('login-submit')));
    await tester.pumpAndSettle();

    expect(harness.gateway.loginDeviceName, 'Rajawali Mobile Android');
    expect(find.text('Verifikasi dua langkah'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('mfa-credential')), '123456');
    await tester.tap(find.byKey(const Key('mfa-submit')));
    await tester.pumpAndSettle();

    expect(harness.store.value?.mfaRequired, isFalse);
    expect(find.text('Operasional lapangan'), findsOneWidget);
    await tester.tap(find.byKey(const Key('sign-out')));
    await tester.pumpAndSettle();

    expect(harness.gateway.logoutCalls, 1);
    expect(harness.store.value, isNull);
    expect(find.text('Masuk ke Rajawali Operations'), findsOneWidget);
  });

  testWidgets('restored verified session opens authenticated shell', (
    tester,
  ) async {
    final harness = await AuthHarness.create(
      storedCredentials: credentials(mfaRequired: false),
    );

    await tester.pumpWidget(harness.app());

    expect(find.text('Operasional lapangan'), findsOneWidget);
    expect(find.text('Environment: test'), findsOneWidget);
  });

  testWidgets('known login error is translated without exposing internals', (
    tester,
  ) async {
    final harness = await AuthHarness.create();
    harness.gateway.loginError = DioException(
      requestOptions: RequestOptions(path: '/auth/login'),
      response: Response<Object?>(
        requestOptions: RequestOptions(path: '/auth/login'),
        statusCode: 401,
        data: const {
          'code': 'INVALID_CREDENTIALS',
          'message': 'Internal source message',
        },
      ),
    );
    await tester.pumpWidget(harness.app());

    await tester.enterText(
      find.byKey(const Key('login-email')),
      'driver@example.test',
    );
    await tester.enterText(
      find.byKey(const Key('login-password')),
      'wrong-password',
    );
    await tester.tap(find.byKey(const Key('login-submit')));
    await tester.pumpAndSettle();

    expect(find.text('Email atau password tidak valid.'), findsOneWidget);
    expect(find.text('Internal source message'), findsNothing);
  });
}

final class AuthHarness {
  AuthHarness._(this.store, this.gateway, this.controller);

  final MemoryCredentialStore store;
  final WidgetAuthGateway gateway;
  final MobileAuthController controller;

  static Future<AuthHarness> create({
    MobileCredentials? storedCredentials,
  }) async {
    final store = MemoryCredentialStore(storedCredentials);
    final gateway = WidgetAuthGateway();
    final manager = MobileSessionManager(store, gateway);
    await manager.restore();
    return AuthHarness._(store, gateway, MobileAuthController(manager));
  }

  Widget app() => MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    ),
    home: MobileAuthFlow(controller: controller, environment: 'test'),
  );
}

final class MemoryCredentialStore implements CredentialStore {
  MemoryCredentialStore(this.value);

  MobileCredentials? value;

  @override
  Future<void> clear() async => value = null;

  @override
  Future<MobileCredentials?> read() async => value;

  @override
  Future<void> write(MobileCredentials credentials) async =>
      value = credentials;
}

final class WidgetAuthGateway implements MobileAuthGateway {
  Object? loginError;
  String? loginDeviceName;
  var logoutCalls = 0;

  @override
  Future<void> challengeMfa({
    required String accessToken,
    required String credential,
  }) async {}

  @override
  Future<MobileCredentials> login({
    required String email,
    required String password,
    required String deviceName,
  }) async {
    loginDeviceName = deviceName;
    if (loginError case final error?) throw error;
    return credentials(mfaRequired: true);
  }

  @override
  Future<void> logout(String accessToken) async {
    logoutCalls += 1;
  }

  @override
  Future<MobileCredentials> refresh(String refreshToken) async {
    return credentials(mfaRequired: true);
  }
}

MobileCredentials credentials({required bool mfaRequired}) {
  return MobileCredentials(
    accessToken: 'access-token',
    refreshToken: 'refresh-token',
    accessExpiresAt: DateTime.now().toUtc().add(const Duration(hours: 1)),
    refreshExpiresAt: DateTime.now().toUtc().add(const Duration(days: 30)),
    mfaRequired: mfaRequired,
  );
}
