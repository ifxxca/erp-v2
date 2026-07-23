<?php

namespace App\Modules\Notifications\Application;

use App\Models\NotificationDelivery;

interface NotificationChannelSender
{
    public function send(NotificationDelivery $delivery): ?string;
}
