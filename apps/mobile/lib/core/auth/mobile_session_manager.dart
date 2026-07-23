import 'dart:async';

import 'package:rajawali_mobile/core/auth/mobile_auth_gateway.dart';
import 'package:rajawali_mobile/core/security/credential_store.dart';
import 'package:rajawali_mobile/core/security/mobile_credentials.dart';

abstract interface class AccessTokenProvider {
  Future<String?> accessToken({bool forceRefresh = false});
}

typedef Clock = DateTime Function();

final class MobileSessionManager implements AccessTokenProvider {
  MobileSessionManager(
    this._credentialStore,
    this._authGateway, {
    Clock? clock,
    this.refreshLeeway = const Duration(seconds: 30),
  }) : _clock = clock ?? DateTime.now;

  final CredentialStore _credentialStore;
  final MobileAuthGateway _authGateway;
  final Clock _clock;
  final Duration refreshLeeway;

  MobileCredentials? _credentials;
  Future<String?>? _refreshInFlight;
  Future<void> _credentialStoreQueue = Future.value();
  var _generation = 0;

  bool get hasSession => _credentials != null;

  bool get mfaRequired => _credentials?.mfaRequired ?? false;

  Future<bool> restore() async {
    final generation = _generation;
    final credentials = await _withCredentialStore(_credentialStore.read);
    if (generation != _generation) return false;
    if (credentials == null ||
        !credentials.hasUsableRefreshToken(_clock().toUtc())) {
      await clear();
      return false;
    }
    _credentials = credentials;
    return true;
  }

  Future<void> signIn({
    required String email,
    required String password,
    required String deviceName,
  }) async {
    final generation = ++_generation;
    _credentials = null;
    await _withCredentialStore(_credentialStore.clear);
    if (generation != _generation) {
      throw const AuthenticationOperationSuperseded();
    }
    final credentials = await _authGateway.login(
      email: email.trim(),
      password: password,
      deviceName: deviceName.trim(),
    );
    if (generation != _generation) {
      throw const AuthenticationOperationSuperseded();
    }
    await _withCredentialStore(() async {
      if (generation != _generation) {
        throw const AuthenticationOperationSuperseded();
      }
      await _credentialStore.write(credentials);
    });
    if (generation != _generation) {
      throw const AuthenticationOperationSuperseded();
    }
    _credentials = credentials;
  }

  @override
  Future<String?> accessToken({bool forceRefresh = false}) async {
    final generation = _generation;
    final credentials =
        _credentials ?? await _withCredentialStore(_credentialStore.read);
    if (credentials == null || generation != _generation) return null;
    _credentials = credentials;

    final now = _clock().toUtc();
    if (!credentials.hasUsableRefreshToken(now)) {
      await clear();
      return null;
    }
    if (!forceRefresh && credentials.hasUsableAccessToken(now, refreshLeeway)) {
      return credentials.accessToken;
    }

    return _singleFlightRefresh();
  }

  Future<String?> _singleFlightRefresh() {
    final existing = _refreshInFlight;
    if (existing != null) return existing;

    late final Future<String?> refresh;
    refresh = _performRefresh().whenComplete(() {
      if (identical(_refreshInFlight, refresh)) _refreshInFlight = null;
    });
    _refreshInFlight = refresh;
    return refresh;
  }

  Future<String?> _performRefresh() async {
    final credentials = _credentials;
    if (credentials == null) return null;
    final generation = _generation;

    try {
      final rotated = await _authGateway.refresh(credentials.refreshToken);
      if (generation != _generation ||
          _credentials?.refreshToken != credentials.refreshToken) {
        return null;
      }
      final committed = await _withCredentialStore(() async {
        if (generation != _generation ||
            _credentials?.refreshToken != credentials.refreshToken) {
          return false;
        }
        await _credentialStore.write(rotated);
        return generation == _generation;
      });
      if (!committed) return null;
      _credentials = rotated;
      return rotated.accessToken;
    } on AuthenticationRejected {
      await clear();
      return null;
    }
  }

  Future<void> verifyMfa(String credential) async {
    final generation = _generation;
    final token = await accessToken();
    if (token == null || generation != _generation) {
      throw const AuthenticationRejected();
    }

    try {
      await _authGateway.challengeMfa(
        accessToken: token,
        credential: credential.trim(),
      );
    } on AuthenticationRejected {
      if (generation == _generation) await clear();
      rethrow;
    }

    if (generation != _generation) {
      throw const AuthenticationOperationSuperseded();
    }
    final credentials = _credentials;
    if (credentials == null) throw const AuthenticationRejected();
    final verified = credentials.copyWith(mfaRequired: false);
    await _withCredentialStore(() async {
      if (generation != _generation) {
        throw const AuthenticationOperationSuperseded();
      }
      await _credentialStore.write(verified);
    });
    if (generation != _generation) {
      throw const AuthenticationOperationSuperseded();
    }
    _credentials = verified;
  }

  Future<void> signOut() async {
    final credentials =
        _credentials ?? await _withCredentialStore(_credentialStore.read);
    await clear();
    if (credentials != null) {
      await _authGateway.logout(credentials.accessToken);
    }
  }

  Future<void> clear() async {
    _generation += 1;
    _credentials = null;
    await _withCredentialStore(_credentialStore.clear);
  }

  Future<T> _withCredentialStore<T>(Future<T> Function() operation) {
    final completer = Completer<T>();
    _credentialStoreQueue = _credentialStoreQueue.then((_) async {
      try {
        completer.complete(await operation());
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }
}
