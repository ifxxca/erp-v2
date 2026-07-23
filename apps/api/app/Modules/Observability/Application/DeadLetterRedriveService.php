<?php

namespace App\Modules\Observability\Application;

use App\Models\NotificationDelivery;
use App\Models\OutboxMessage;
use App\Modules\Identity\Application\AuditLogger;
use App\Modules\Outbox\Application\OutboxHandlerRegistry;
use Illuminate\Support\Facades\DB;
use Throwable;

class DeadLetterRedriveService
{
    public function __construct(
        private readonly AuditLogger $audit,
        private readonly OutboxHandlerRegistry $handlers,
    ) {}

    public function outbox(string $messageId, string $reason, string $operator): OutboxMessage
    {
        $this->assertExplanation($reason, $operator);

        return DB::transaction(function () use ($messageId, $reason, $operator): OutboxMessage {
            $message = OutboxMessage::query()->lockForUpdate()->find($messageId);
            if (! $message) {
                throw new DeadLetterRedriveException('Outbox message was not found.', 'OUTBOX_MESSAGE_NOT_FOUND');
            }
            if ($message->status !== 'dead_letter') {
                throw new DeadLetterRedriveException(
                    'Only a dead-lettered outbox message can be re-driven.',
                    'OUTBOX_MESSAGE_NOT_DEAD_LETTER',
                );
            }
            try {
                $this->handlers->for($message->event_type);
            } catch (Throwable) {
                throw new DeadLetterRedriveException(
                    'The outbox handler is not currently available.',
                    'OUTBOX_HANDLER_UNAVAILABLE',
                );
            }
            $previousError = $message->last_error_code;
            $message->forceFill([
                'status' => 'pending',
                'attempts_in_cycle' => 0,
                'redrive_count' => $message->redrive_count + 1,
                'available_at' => now(),
                'claimed_at' => null,
                'processed_at' => null,
                'dead_lettered_at' => null,
                'last_redriven_at' => now(),
                'last_error_code' => null,
                'last_error_message' => null,
            ])->save();
            $this->audit->record('platform.outbox_redriven', null, $message, [
                'operator' => $operator,
                'reason' => $reason,
                'previous_error_code' => $previousError,
                'redrive_count' => $message->redrive_count,
            ]);

            return $message;
        });
    }

    public function delivery(string $deliveryId, string $reason, string $operator): NotificationDelivery
    {
        $this->assertExplanation($reason, $operator);

        return DB::transaction(function () use ($deliveryId, $reason, $operator): NotificationDelivery {
            $delivery = NotificationDelivery::query()->lockForUpdate()->find($deliveryId);
            if (! $delivery) {
                throw new DeadLetterRedriveException(
                    'Notification delivery was not found.',
                    'NOTIFICATION_DELIVERY_NOT_FOUND',
                );
            }
            if ($delivery->status !== 'dead_letter') {
                throw new DeadLetterRedriveException(
                    'Only a dead-lettered notification delivery can be re-driven.',
                    'NOTIFICATION_DELIVERY_NOT_DEAD_LETTER',
                );
            }
            if ($delivery->channel !== 'mail') {
                throw new DeadLetterRedriveException(
                    'This notification channel cannot be re-driven.',
                    'NOTIFICATION_CHANNEL_NOT_REDRIVABLE',
                );
            }
            $previousError = $delivery->last_error_code;
            $delivery->forceFill([
                'status' => 'pending',
                'attempts_in_cycle' => 0,
                'redrive_count' => $delivery->redrive_count + 1,
                'available_at' => now(),
                'claimed_at' => null,
                'delivered_at' => null,
                'dead_lettered_at' => null,
                'last_redriven_at' => now(),
                'last_error_code' => null,
                'last_error_message' => null,
            ])->save();
            $this->audit->record('platform.notification_delivery_redriven', null, $delivery, [
                'operator' => $operator,
                'reason' => $reason,
                'previous_error_code' => $previousError,
                'redrive_count' => $delivery->redrive_count,
            ]);

            return $delivery;
        });
    }

    private function assertExplanation(string $reason, string $operator): void
    {
        if (mb_strlen(trim($reason)) < 10 || mb_strlen($reason) > 1000) {
            throw new DeadLetterRedriveException(
                'A re-drive reason between 10 and 1000 characters is required.',
                'REDRIVE_REASON_INVALID',
            );
        }
        if ($operator === '' || mb_strlen($operator) > 128) {
            throw new DeadLetterRedriveException(
                'A valid operator identifier is required.',
                'REDRIVE_OPERATOR_INVALID',
            );
        }
    }
}
