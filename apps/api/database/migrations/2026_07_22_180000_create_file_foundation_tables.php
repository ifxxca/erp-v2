<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('files', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('created_by')->constrained('users')->restrictOnDelete();
            $table->string('purpose', 64)->index();
            $table->string('original_name');
            $table->string('disk', 64);
            $table->string('object_key', 512)->unique();
            $table->string('declared_mime_type', 128);
            $table->string('detected_mime_type', 128)->nullable();
            $table->unsignedBigInteger('expected_size');
            $table->unsignedBigInteger('actual_size')->nullable();
            $table->char('expected_checksum_sha256', 64);
            $table->char('actual_checksum_sha256', 64)->nullable();
            $table->string('status', 24)->default('pending')->index();
            $table->string('scan_status', 24)->default('not_started')->index();
            $table->text('rejection_reason')->nullable();
            $table->string('attached_type')->nullable();
            $table->ulid('attached_id')->nullable();
            $table->timestampTz('attached_at')->nullable();
            $table->timestampTz('pending_expires_at')->index();
            $table->timestampTz('retention_until')->nullable()->index();
            $table->timestampTz('uploaded_at')->nullable();
            $table->timestampTz('finalized_at')->nullable();
            $table->timestampTz('deleted_at')->nullable()->index();
            $table->foreignUlid('deleted_by')->nullable()->constrained('users')->restrictOnDelete();
            $table->timestampsTz();

            $table->index(['company_id', 'status', 'created_at']);
            $table->index(['attached_type', 'attached_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('files');
    }
};
