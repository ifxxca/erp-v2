import 'package:dio/dio.dart';
import 'package:rajawali_mobile/core/auth/mobile_session_manager.dart';
import 'package:rajawali_mobile/core/network/request_metadata.dart';

final class RequestMetadataInterceptor extends Interceptor {
  RequestMetadataInterceptor(this._requestIdFactory);

  final RequestIdFactory _requestIdFactory;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.putIfAbsent('X-Request-ID', _requestIdFactory.create);
    handler.next(options);
  }
}

final class AuthRefreshInterceptor extends Interceptor {
  AuthRefreshInterceptor(this._dio, this._tokenProvider);

  static const _retriedKey = 'rajawali.auth.retried';
  static const _publicPaths = {'/auth/login', '/auth/mobile/refresh'};

  final Dio _dio;
  final AccessTokenProvider _tokenProvider;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_isPublic(options) && options.extra[_retriedKey] != true) {
      final token = await _tokenProvider.accessToken();
      if (token != null) options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final request = err.requestOptions;
    if (err.response?.statusCode != 401 ||
        _isPublic(request) ||
        request.extra[_retriedKey] == true) {
      handler.next(err);
      return;
    }

    String? token;
    try {
      token = await _tokenProvider.accessToken(forceRefresh: true);
    } on Object {
      handler.next(err);
      return;
    }
    if (token == null) {
      handler.next(err);
      return;
    }

    request.extra[_retriedKey] = true;
    request.headers['Authorization'] = 'Bearer $token';
    try {
      handler.resolve(await _dio.fetch<dynamic>(request));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  bool _isPublic(RequestOptions options) {
    return _publicPaths.any(options.uri.path.endsWith);
  }
}
