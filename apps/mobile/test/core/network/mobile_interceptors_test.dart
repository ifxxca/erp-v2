import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rajawali_mobile/core/auth/mobile_session_manager.dart';
import 'package:rajawali_mobile/core/network/mobile_interceptors.dart';
import 'package:rajawali_mobile/core/network/request_metadata.dart';

void main() {
  test('protected request receives bearer and correlation headers', () async {
    final adapter = RecordingAdapter([200]);
    final dio = testDio(adapter);
    final tokens = FakeTokenProvider();
    dio.interceptors.addAll([
      RequestMetadataInterceptor(SequenceIdFactory()),
      AuthRefreshInterceptor(dio, tokens),
    ]);

    await dio.get<void>('/fleet/vehicles');

    expect(adapter.requests.single.headers['Authorization'], 'Bearer access-1');
    expect(adapter.requests.single.headers['X-Request-ID'], 'request-00000001');
  });

  test('one unauthorized response refreshes and retries once', () async {
    final adapter = RecordingAdapter([401, 200]);
    final dio = testDio(adapter);
    final tokens = FakeTokenProvider();
    dio.interceptors.addAll([
      RequestMetadataInterceptor(SequenceIdFactory()),
      AuthRefreshInterceptor(dio, tokens),
    ]);

    final response = await dio.get<void>('/fleet/trips');

    expect(response.statusCode, 200);
    expect(adapter.requests, hasLength(2));
    expect(adapter.requests.first.headers['Authorization'], 'Bearer access-1');
    expect(adapter.requests.last.headers['Authorization'], 'Bearer access-2');
    expect(
      adapter.requests.last.headers['X-Request-ID'],
      adapter.requests.first.headers['X-Request-ID'],
    );
    expect(tokens.forceRefreshCalls, 1);
  });

  test('public auth request never receives bearer token', () async {
    final adapter = RecordingAdapter([200]);
    final dio = testDio(adapter);
    final tokens = FakeTokenProvider();
    dio.interceptors.addAll([
      RequestMetadataInterceptor(SequenceIdFactory()),
      AuthRefreshInterceptor(dio, tokens),
    ]);

    await dio.post<void>('/auth/login');

    expect(adapter.requests.single.headers, isNot(contains('Authorization')));
    expect(tokens.calls, 0);
  });

  test('mutation context keeps stable idempotency metadata', () {
    final context = MutationRequestContext.create(SequenceIdFactory());

    expect(context.requestId, 'request-00000001');
    expect(context.idempotencyKey, 'request-00000002');
    expect(context.headers['X-Request-ID'], context.requestId);
    expect(context.headers['Idempotency-Key'], context.idempotencyKey);
  });
}

Dio testDio(HttpClientAdapter adapter) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://api.example.test/api/v1',
      validateStatus: (status) => status != null && status < 400,
    ),
  )..httpClientAdapter = adapter;
}

final class SequenceIdFactory implements RequestIdFactory {
  var _sequence = 0;

  @override
  String create() {
    _sequence += 1;
    return 'request-${_sequence.toString().padLeft(8, '0')}';
  }
}

final class FakeTokenProvider implements AccessTokenProvider {
  var calls = 0;
  var forceRefreshCalls = 0;

  @override
  Future<String?> accessToken({bool forceRefresh = false}) async {
    calls += 1;
    if (forceRefresh) {
      forceRefreshCalls += 1;
      return 'access-2';
    }
    return 'access-1';
  }
}

final class RecordingAdapter implements HttpClientAdapter {
  RecordingAdapter(this._statuses);

  final List<int> _statuses;
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options.copyWith(headers: Map.of(options.headers)));
    final status = _statuses[requests.length - 1];
    return ResponseBody.fromString(
      '{}',
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
