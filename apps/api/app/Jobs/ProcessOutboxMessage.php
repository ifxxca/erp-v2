<?php

namespace App\Jobs;

use App\Models\OutboxAttempt;
use App\Models\OutboxMessage;
use App\Modules\Outbox\Application\OutboxHandlerRegistry;
use App\Modules\Outbox\Application\PermanentOutboxFailure;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Throwable;

class ProcessOutboxMessage implements ShouldBeUnique, ShouldQueue
{
    use Queueable;

    public int $tries = 1;

    public int $uniqueFor = 600;

    public function __construct(public readonly string $messageId) {}

    public function uniqueId(): string
    {
        return $this->messageId;
    }

    public function handle(OutboxHandlerRegistry $handlers): void
    {
        try {
            DB::transaction(function () use ($handlers): void {
                $message = OutboxMessage::query()->lockForUpdate()->findOrFail($this->messageId);
                if (in_array($message->status, ['processed', 'dead_letter'], true)) {
                    return;
                }

                $attemptNo = $message->attempts + 1;
                $attemptInCycle = $message->attempts_in_cycle + 1;
                $attempt = OutboxAttempt::query()->create([
                    'outbox_message_id' => $message->id,
                    'attempt_no' => $attemptNo,
                    'status' => 'processing',
                    'worker_id' => gethostname() ?: null,
                    'started_at' => now(),
                ]);
                $message->forceFill([
                    'attempts' => $attemptNo,
                    'attempts_in_cycle' => $attemptInCycle,
                    'status' => 'processing',
                ])->save();
                Log::debug('Processing outbox message.', array_filter([
                    'request_id' => $message->request_id,
                    'outbox_message_id' => $message->id,
                    'event_type' => $message->event_type,
                ]));

                $handlers->for($message->event_type)->handle($message);

                $attempt->forceFill(['status' => 'succeeded', 'finished_at' => now()])->save();
                $message->forceFill([
                    'status' => 'processed',
                    'processed_at' => now(),
                    'claimed_at' => null,
                    'last_error_code' => null,
                    'last_error_message' => null,
                ])->save();
                Log::info('Outbox message processed.', array_filter([
                    'request_id' => $message->request_id,
                    'outbox_message_id' => $message->id,
                    'event_type' => $message->event_type,
                    'attempt_no' => $attemptNo,
                ]));
            });
        } catch (Throwable $exception) {
            $this->recordFailure($exception);
        }
    }

    private function recordFailure(Throwable $exception): void
    {
        DB::transaction(function () use ($exception): void {
            $message = OutboxMessage::query()->lockForUpdate()->findOrFail($this->messageId);
            if (in_array($message->status, ['processed', 'dead_letter'], true)) {
                return;
            }

            $attemptNo = $message->attempts + 1;
            $attemptInCycle = $message->attempts_in_cycle + 1;
            $permanent = $exception instanceof PermanentOutboxFailure;
            $deadLetter = $permanent || $attemptInCycle >= (int) config('outbox.max_attempts');
            $errorCode = $permanent ? $exception->errorCode : 'OUTBOX_HANDLER_FAILED';
            $errorMessage = mb_substr($exception->getMessage(), 0, 2000);
            OutboxAttempt::query()->create([
                'outbox_message_id' => $message->id,
                'attempt_no' => $attemptNo,
                'status' => 'failed',
                'worker_id' => gethostname() ?: null,
                'started_at' => now(),
                'finished_at' => now(),
                'error_code' => $errorCode,
                'error_message' => $errorMessage,
            ]);
            $backoff = config('outbox.backoff_seconds');
            $message->forceFill([
                'attempts' => $attemptNo,
                'attempts_in_cycle' => $attemptInCycle,
                'status' => $deadLetter ? 'dead_letter' : 'pending',
                'available_at' => now()->addSeconds((int) ($backoff[min($attemptNo - 1, count($backoff) - 1)] ?? 300)),
                'claimed_at' => null,
                'dead_lettered_at' => $deadLetter ? now() : null,
                'last_error_code' => $errorCode,
                'last_error_message' => $errorMessage,
            ])->save();
            Log::warning('Outbox message processing failed.', array_filter([
                'request_id' => $message->request_id,
                'outbox_message_id' => $message->id,
                'event_type' => $message->event_type,
                'attempt_no' => $attemptNo,
                'error_code' => $errorCode,
                'dead_letter' => $deadLetter,
            ]));
        });
    }
}
