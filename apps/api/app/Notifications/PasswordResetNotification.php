<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class PasswordResetNotification extends Notification
{
    use Queueable;

    public function __construct(public readonly string $token) {}

    /** @return list<string> */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        $query = http_build_query(['token' => $this->token, 'email' => $notifiable->email]);
        $url = rtrim((string) config('app.frontend_url'), '/').'/reset-password?'.$query;
        $minutes = (int) config('auth.passwords.users.expire');

        return (new MailMessage)
            ->subject('Reset password Rajawali Platform')
            ->greeting('Halo '.$notifiable->name.',')
            ->line('Kami menerima permintaan reset password untuk akun Anda.')
            ->action('Reset password', $url)
            ->line("Link ini berlaku selama {$minutes} menit dan hanya dapat digunakan sekali.")
            ->line('Abaikan email ini bila Anda tidak meminta reset password.');
    }
}
