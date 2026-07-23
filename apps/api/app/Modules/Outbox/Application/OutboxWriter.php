<?php

namespace App\Modules\Outbox\Application;

use App\Models\Company;
use App\Models\OutboxMessage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class OutboxWriter
{
    /** @param array<string, mixed> $payload */
    public function record(
        string $eventType,
        string $aggregateType,
        ?string $aggregateId,
        array $payload,
        string $deduplicationKey,
        ?Company $company = null,
        ?Request $request = null,
    ): OutboxMessage {
        if (DB::transactionLevel() < 1) {
            throw new OutboxWriterException(
                'Outbox messages must be recorded inside the owning domain transaction.',
                'OUTBOX_TRANSACTION_REQUIRED',
            );
        }
        $this->assertIdentifier($eventType, 'event type');
        $this->assertIdentifier($aggregateType, 'aggregate type');
        if ($aggregateId !== null && (strlen($aggregateId) > 64 || $aggregateId === '')) {
            throw new OutboxWriterException('Aggregate ID is invalid.', 'OUTBOX_AGGREGATE_ID_INVALID');
        }
        if (strlen($deduplicationKey) < 16 || strlen($deduplicationKey) > 512) {
            throw new OutboxWriterException(
                'Outbox deduplication key must contain 16-512 characters.',
                'OUTBOX_DEDUPLICATION_KEY_INVALID',
            );
        }

        $normalized = $this->normalize($payload);
        $encoded = json_encode($normalized, JSON_THROW_ON_ERROR | JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
        if (strlen($encoded) > (int) config('outbox.max_payload_bytes')) {
            throw new OutboxWriterException('Outbox payload is too large.', 'OUTBOX_PAYLOAD_TOO_LARGE');
        }
        $deduplicationHash = hash('sha256', $deduplicationKey);
        $fingerprint = hash('sha256', $encoded);
        $existing = OutboxMessage::query()->where('deduplication_key_hash', $deduplicationHash)->first();
        if ($existing !== null) {
            if (! hash_equals($existing->payload_fingerprint, $fingerprint)
                || $existing->event_type !== $eventType
                || $existing->aggregate_type !== $aggregateType
                || $existing->aggregate_id !== $aggregateId
                || $existing->company_id !== $company?->id) {
                throw new OutboxWriterException(
                    'Outbox deduplication key was reused for a different event.',
                    'OUTBOX_DEDUPLICATION_MISMATCH',
                );
            }

            return $existing;
        }

        $requestId = $request?->attributes->get('request_id') ?? $request?->header('X-Request-ID');

        return OutboxMessage::query()->create([
            'company_id' => $company?->id,
            'event_type' => $eventType,
            'aggregate_type' => $aggregateType,
            'aggregate_id' => $aggregateId,
            'deduplication_key_hash' => $deduplicationHash,
            'payload_fingerprint' => $fingerprint,
            'payload' => $normalized,
            'headers' => ['schema_version' => 1],
            'request_id' => is_string($requestId) ? $requestId : null,
            'status' => 'pending',
            'attempts' => 0,
            'available_at' => now(),
            'occurred_at' => now(),
        ]);
    }

    private function assertIdentifier(string $value, string $label): void
    {
        if (preg_match('/^[a-z][a-z0-9_.-]{2,99}$/', $value) !== 1) {
            throw new OutboxWriterException(
                ucfirst($label).' must be a stable lowercase identifier.',
                'OUTBOX_IDENTIFIER_INVALID',
            );
        }
    }

    private function normalize(mixed $value): mixed
    {
        if (! is_array($value)) {
            return $value;
        }
        if (array_is_list($value)) {
            return array_map(fn (mixed $item) => $this->normalize($item), $value);
        }

        ksort($value);

        return array_map(fn (mixed $item) => $this->normalize($item), $value);
    }
}
