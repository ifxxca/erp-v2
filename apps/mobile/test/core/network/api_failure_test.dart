import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rajawali_mobile/core/network/api_failure.dart';

void main() {
  test('maps correlated validation errors without losing field details', () {
    final failure = ApiFailure.fromDio(
      dioError(
        422,
        data: {
          'code': 'VALIDATION_FAILED',
          'message': 'The given data was invalid.',
          'request_id': 'request-validation-0001',
          'errors': {
            'odometer': ['Odometer cannot decrease.'],
          },
        },
      ),
    );

    expect(failure.kind, ApiFailureKind.validation);
    expect(failure.code, 'VALIDATION_FAILED');
    expect(failure.requestId, 'request-validation-0001');
    expect(failure.fieldErrors['odometer'], ['Odometer cannot decrease.']);
  });

  test('masks unsafe server messages and keeps response request ID', () {
    final failure = ApiFailure.fromDio(
      dioError(
        500,
        data: {'message': 'SQLSTATE secret internal detail'},
        requestId: 'request-server-0001',
      ),
    );

    expect(failure.kind, ApiFailureKind.server);
    expect(failure.message, isNot(contains('SQLSTATE')));
    expect(failure.requestId, 'request-server-0001');
  });

  test('network errors expose only a safe offline message', () {
    final failure = ApiFailure.fromDio(
      DioException(
        requestOptions: RequestOptions(path: '/fleet/trips'),
        type: DioExceptionType.connectionError,
        error: StateError('socket detail'),
      ),
    );

    expect(failure.kind, ApiFailureKind.network);
    expect(failure.message, isNot(contains('socket detail')));
  });
}

DioException dioError(int status, {Object? data, String? requestId}) {
  final request = RequestOptions(path: '/fleet/trips');
  return DioException.badResponse(
    statusCode: status,
    requestOptions: request,
    response: Response<Object?>(
      requestOptions: request,
      statusCode: status,
      data: data,
      headers: Headers.fromMap({
        if (requestId != null) 'X-Request-ID': [requestId],
      }),
    ),
  );
}
