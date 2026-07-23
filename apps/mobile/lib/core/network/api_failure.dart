import 'package:dio/dio.dart';

enum ApiFailureKind {
  network,
  unauthenticated,
  forbidden,
  notFound,
  conflict,
  validation,
  rateLimited,
  server,
  unknown,
}

final class ApiFailure implements Exception {
  const ApiFailure({
    required this.kind,
    required this.message,
    this.code,
    this.requestId,
    this.fieldErrors = const {},
  });

  factory ApiFailure.fromDio(DioException exception) {
    final response = exception.response;
    if (response == null) {
      return const ApiFailure(
        kind: ApiFailureKind.network,
        message: 'Tidak dapat terhubung ke server. Periksa koneksi Anda.',
      );
    }

    final status = response.statusCode;
    final responseData = response.data;
    final body = responseData is Map<Object?, Object?>
        ? responseData
        : const <Object?, Object?>{};
    final rawCode = body['code'];
    final code = rawCode is String ? rawCode : null;
    final rawRequestId = body['request_id'];
    final bodyRequestId = rawRequestId is String ? rawRequestId : null;
    final requestId = bodyRequestId ?? response.headers.value('X-Request-ID');
    final rawMessage = body['message'];
    final serverMessage = rawMessage is String && rawMessage.trim().isNotEmpty
        ? rawMessage
        : null;

    return ApiFailure(
      kind: _kind(status),
      message: status != null && status >= 500
          ? 'Server mengalami gangguan. Coba kembali nanti.'
          : serverMessage ?? _fallbackMessage(status),
      code: code,
      requestId: requestId,
      fieldErrors: _fieldErrors(body['errors']),
    );
  }

  final ApiFailureKind kind;
  final String message;
  final String? code;
  final String? requestId;
  final Map<String, List<String>> fieldErrors;

  static ApiFailureKind _kind(int? status) {
    if (status != null && status >= 500) return ApiFailureKind.server;

    return switch (status) {
      401 => ApiFailureKind.unauthenticated,
      403 => ApiFailureKind.forbidden,
      404 => ApiFailureKind.notFound,
      409 => ApiFailureKind.conflict,
      422 => ApiFailureKind.validation,
      429 => ApiFailureKind.rateLimited,
      _ => ApiFailureKind.unknown,
    };
  }

  static String _fallbackMessage(int? status) => switch (status) {
    401 => 'Sesi Anda tidak lagi valid.',
    403 => 'Anda tidak memiliki akses untuk tindakan ini.',
    404 => 'Data yang diminta tidak ditemukan.',
    409 => 'Perubahan bertabrakan dengan data terbaru.',
    422 => 'Periksa kembali data yang diisi.',
    429 => 'Terlalu banyak percobaan. Coba kembali nanti.',
    _ => 'Permintaan tidak dapat diproses.',
  };

  static Map<String, List<String>> _fieldErrors(Object? value) {
    if (value is! Map<Object?, Object?>) return const {};

    final result = <String, List<String>>{};
    for (final MapEntry(:key, :value) in value.entries) {
      if (key is! String || value is! Iterable<Object?>) continue;
      result[key] = value.whereType<String>().toList(growable: false);
    }
    return Map.unmodifiable(result);
  }
}
