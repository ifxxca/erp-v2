<?php

namespace App\Modules\Observability\Application;

use App\Models\NotificationDelivery;
use App\Models\OutboxMessage;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class OperationalMetrics
{
    /** @return array<string, int> */
    public function snapshot(): array
    {
        return [
            'outbox_pending' => $this->outboxCount('pending'),
            'outbox_processing' => $this->outboxCount('processing'),
            'outbox_dead_letter' => $this->outboxCount('dead_letter'),
            'outbox_oldest_pending_seconds' => $this->oldestSeconds(
                OutboxMessage::query()->where('status', 'pending'),
                'occurred_at',
            ),
            'delivery_pending' => $this->deliveryCount('pending'),
            'delivery_processing' => $this->deliveryCount('processing'),
            'delivery_dead_letter' => $this->deliveryCount('dead_letter'),
            'delivery_oldest_pending_seconds' => $this->oldestSeconds(
                NotificationDelivery::query()->where('status', 'pending'),
                'created_at',
            ),
            'queue_jobs' => Schema::hasTable('jobs') ? DB::table('jobs')->count() : 0,
            'queue_failed_jobs' => Schema::hasTable('failed_jobs') ? DB::table('failed_jobs')->count() : 0,
            'access_requests_pending' => Schema::hasTable('access_requests')
                ? DB::table('access_requests')->where('status', 'pending')->count()
                : 0,
            'files_quarantined' => Schema::hasTable('files')
                ? DB::table('files')->where('status', 'quarantined')->count()
                : 0,
        ];
    }

    /** @return list<array{code:string,severity:string,value:int,threshold:int}> */
    public function alerts(?array $snapshot = null): array
    {
        $snapshot ??= $this->snapshot();
        $rules = [
            'outbox_pending_count' => ['outbox_pending', 'warning'],
            'outbox_oldest_seconds' => ['outbox_oldest_pending_seconds', 'warning'],
            'outbox_dead_letter_count' => ['outbox_dead_letter', 'critical'],
            'delivery_pending_count' => ['delivery_pending', 'warning'],
            'delivery_oldest_seconds' => ['delivery_oldest_pending_seconds', 'warning'],
            'delivery_dead_letter_count' => ['delivery_dead_letter', 'critical'],
            'failed_jobs_count' => ['queue_failed_jobs', 'critical'],
        ];
        $alerts = [];
        foreach ($rules as $code => [$metric, $severity]) {
            $threshold = (int) config("observability.thresholds.{$code}");
            if ($threshold > 0 && $snapshot[$metric] >= $threshold) {
                $alerts[] = compact('code', 'severity') + [
                    'value' => $snapshot[$metric],
                    'threshold' => $threshold,
                ];
            }
        }

        return $alerts;
    }

    public function prometheus(): string
    {
        $metrics = $this->snapshot();
        $lines = [
            '# HELP rajawali_outbox_messages Current outbox messages by status.',
            '# TYPE rajawali_outbox_messages gauge',
            'rajawali_outbox_messages{status="pending"} '.$metrics['outbox_pending'],
            'rajawali_outbox_messages{status="processing"} '.$metrics['outbox_processing'],
            'rajawali_outbox_messages{status="dead_letter"} '.$metrics['outbox_dead_letter'],
            '# HELP rajawali_outbox_oldest_pending_seconds Age of the oldest pending outbox message.',
            '# TYPE rajawali_outbox_oldest_pending_seconds gauge',
            'rajawali_outbox_oldest_pending_seconds '.$metrics['outbox_oldest_pending_seconds'],
            '# HELP rajawali_notification_deliveries Current notification deliveries by status.',
            '# TYPE rajawali_notification_deliveries gauge',
            'rajawali_notification_deliveries{status="pending"} '.$metrics['delivery_pending'],
            'rajawali_notification_deliveries{status="processing"} '.$metrics['delivery_processing'],
            'rajawali_notification_deliveries{status="dead_letter"} '.$metrics['delivery_dead_letter'],
            '# HELP rajawali_notification_delivery_oldest_pending_seconds Age of the oldest pending delivery.',
            '# TYPE rajawali_notification_delivery_oldest_pending_seconds gauge',
            'rajawali_notification_delivery_oldest_pending_seconds '.$metrics['delivery_oldest_pending_seconds'],
            '# HELP rajawali_queue_jobs Current queued and failed jobs.',
            '# TYPE rajawali_queue_jobs gauge',
            'rajawali_queue_jobs{status="queued"} '.$metrics['queue_jobs'],
            'rajawali_queue_jobs{status="failed"} '.$metrics['queue_failed_jobs'],
            '# HELP rajawali_access_requests_pending Current pending privileged access requests.',
            '# TYPE rajawali_access_requests_pending gauge',
            'rajawali_access_requests_pending '.$metrics['access_requests_pending'],
            '# HELP rajawali_files_quarantined Current files awaiting a malware-scan decision.',
            '# TYPE rajawali_files_quarantined gauge',
            'rajawali_files_quarantined '.$metrics['files_quarantined'],
        ];

        return implode("\n", $lines)."\n";
    }

    private function outboxCount(string $status): int
    {
        return OutboxMessage::query()->where('status', $status)->count();
    }

    private function deliveryCount(string $status): int
    {
        return NotificationDelivery::query()->where('status', $status)->count();
    }

    private function oldestSeconds(Builder $query, string $column): int
    {
        $oldest = $query->min($column);

        return $oldest ? max(0, (int) Carbon::parse($oldest)->diffInSeconds(now())) : 0;
    }
}
