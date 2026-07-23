<?php

use App\Models\FileAsset;
use App\Modules\Identity\Application\AuditLogger;
use App\Modules\Outbox\Application\OutboxDispatcher;
use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schedule;
use Illuminate\Support\Facades\Storage;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

Schedule::call(fn () => DB::table('idempotency_keys')->where('expires_at', '<', now())->delete())
    ->dailyAt('02:30')
    ->name('request-control:purge-expired-idempotency-keys')
    ->withoutOverlapping();

$expireAbandonedFiles = function (): void {
    FileAsset::query()
        ->where(function ($query): void {
            $query->whereIn('status', ['pending', 'uploaded'])
                ->orWhere(function ($query): void {
                    $query->where('status', 'ready')
                        ->where('purpose', 'checklist_evidence')
                        ->whereNull('attached_id');
                });
        })
        ->where('pending_expires_at', '<', now())
        ->chunkById(100, function ($files): void {
            foreach ($files as $file) {
                $storage = Storage::disk($file->disk);
                if (! $storage->delete($file->object_key) && $storage->exists($file->object_key)) {
                    continue;
                }
                DB::transaction(function () use ($file): void {
                    $file->forceFill(['status' => 'expired'])->save();
                    app(AuditLogger::class)->record('file.expired', null, $file, [
                        'company_id' => $file->company_id,
                        'initiated_by' => $file->created_by,
                    ]);
                });
            }
        });
};

Artisan::command('files:expire-abandoned', function () use ($expireAbandonedFiles): void {
    $expireAbandonedFiles();
})->purpose('Expire abandoned file uploads and preserve their audit evidence.');

Schedule::command('files:expire-abandoned')->hourly()
    ->name('files:expire-abandoned-uploads')
    ->withoutOverlapping();

$outboxDispatch = Schedule::call(fn () => app(OutboxDispatcher::class)->dispatchPending());
if (app()->environment('testing')) {
    $outboxDispatch->everyMinute();
} else {
    $outboxDispatch->everyTenSeconds();
}
$outboxDispatch->name('outbox:dispatch-pending')->withoutOverlapping();

Schedule::command('observability:check')
    ->everyMinute()
    ->name('observability:check')
    ->withoutOverlapping();
