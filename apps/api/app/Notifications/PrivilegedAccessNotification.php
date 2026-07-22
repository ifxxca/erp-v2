<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class PrivilegedAccessNotification extends Notification
{
    use Queueable;

    public function __construct(
        public readonly string $event,
        public readonly string $roleName,
        public readonly string $companyName,
        public readonly string $targetName,
        public readonly ?string $note = null,
    ) {}

    /** @return list<string> */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        $message = (new MailMessage)
            ->subject('Perubahan privileged access')
            ->greeting('Halo '.$notifiable->name.',')
            ->line("Status privileged access: {$this->event}.")
            ->line("User: {$this->targetName}")
            ->line("Role: {$this->roleName}")
            ->line("Company: {$this->companyName}");

        if ($this->note) {
            $message->line('Catatan: '.$this->note);
        }

        return $message->line('Periksa Rajawali Platform bila Anda tidak mengenali perubahan ini.');
    }
}
