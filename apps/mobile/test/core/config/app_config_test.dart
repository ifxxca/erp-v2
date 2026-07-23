import 'package:flutter_test/flutter_test.dart';
import 'package:rajawali_mobile/core/config/app_config.dart';

void main() {
  test('local Android emulator URL is accepted', () {
    final config = AppConfig(
      environment: AppEnvironment.local,
      apiBaseUri: Uri.parse('http://10.0.2.2:8080/api/v1'),
    );

    expect(config.apiBaseUri.host, '10.0.2.2');
  });

  test('production requires HTTPS', () {
    expect(
      () => AppConfig(
        environment: AppEnvironment.production,
        apiBaseUri: Uri.parse('http://api.example.test/api/v1'),
      ),
      throwsFormatException,
    );
  });

  test('release build cannot use local defaults', () {
    expect(
      () => AppConfig(
        environment: AppEnvironment.local,
        apiBaseUri: Uri.parse('http://10.0.2.2:8080/api/v1'),
        isReleaseBuild: true,
      ),
      throwsFormatException,
    );
  });

  test('base URL rejects credentials and wrong API version', () {
    expect(
      () => AppConfig(
        environment: AppEnvironment.staging,
        apiBaseUri: Uri.parse('https://user:secret@api.example.test/api/v1'),
      ),
      throwsFormatException,
    );
    expect(
      () => AppConfig(
        environment: AppEnvironment.production,
        apiBaseUri: Uri.parse('https://api.example.test/api/v2'),
      ),
      throwsFormatException,
    );
  });
}
