<?php

use App\Models\FileAsset;
use App\Modules\Identity\Application\AuditLogger;
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

Schedule::call(function (): void {
    FileAsset::query()
        ->whereIn('status', ['pending', 'uploaded'])
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
})->hourly()
    ->name('files:expire-abandoned-uploads')
    ->withoutOverlapping();
