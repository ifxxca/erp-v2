import 'package:dio/dio.dart';
import 'package:rajawali_api_client/rajawali_api_client.dart';
import 'package:rajawali_mobile/core/auth/mobile_auth_gateway.dart';
import 'package:rajawali_mobile/core/security/mobile_credentials.dart';

final class GeneratedMobileAuthGateway implements MobileAuthGateway {
  GeneratedMobileAuthGateway(this._api);

  final DefaultApi _api;

  @override
  Future<void> challengeMfa({
    required String accessToken,
    required String credential,
  }) async {
    try {
      final response = await _api.challengeMfa(
        mfaChallenge: MfaChallenge(
          (builder) => builder.credential = credential,
        ),
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      if (response.data == null) {
        throw const AuthenticationProtocolException(
          'MFA challenge body is missing.',
        );
      }
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        throw const AuthenticationRejected();
      }
      rethrow;
    }
  }

  @override
  Future<MobileCredentials> login({
    required String email,
    required String password,
    required String deviceName,
  }) async {
    final response = await _api.login(
      loginRequest: LoginRequest(
        (builder) => builder
          ..email = email
          ..password = password
          ..surface = LoginRequestSurfaceEnum.mobile
          ..deviceName = deviceName,
      ),
    );
    final body = response.data;
    if (body == null) {
      throw const AuthenticationProtocolException('Login body is missing.');
    }

    for (final value in body.anyOf.values.values) {
      if (value is MobileTokenResponse) return _credentials(value);
    }

    throw const AuthenticationProtocolException(
      'Mobile login did not return a mobile token response.',
    );
  }

  @override
  Future<MobileCredentials> refresh(String refreshToken) async {
    try {
      final response = await _api.refreshMobileToken(
        refreshMobileTokenRequest: RefreshMobileTokenRequest(
          (builder) => builder.refreshToken = refreshToken,
        ),
      );
      final body = response.data;
      if (body == null) {
        throw const AuthenticationProtocolException('Refresh body is missing.');
      }
      return _credentials(body);
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        throw const AuthenticationRejected();
      }
      rethrow;
    }
  }

  @override
  Future<void> logout(String accessToken) async {
    await _api.logout(headers: {'Authorization': 'Bearer $accessToken'});
  }

  MobileCredentials _credentials(MobileTokenResponse response) {
    return MobileCredentials(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      accessExpiresAt: response.expiresAt,
      refreshExpiresAt: response.refreshExpiresAt,
      mfaRequired: response.mfaRequired,
    );
  }
}
