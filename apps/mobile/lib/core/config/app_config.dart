enum AppEnvironment {
  local('local'),
  staging('staging'),
  production('production');

  const AppEnvironment(this.label);

  final String label;

  static AppEnvironment parse(String value) {
    return AppEnvironment.values.firstWhere(
      (environment) => environment.label == value,
      orElse: () => throw FormatException('Unsupported APP_ENV: $value'),
    );
  }
}

final class AppConfig {
  AppConfig({
    required this.environment,
    required this.apiBaseUri,
    this.isReleaseBuild = false,
  }) {
    _validate();
  }

  factory AppConfig.fromEnvironment() {
    const environment = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'local',
    );
    const apiBaseUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://10.0.2.2:8080/api/v1',
    );
    const isReleaseBuild = bool.fromEnvironment('dart.vm.product');

    return AppConfig(
      environment: AppEnvironment.parse(environment),
      apiBaseUri: Uri.parse(apiBaseUrl),
      isReleaseBuild: isReleaseBuild,
    );
  }

  final AppEnvironment environment;
  final Uri apiBaseUri;
  final bool isReleaseBuild;

  void _validate() {
    if (isReleaseBuild && environment == AppEnvironment.local) {
      throw const FormatException(
        'Release builds require an explicit non-local APP_ENV.',
      );
    }
    if (!apiBaseUri.hasScheme || apiBaseUri.host.isEmpty) {
      throw const FormatException('API_BASE_URL must be absolute.');
    }
    if (apiBaseUri.userInfo.isNotEmpty ||
        apiBaseUri.hasQuery ||
        apiBaseUri.hasFragment) {
      throw const FormatException(
        'API_BASE_URL cannot contain credentials, query, or fragment.',
      );
    }
    if (!apiBaseUri.path.endsWith('/api/v1')) {
      throw const FormatException('API_BASE_URL must end with /api/v1.');
    }
    if (environment != AppEnvironment.local && apiBaseUri.scheme != 'https') {
      throw const FormatException('Non-local API_BASE_URL must use HTTPS.');
    }
    if (environment == AppEnvironment.local &&
        apiBaseUri.scheme == 'http' &&
        !_localHttpHosts.contains(apiBaseUri.host)) {
      throw const FormatException(
        'Local HTTP is limited to loopback or the Android emulator host.',
      );
    }
  }

  static const _localHttpHosts = {'localhost', '127.0.0.1', '10.0.2.2'};
}
