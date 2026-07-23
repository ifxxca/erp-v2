import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rajawali_mobile/core/auth/mobile_auth_gateway.dart';
import 'package:rajawali_mobile/core/auth/mobile_session_manager.dart';
import 'package:rajawali_mobile/core/security/credential_store.dart';
import 'package:rajawali_mobile/core/security/mobile_credentials.dart';
import 'package:rajawali_mobile/features/auth/auth_screens.dart';
import 'package:rajawali_mobile/features/auth/mobile_auth_controller.dart';
import 'package:rajawali_mobile/features/operations/operations_context.dart';
import 'package:rajawali_mobile/features/operations/operations_context_repository.dart';

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
    expect(find.text('RKS / Warehouse Kresek'), findsOneWidget);
    expect(find.text('Driver Test'), findsOneWidget);
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
    await tester.pumpAndSettle();

    expect(find.text('RKS / Warehouse Kresek'), findsOneWidget);
    expect(find.text('Driver Test'), findsOneWidget);
  });

  testWidgets('operator can switch between authorized workspaces', (
    tester,
  ) async {
    final harness = await AuthHarness.create(
      storedCredentials: credentials(mfaRequired: false),
    );
    await tester.pumpWidget(harness.app());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('context-selector')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('RWH / Warehouse Cakung'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('active-location')), findsOneWidget);
    expect(find.text('RWH / Warehouse Cakung'), findsOneWidget);
    expect(find.textContaining('Asia/Jakarta'), findsOneWidget);
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

  testWidgets('unauthorized context load returns to login and clears session', (
    tester,
  ) async {
    final harness = await AuthHarness.create(
      storedCredentials: credentials(mfaRequired: false),
    );
    harness.operationsRepository.error = DioException(
      requestOptions: RequestOptions(path: '/operations/context'),
      response: Response<Object?>(
        requestOptions: RequestOptions(path: '/operations/context'),
        statusCode: 401,
      ),
    );

    await tester.pumpWidget(harness.app());
    await tester.pumpAndSettle();

    expect(harness.store.value, isNull);
    expect(find.text('Masuk ke Rajawali Operations'), findsOneWidget);
    expect(find.text('Sesi berakhir. Silakan masuk kembali.'), findsOneWidget);
  });
}

final class AuthHarness {
  AuthHarness._(
    this.store,
    this.gateway,
    this.operationsRepository,
    this.controller,
  );

  final MemoryCredentialStore store;
  final WidgetAuthGateway gateway;
  final WidgetOperationsRepository operationsRepository;
  final MobileAuthController controller;

  static Future<AuthHarness> create({
    MobileCredentials? storedCredentials,
  }) async {
    final store = MemoryCredentialStore(storedCredentials);
    final gateway = WidgetAuthGateway();
    final operationsRepository = WidgetOperationsRepository();
    final manager = MobileSessionManager(store, gateway);
    await manager.restore();
    return AuthHarness._(
      store,
      gateway,
      operationsRepository,
      MobileAuthController(manager),
    );
  }

  Widget app() => MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    ),
    home: MobileAuthFlow(
      controller: controller,
      environment: 'test',
      operationsRepository: operationsRepository,
    ),
  );
}

final class WidgetOperationsRepository implements OperationsContextRepository {
  Object? error;

  @override
  Future<OperationsBootstrapData> load() async {
    if (error case final cause?) throw cause;
    return OperationsBootstrapData(
      identity: const OperatorIdentity(
        id: 'user-1',
        name: 'Driver Test',
        email: 'driver@example.test',
      ),
      workspaces: [
        workspace(
          companyId: 'company-1',
          companyCode: 'RKS',
          companyName: 'PT Rajawali Kresek Sejahtera',
          locationId: 'location-1',
          locationCode: 'RKS-WH',
          locationName: 'RKS / Warehouse Kresek',
        ),
        workspace(
          companyId: 'company-2',
          companyCode: 'RWH',
          companyName: 'PT Rajawali Warehouse Harmoni',
          locationId: 'location-2',
          locationCode: 'RWH-WH',
          locationName: 'RWH / Warehouse Cakung',
        ),
      ],
    );
  }
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

OperationsWorkspace workspace({
  required String companyId,
  required String companyCode,
  required String companyName,
  required String locationId,
  required String locationCode,
  required String locationName,
}) {
  return OperationsWorkspace(
    company: LegalEntity(
      id: companyId,
      code: companyCode,
      legalName: companyName,
    ),
    location: WorkLocation(
      id: locationId,
      code: locationCode,
      name: locationName,
      timezone: 'Asia/Jakarta',
    ),
    capabilities: const MobileOperationsCapabilities(
      canViewVehicles: true,
      canManageVehicles: false,
      canViewWorkOrders: false,
      canManageWorkOrders: false,
      canViewTrips: true,
      canOperateTrips: true,
      canManageTrips: false,
    ),
  );
}
