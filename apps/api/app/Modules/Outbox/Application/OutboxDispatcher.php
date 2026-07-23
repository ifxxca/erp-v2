<?php

namespace App\Modules\Outbox\Application;

use App\Jobs\DeliverPlatformNotification;
use App\Jobs\ProcessOutboxMessage;
use App\Models\NotificationDelivery;
use App\Models\OutboxMessage;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\DB;

class OutboxDispatcher
{
    /** @return array{outbox:int,deliveries:int} */
    public function dispatchPending(): array
    {
        $outboxIds = DB::transaction(function () {
            $messages = OutboxMessage::query()
                ->where(function (Builder $query): void {
                    $query->where(fn (Builder $query) => $query
                        ->where('status', 'pending')
                        ->where('available_at', '<=', now()))
                        ->orWhere(fn (Builder $query) => $query
                            ->where('status', 'processing')
                            ->where('claimed_at', '<=', now()->subMinutes(
                                (int) config('outbox.processing_timeout_minutes'),
                            )));
                })
                ->orderBy('occurred_at')
                ->limit((int) config('outbox.batch_size'))
                ->lockForUpdate()
                ->get();
            foreach ($messages as $message) {
                $message->forceFill(['status' => 'processing', 'claimed_at' => now()])->save();
            }

            return $messages->modelKeys();
        });

        $deliveryIds = DB::transaction(function () {
            $deliveries = NotificationDelivery::query()
                ->where(function (Builder $query): void {
                    $query->where(fn (Builder $query) => $query
                        ->where('status', 'pending')
                        ->where('available_at', '<=', now()))
                        ->orWhere(fn (Builder $query) => $query
                            ->where('status', 'processing')
                            ->where('claimed_at', '<=', now()->subMinutes(
                                (int) config('outbox.processing_timeout_minutes'),
                            )));
                })
                ->where('channel', '!=', 'inbox')
                ->orderBy('created_at')
                ->limit((int) config('outbox.batch_size'))
                ->lockForUpdate()
                ->get();
            foreach ($deliveries as $delivery) {
                $delivery->forceFill(['status' => 'processing', 'claimed_at' => now()])->save();
            }

            return $deliveries->modelKeys();
        });

        foreach ($outboxIds as $id) {
            ProcessOutboxMessage::dispatch($id);
        }
        foreach ($deliveryIds as $id) {
            DeliverPlatformNotification::dispatch($id);
        }

        return ['outbox' => count($outboxIds), 'deliveries' => count($deliveryIds)];
    }
}
