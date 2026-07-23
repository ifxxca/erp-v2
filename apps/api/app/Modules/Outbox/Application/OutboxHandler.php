<?php

namespace App\Modules\Outbox\Application;

use App\Models\OutboxMessage;

interface OutboxHandler
{
    public function handle(OutboxMessage $message): void;
}
