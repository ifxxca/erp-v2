<?php

namespace App\Console\Commands;

use App\Modules\Observability\Application\OperationalMetrics;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;

class CheckOperationalHealth extends Command
{
    protected $signature = 'observability:check';

    protected $description = 'Evaluate alert thresholds for asynchronous platform controls';

    public function handle(OperationalMetrics $metrics): int
    {
        $snapshot = $metrics->snapshot();
        $alerts = $metrics->alerts($snapshot);
        foreach ($alerts as $alert) {
            $context = $alert + ['metrics' => $snapshot];
            if ($alert['severity'] === 'critical') {
                Log::critical('Operational threshold breached.', $context);
            } else {
                Log::warning('Operational threshold breached.', $context);
            }
            $this->warn(sprintf(
                '%s: %d (threshold %d)',
                $alert['code'],
                $alert['value'],
                $alert['threshold'],
            ));
        }
        if ($alerts === []) {
            $this->info('Operational thresholds are healthy.');
        }

        return collect($alerts)->contains('severity', 'critical') ? self::FAILURE : self::SUCCESS;
    }
}
