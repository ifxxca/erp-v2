<?php

namespace App\Jobs;

use App\Models\NotificationDelivery;
use App\Models\NotificationDeliveryAttempt;
use App\Modules\Notifications\Application\NotificationChannelSender;
use App\Modules\Outbox\Application\PermanentOutboxFailure;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Throwable;

class DeliverPlatformNotification implements ShouldBeUnique, ShouldQueue
{
    use Queueable;

    public int $tries = 1;

    public int $uniqueFor = 600;

    public function __construct(public readonly string $deliveryId) {}

    public function uniqueId(): string
    {
        return $this->deliveryId;
    }

    public function handle(NotificationChannelSender $sender): void
    {
        $delivery = DB::transaction(function (): ?NotificationDelivery {
            $delivery = NotificationDelivery::query()->lockForUpdate()->findOrFail($this->deliveryId);
            if (in_array($delivery->status, ['delivered', 'dead_letter'], true)) {
                return null;
            }

            NotificationDeliveryAttempt::query()
                ->where('notification_delivery_id', $delivery->id)
                ->where('status', 'processing')
                ->update([
                    'status' => 'failed',
                    'finished_at' => now(),
                    'error_code' => 'NOTIFICATION_ATTEMPT_ABANDONED',
                    'error_message' => 'The worker lease expired before completion.',
                    'updated_at' => now(),
                ]);
            $attemptNo = $delivery->attempts + 1;
            $attemptInCycle = $delivery->attempts_in_cycle + 1;
            NotificationDeliveryAttempt::query()->create([
                'notification_delivery_id' => $delivery->id,
                'attempt_no' => $attemptNo,
                'status' => 'processing',
                'started_at' => now(),
            ]);
            $delivery->forceFill([
                'attempts' => $attemptNo,
                'attempts_in_cycle' => $attemptInCycle,
                'status' => 'processing',
            ])->save();

            return $delivery;
        });
        if ($delivery === null) {
            return;
        }
        $delivery->loadMissing('notification.source');
        $context = array_filter([
            'request_id' => $delivery->notification->source->request_id,
            'notification_delivery_id' => $delivery->id,
            'notification_id' => $delivery->notification_id,
            'channel' => $delivery->channel,
            'attempt_no' => $delivery->attempts,
        ]);
        Log::debug('Delivering platform notification.', $context);

        try {
            $providerMessageId = $sender->send($delivery);
            DB::transaction(function () use ($delivery, $providerMessageId): void {
                $delivery = NotificationDelivery::query()->lockForUpdate()->findOrFail($delivery->id);
                NotificationDeliveryAttempt::query()
                    ->where('notification_delivery_id', $delivery->id)
                    ->where('attempt_no', $delivery->attempts)
                    ->update(['status' => 'succeeded', 'finished_at' => now(), 'updated_at' => now()]);
                $delivery->forceFill([
                    'status' => 'delivered',
                    'claimed_at' => null,
                    'delivered_at' => now(),
                    'provider_message_id' => $providerMessageId,
                    'last_error_code' => null,
                    'last_error_message' => null,
                ])->save();
            });
            Log::info('Platform notification delivered.', $context + array_filter([
                'provider_message_id' => $providerMessageId,
            ]));
        } catch (Throwable $exception) {
            $this->recordFailure($exception);
        }
    }

    private function recordFailure(Throwable $exception): void
    {
        DB::transaction(function () use ($exception): void {
            $delivery = NotificationDelivery::query()->lockForUpdate()->findOrFail($this->deliveryId);
            if (in_array($delivery->status, ['delivered', 'dead_letter'], true)) {
                return;
            }

            $permanent = $exception instanceof PermanentOutboxFailure;
            $deadLetter = $permanent
                || $delivery->attempts_in_cycle >= (int) config('outbox.delivery_max_attempts');
            $errorCode = $permanent ? $exception->errorCode : 'NOTIFICATION_DELIVERY_FAILED';
            $errorMessage = mb_substr($exception->getMessage(), 0, 2000);
            NotificationDeliveryAttempt::query()
                ->where('notification_delivery_id', $delivery->id)
                ->where('attempt_no', $delivery->attempts)
                ->update([
                    'status' => 'failed',
                    'finished_at' => now(),
                    'error_code' => $errorCode,
                    'error_message' => $errorMessage,
                    'updated_at' => now(),
                ]);
            $backoff = config('outbox.backoff_seconds');
            $delivery->forceFill([
                'status' => $deadLetter ? 'dead_letter' : 'pending',
                'available_at' => now()->addSeconds((int) ($backoff[
                    min($delivery->attempts - 1, count($backoff) - 1)
                ] ?? 300)),
                'claimed_at' => null,
                'dead_lettered_at' => $deadLetter ? now() : null,
                'last_error_code' => $errorCode,
                'last_error_message' => $errorMessage,
            ])->save();
            $delivery->loadMissing('notification.source');
            Log::warning('Platform notification delivery failed.', array_filter([
                'request_id' => $delivery->notification->source->request_id,
                'notification_delivery_id' => $delivery->id,
                'notification_id' => $delivery->notification_id,
                'channel' => $delivery->channel,
                'attempt_no' => $delivery->attempts,
                'error_code' => $errorCode,
                'dead_letter' => $deadLetter,
            ]));
        });
    }
}
