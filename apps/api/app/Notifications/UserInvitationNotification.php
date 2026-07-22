<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class UserInvitationNotification extends Notification
{
    use Queueable;

    public function __construct(
        public readonly string $token,
        public readonly string $companyName,
        public readonly string $expiresAt,
    ) {}

    /** @return list<string> */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        $url = rtrim((string) config('app.frontend_url', env('FRONTEND_URL')), '/')
            .'/invitations/accept?token='.urlencode($this->token);

        return (new MailMessage)
            ->subject('Undangan Rajawali Platform')
            ->greeting('Halo '.$notifiable->name.',')
            ->line('Anda diundang untuk mengakses '.$this->companyName.'.')
            ->action('Aktifkan akun', $url)
            ->line('Undangan ini berlaku sampai '.$this->expiresAt.'.')
            ->line('Abaikan email ini bila Anda tidak mengenali undangan tersebut.');
    }
}
