<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class PlatformMessageNotification extends Notification
{
    use Queueable;

    public function __construct(
        public readonly string $title,
        public readonly string $body,
        public readonly ?string $actionUrl = null,
    ) {}

    /** @return list<string> */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        $message = (new MailMessage)
            ->subject($this->title)
            ->greeting('Halo '.$notifiable->name.',')
            ->line($this->body);

        if ($this->actionUrl !== null) {
            $message->action('Buka Rajawali Platform', rtrim(config('app.frontend_url'), '/').$this->actionUrl);
        }

        return $message;
    }
}
