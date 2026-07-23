<?php

namespace App\Console\Commands;

use App\Modules\Observability\Application\DeadLetterRedriveException;
use App\Modules\Observability\Application\DeadLetterRedriveService;
use Illuminate\Console\Command;

class RedriveNotificationDelivery extends Command
{
    protected $signature = 'notifications:redrive-delivery {delivery : Dead-lettered delivery ULID}
        {--reason= : Required operational reason}
        {--operator= : Operator/ticket identity; defaults to the OS user}';

    protected $description = 'Safely re-drive one dead-lettered notification delivery';

    public function handle(DeadLetterRedriveService $redrive): int
    {
        try {
            $delivery = $redrive->delivery(
                (string) $this->argument('delivery'),
                (string) $this->option('reason'),
                (string) ($this->option('operator') ?: get_current_user()),
            );
        } catch (DeadLetterRedriveException $exception) {
            $this->error("{$exception->errorCode}: {$exception->getMessage()}");

            return self::FAILURE;
        }

        $this->info("Notification delivery {$delivery->id} queued for re-drive cycle {$delivery->redrive_count}.");

        return self::SUCCESS;
    }
}
