import 'package:dio/dio.dart';
import 'package:rajawali_api_client/rajawali_api_client.dart';
import 'package:rajawali_mobile/core/auth/generated_mobile_auth_gateway.dart';
import 'package:rajawali_mobile/core/auth/mobile_session_manager.dart';
import 'package:rajawali_mobile/core/config/app_config.dart';
import 'package:rajawali_mobile/core/network/mobile_interceptors.dart';
import 'package:rajawali_mobile/core/network/request_metadata.dart';
import 'package:rajawali_mobile/core/security/credential_store.dart';

final class AppServices {
  const AppServices({
    required this.sessionManager,
    required this.api,
    required this.requestIdFactory,
  });

  final MobileSessionManager sessionManager;
  final DefaultApi api;
  final RequestIdFactory requestIdFactory;
}

final class AppBootstrap {
  const AppBootstrap(this.config);

  final AppConfig config;

  Future<AppServices> create() async {
    const requestIdFactory = UuidRequestIdFactory();
    final publicDio = _dio();
    publicDio.interceptors.add(RequestMetadataInterceptor(requestIdFactory));
    final authClient = RajawaliApiClient(
      dio: publicDio,
      interceptors: const [],
    );
    final sessionManager = MobileSessionManager(
      SecureCredentialStore(FlutterSecureValueStore()),
      GeneratedMobileAuthGateway(authClient.getDefaultApi()),
    );
    await sessionManager.restore();

    final authenticatedDio = _dio();
    authenticatedDio.interceptors.addAll([
      RequestMetadataInterceptor(requestIdFactory),
      AuthRefreshInterceptor(authenticatedDio, sessionManager),
    ]);
    final apiClient = RajawaliApiClient(
      dio: authenticatedDio,
      interceptors: const [],
    );

    return AppServices(
      sessionManager: sessionManager,
      api: apiClient.getDefaultApi(),
      requestIdFactory: requestIdFactory,
    );
  }

  Dio _dio() => Dio(
    BaseOptions(
      baseUrl: config.apiBaseUri.toString(),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: const {'Accept': 'application/json'},
    ),
  );
}
