<?php

namespace App\Console\Commands;

use App\Modules\Observability\Application\DeadLetterRedriveException;
use App\Modules\Observability\Application\DeadLetterRedriveService;
use Illuminate\Console\Command;

class RedriveOutboxMessage extends Command
{
    protected $signature = 'outbox:redrive {message : Dead-lettered outbox ULID}
        {--reason= : Required operational reason}
        {--operator= : Operator/ticket identity; defaults to the OS user}';

    protected $description = 'Safely re-drive one dead-lettered outbox message';

    public function handle(DeadLetterRedriveService $redrive): int
    {
        try {
            $message = $redrive->outbox(
                (string) $this->argument('message'),
                (string) $this->option('reason'),
                (string) ($this->option('operator') ?: get_current_user()),
            );
        } catch (DeadLetterRedriveException $exception) {
            $this->error("{$exception->errorCode}: {$exception->getMessage()}");

            return self::FAILURE;
        }

        $this->info("Outbox message {$message->id} queued for re-drive cycle {$message->redrive_count}.");

        return self::SUCCESS;
    }
}
