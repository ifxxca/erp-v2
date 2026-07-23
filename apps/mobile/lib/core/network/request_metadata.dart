import 'package:uuid/uuid.dart';

abstract interface class RequestIdFactory {
  String create();
}

final class UuidRequestIdFactory implements RequestIdFactory {
  const UuidRequestIdFactory([Uuid uuid = const Uuid()]) : _uuid = uuid;

  final Uuid _uuid;

  @override
  String create() => _uuid.v7();
}

final class MutationRequestContext {
  MutationRequestContext._({
    required this.requestId,
    required this.idempotencyKey,
  });

  factory MutationRequestContext.create(RequestIdFactory factory) {
    return MutationRequestContext._(
      requestId: factory.create(),
      idempotencyKey: factory.create(),
    );
  }

  final String requestId;
  final String idempotencyKey;

  Map<String, dynamic> get headers => {
    'X-Request-ID': requestId,
    'Idempotency-Key': idempotencyKey,
  };
}
