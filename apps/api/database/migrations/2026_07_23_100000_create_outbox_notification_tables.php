<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('outbox_messages', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('company_id')->nullable()->constrained()->restrictOnDelete();
            $table->string('event_type', 100)->index();
            $table->string('aggregate_type', 100);
            $table->string('aggregate_id', 64)->nullable();
            $table->char('deduplication_key_hash', 64)->unique();
            $table->char('payload_fingerprint', 64);
            $table->json('payload');
            $table->json('headers')->nullable();
            $table->string('request_id', 128)->nullable()->index();
            $table->string('status', 24)->default('pending')->index();
            $table->unsignedSmallInteger('attempts')->default(0);
            $table->timestampTz('available_at')->index();
            $table->timestampTz('claimed_at')->nullable()->index();
            $table->timestampTz('processed_at')->nullable();
            $table->timestampTz('dead_lettered_at')->nullable();
            $table->string('last_error_code', 100)->nullable();
            $table->text('last_error_message')->nullable();
            $table->timestampTz('occurred_at');
            $table->timestampsTz();

            $table->index(['status', 'available_at', 'claimed_at'], 'outbox_dispatch_lookup');
        });

        Schema::create('outbox_attempts', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('outbox_message_id')->constrained()->cascadeOnDelete();
            $table->unsignedSmallInteger('attempt_no');
            $table->string('status', 24);
            $table->string('worker_id', 128)->nullable();
            $table->timestampTz('started_at');
            $table->timestampTz('finished_at')->nullable();
            $table->string('error_code', 100)->nullable();
            $table->text('error_message')->nullable();
            $table->timestampsTz();

            $table->unique(['outbox_message_id', 'attempt_no']);
        });

        Schema::create('notifications', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('company_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignUlid('user_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('source_outbox_id')->constrained('outbox_messages')->restrictOnDelete();
            $table->string('kind', 100)->index();
            $table->string('title', 160);
            $table->text('body');
            $table->json('data')->nullable();
            $table->string('action_url', 512)->nullable();
            $table->timestampTz('read_at')->nullable()->index();
            $table->timestampsTz();

            $table->unique(['source_outbox_id', 'user_id']);
            $table->index(['user_id', 'created_at']);
        });

        Schema::create('notification_deliveries', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('notification_id')->constrained()->cascadeOnDelete();
            $table->string('channel', 24);
            $table->string('status', 24)->default('pending')->index();
            $table->unsignedSmallInteger('attempts')->default(0);
            $table->timestampTz('available_at')->index();
            $table->timestampTz('claimed_at')->nullable()->index();
            $table->timestampTz('delivered_at')->nullable();
            $table->timestampTz('dead_lettered_at')->nullable();
            $table->string('provider_message_id', 191)->nullable();
            $table->string('last_error_code', 100)->nullable();
            $table->text('last_error_message')->nullable();
            $table->timestampsTz();

            $table->unique(['notification_id', 'channel']);
            $table->index(['status', 'available_at', 'claimed_at'], 'notification_delivery_dispatch_lookup');
        });

        Schema::create('notification_delivery_attempts', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('notification_delivery_id')->constrained()->cascadeOnDelete();
            $table->unsignedSmallInteger('attempt_no');
            $table->string('status', 24);
            $table->timestampTz('started_at');
            $table->timestampTz('finished_at')->nullable();
            $table->string('error_code', 100)->nullable();
            $table->text('error_message')->nullable();
            $table->timestampsTz();

            $table->unique(['notification_delivery_id', 'attempt_no'], 'notification_delivery_attempt_unique');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('notification_delivery_attempts');
        Schema::dropIfExists('notification_deliveries');
        Schema::dropIfExists('notifications');
        Schema::dropIfExists('outbox_attempts');
        Schema::dropIfExists('outbox_messages');
    }
};
