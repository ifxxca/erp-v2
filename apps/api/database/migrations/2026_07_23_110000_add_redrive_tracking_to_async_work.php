<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('outbox_messages', function (Blueprint $table): void {
            $table->unsignedSmallInteger('attempts_in_cycle')->default(0)->after('attempts');
            $table->unsignedSmallInteger('redrive_count')->default(0)->after('attempts_in_cycle');
            $table->timestampTz('last_redriven_at')->nullable()->after('dead_lettered_at');
        });
        Schema::table('notification_deliveries', function (Blueprint $table): void {
            $table->unsignedSmallInteger('attempts_in_cycle')->default(0)->after('attempts');
            $table->unsignedSmallInteger('redrive_count')->default(0)->after('attempts_in_cycle');
            $table->timestampTz('last_redriven_at')->nullable()->after('dead_lettered_at');
        });
    }

    public function down(): void
    {
        Schema::table('notification_deliveries', function (Blueprint $table): void {
            $table->dropColumn(['attempts_in_cycle', 'redrive_count', 'last_redriven_at']);
        });
        Schema::table('outbox_messages', function (Blueprint $table): void {
            $table->dropColumn(['attempts_in_cycle', 'redrive_count', 'last_redriven_at']);
        });
    }
};
