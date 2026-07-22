<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('user_invitations', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->foreignUlid('user_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('invited_by')->constrained('users')->restrictOnDelete();
            $table->char('token_hash', 64)->unique();
            $table->timestamp('expires_at')->index();
            $table->timestamp('accepted_at')->nullable();
            $table->timestamps();
        });

        Schema::create('audit_logs', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->foreignUlid('actor_user_id')->nullable()->constrained('users')->nullOnDelete();
            $table->string('event', 128)->index();
            $table->string('subject_type', 128)->nullable();
            $table->string('subject_id', 64)->nullable();
            $table->string('request_id', 128)->nullable()->index();
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->json('metadata');
            $table->timestamp('occurred_at')->index();
            $table->timestamp('created_at')->useCurrent();
            $table->index(['subject_type', 'subject_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('audit_logs');
        Schema::dropIfExists('user_invitations');
    }
};
