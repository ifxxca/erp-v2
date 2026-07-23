import 'package:rajawali_mobile/core/security/mobile_credentials.dart';

abstract interface class MobileAuthGateway {
  Future<MobileCredentials> login({
    required String email,
    required String password,
    required String deviceName,
  });

  Future<MobileCredentials> refresh(String refreshToken);

  Future<void> challengeMfa({
    required String accessToken,
    required String credential,
  });

  Future<void> logout(String accessToken);
}

final class AuthenticationRejected implements Exception {
  const AuthenticationRejected();
}

final class AuthenticationOperationSuperseded implements Exception {
  const AuthenticationOperationSuperseded();
}

final class AuthenticationProtocolException implements Exception {
  const AuthenticationProtocolException(this.message);

  final String message;

  @override
  String toString() => 'AuthenticationProtocolException: $message';
}
