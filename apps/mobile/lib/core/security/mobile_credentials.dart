final class MobileCredentials {
  const MobileCredentials({
    required this.accessToken,
    required this.refreshToken,
    required this.accessExpiresAt,
    required this.refreshExpiresAt,
    required this.mfaRequired,
  });

  factory MobileCredentials.fromJson(Map<String, Object?> json) {
    final accessToken = json['access_token'];
    final refreshToken = json['refresh_token'];
    final accessExpiresAt = json['access_expires_at'];
    final refreshExpiresAt = json['refresh_expires_at'];
    final mfaRequired = json['mfa_required'];

    if (accessToken is! String ||
        accessToken.isEmpty ||
        refreshToken is! String ||
        refreshToken.isEmpty ||
        accessExpiresAt is! String ||
        refreshExpiresAt is! String ||
        mfaRequired is! bool) {
      throw const FormatException('Stored mobile credentials are invalid.');
    }

    return MobileCredentials(
      accessToken: accessToken,
      refreshToken: refreshToken,
      accessExpiresAt: DateTime.parse(accessExpiresAt).toUtc(),
      refreshExpiresAt: DateTime.parse(refreshExpiresAt).toUtc(),
      mfaRequired: mfaRequired,
    );
  }

  final String accessToken;
  final String refreshToken;
  final DateTime accessExpiresAt;
  final DateTime refreshExpiresAt;
  final bool mfaRequired;

  bool hasUsableAccessToken(DateTime now, Duration refreshLeeway) {
    return accessExpiresAt.isAfter(now.toUtc().add(refreshLeeway));
  }

  bool hasUsableRefreshToken(DateTime now) {
    return refreshExpiresAt.isAfter(now.toUtc());
  }

  MobileCredentials copyWith({bool? mfaRequired}) {
    return MobileCredentials(
      accessToken: accessToken,
      refreshToken: refreshToken,
      accessExpiresAt: accessExpiresAt,
      refreshExpiresAt: refreshExpiresAt,
      mfaRequired: mfaRequired ?? this.mfaRequired,
    );
  }

  Map<String, Object?> toJson() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'access_expires_at': accessExpiresAt.toUtc().toIso8601String(),
    'refresh_expires_at': refreshExpiresAt.toUtc().toIso8601String(),
    'mfa_required': mfaRequired,
  };
}
