<?php

namespace App\Modules\Notifications\Infrastructure;

use App\Models\NotificationDelivery;
use App\Modules\Notifications\Application\NotificationChannelSender;
use App\Modules\Outbox\Application\PermanentOutboxFailure;
use App\Notifications\PlatformMessageNotification;

class LaravelNotificationChannelSender implements NotificationChannelSender
{
    public function send(NotificationDelivery $delivery): ?string
    {
        $delivery->loadMissing('notification.user');
        if ($delivery->channel !== 'mail') {
            throw new PermanentOutboxFailure(
                "Notification channel {$delivery->channel} is unsupported.",
                'NOTIFICATION_CHANNEL_UNSUPPORTED',
            );
        }

        $notification = $delivery->notification;
        $notification->user->notify(new PlatformMessageNotification(
            $notification->title,
            $notification->body,
            $notification->action_url,
        ));

        return null;
    }
}
