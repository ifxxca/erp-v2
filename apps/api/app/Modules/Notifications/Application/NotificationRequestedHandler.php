<?php

namespace App\Modules\Notifications\Application;

use App\Models\NotificationDelivery;
use App\Models\NotificationDeliveryAttempt;
use App\Models\OutboxMessage;
use App\Models\PlatformNotification;
use App\Models\User;
use App\Modules\Outbox\Application\OutboxHandler;
use App\Modules\Outbox\Application\PermanentOutboxFailure;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class NotificationRequestedHandler implements OutboxHandler
{
    public function handle(OutboxMessage $message): void
    {
        $validator = Validator::make($message->payload, [
            'recipient_user_ids' => ['required', 'array', 'min:1', 'max:100'],
            'recipient_user_ids.*' => ['required', 'ulid', 'distinct'],
            'kind' => ['required', 'string', 'regex:/^[a-z][a-z0-9_.-]{2,99}$/'],
            'title' => ['required', 'string', 'max:160'],
            'body' => ['required', 'string', 'max:2000'],
            'data' => ['sometimes', 'array'],
            'action_url' => ['nullable', 'string', 'max:512', 'regex:/^\/(?!\/)/'],
            'channels' => ['required', 'array', 'min:1'],
            'channels.*' => ['required', 'string', 'distinct', Rule::in(['inbox', 'mail'])],
        ]);
        if ($validator->fails()) {
            throw new PermanentOutboxFailure(
                'Notification payload failed schema validation.',
                'NOTIFICATION_PAYLOAD_INVALID',
            );
        }
        $payload = $validator->validated();
        $recipientIds = array_values($payload['recipient_user_ids']);
        $users = User::query()->whereKey($recipientIds)->get()->keyBy('id');
        if ($users->count() !== count($recipientIds)) {
            throw new PermanentOutboxFailure(
                'One or more notification recipients do not exist.',
                'NOTIFICATION_RECIPIENT_NOT_FOUND',
            );
        }

        foreach ($recipientIds as $recipientId) {
            $notification = PlatformNotification::query()->firstOrCreate(
                ['source_outbox_id' => $message->id, 'user_id' => $recipientId],
                [
                    'company_id' => $message->company_id,
                    'kind' => $payload['kind'],
                    'title' => $payload['title'],
                    'body' => $payload['body'],
                    'data' => $payload['data'] ?? [],
                    'action_url' => $payload['action_url'] ?? null,
                ],
            );
            foreach ($payload['channels'] as $channel) {
                $isInbox = $channel === 'inbox';
                $delivery = NotificationDelivery::query()->firstOrCreate(
                    ['notification_id' => $notification->id, 'channel' => $channel],
                    [
                        'status' => $isInbox ? 'delivered' : 'pending',
                        'attempts' => $isInbox ? 1 : 0,
                        'attempts_in_cycle' => $isInbox ? 1 : 0,
                        'available_at' => now(),
                        'delivered_at' => $isInbox ? now() : null,
                    ],
                );
                if ($isInbox) {
                    NotificationDeliveryAttempt::query()->firstOrCreate(
                        ['notification_delivery_id' => $delivery->id, 'attempt_no' => 1],
                        ['status' => 'succeeded', 'started_at' => now(), 'finished_at' => now()],
                    );
                }
            }
        }
    }
}
