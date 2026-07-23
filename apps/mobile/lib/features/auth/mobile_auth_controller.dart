import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rajawali_mobile/core/auth/mobile_auth_gateway.dart';
import 'package:rajawali_mobile/core/auth/mobile_session_manager.dart';
import 'package:rajawali_mobile/core/network/api_failure.dart';

enum MobileAuthStage { signedOut, mfaRequired, authenticated }

final class MobileAuthController extends ChangeNotifier {
  MobileAuthController(this._sessionManager)
    : _stage = _stageFrom(_sessionManager);

  final MobileSessionManager _sessionManager;

  MobileAuthStage _stage;
  bool _busy = false;
  String? _errorMessage;

  MobileAuthStage get stage => _stage;
  bool get busy => _busy;
  String? get errorMessage => _errorMessage;

  Future<void> signIn({
    required String email,
    required String password,
    required String deviceName,
  }) async {
    if (_busy) return;
    _startOperation();
    try {
      await _sessionManager.signIn(
        email: email,
        password: password,
        deviceName: deviceName,
      );
      _stage = _stageFrom(_sessionManager);
    } on Object catch (error) {
      _stage = MobileAuthStage.signedOut;
      _errorMessage = _messageFor(error, 'Login gagal. Coba kembali.');
    } finally {
      _finishOperation();
    }
  }

  Future<void> verifyMfa(String credential) async {
    if (_busy) return;
    _startOperation();
    try {
      await _sessionManager.verifyMfa(credential);
      _stage = MobileAuthStage.authenticated;
    } on AuthenticationRejected {
      _stage = MobileAuthStage.signedOut;
      _errorMessage = 'Sesi berakhir. Silakan masuk kembali.';
    } on Object catch (error) {
      _stage = _stageFrom(_sessionManager);
      _errorMessage = _messageFor(
        error,
        'Kode keamanan tidak dapat diverifikasi.',
      );
    } finally {
      _finishOperation();
    }
  }

  Future<void> signOut() async {
    if (_busy) return;
    _startOperation();
    try {
      await _sessionManager.signOut();
    } on Object catch (error) {
      _errorMessage = _messageFor(
        error,
        'Sesi lokal sudah dihapus, tetapi server tidak dapat dihubungi.',
      );
    } finally {
      _stage = MobileAuthStage.signedOut;
      _finishOperation();
    }
  }

  void _startOperation() {
    _busy = true;
    _errorMessage = null;
    notifyListeners();
  }

  void _finishOperation() {
    _busy = false;
    notifyListeners();
  }

  static MobileAuthStage _stageFrom(MobileSessionManager manager) {
    if (!manager.hasSession) return MobileAuthStage.signedOut;
    return manager.mfaRequired
        ? MobileAuthStage.mfaRequired
        : MobileAuthStage.authenticated;
  }

  static String _messageFor(Object error, String fallback) {
    if (error is DioException) {
      final failure = ApiFailure.fromDio(error);
      return switch (failure.code) {
        'INVALID_CREDENTIALS' => 'Email atau password tidak valid.',
        'MFA_CODE_INVALID' => 'Kode keamanan tidak valid atau sudah digunakan.',
        'MFA_NOT_ENABLED' =>
          'Verifikasi dua langkah belum aktif untuk akun ini.',
        _ => failure.message,
      };
    }
    if (error is AuthenticationProtocolException) {
      return 'Respons autentikasi server tidak valid.';
    }
    if (error is AuthenticationRejected) {
      return 'Sesi berakhir. Silakan masuk kembali.';
    }
    if (error is AuthenticationOperationSuperseded) {
      return 'Proses autentikasi dibatalkan.';
    }
    return fallback;
  }
}
