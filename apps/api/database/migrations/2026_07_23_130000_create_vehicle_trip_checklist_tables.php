<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('checklist_templates', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->string('code', 64);
            $table->string('name');
            $table->unsignedSmallInteger('version');
            $table->enum('status', ['draft', 'active', 'retired'])->default('draft')->index();
            $table->timestampsTz();
            $table->unique(['company_id', 'code', 'version']);
        });

        Schema::create('checklist_template_items', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('checklist_template_id')->constrained()->cascadeOnDelete();
            $table->unsignedSmallInteger('line_number');
            $table->string('code', 64);
            $table->string('label');
            $table->boolean('is_required')->default(true);
            $table->boolean('is_critical')->default(false);
            $table->timestampsTz();
            $table->unique(['checklist_template_id', 'line_number']);
            $table->unique(['checklist_template_id', 'code']);
        });

        Schema::create('vehicle_trips', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('location_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('vehicle_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('driver_id')->constrained('users')->restrictOnDelete();
            $table->enum('status', ['active', 'completed', 'cancelled'])->default('active')->index();
            $table->string('purpose');
            $table->string('destination')->nullable();
            $table->unsignedBigInteger('start_odometer');
            $table->unsignedBigInteger('end_odometer')->nullable();
            $table->timestampTz('departed_at');
            $table->timestampTz('arrived_at')->nullable();
            $table->timestampTz('cancelled_at')->nullable();
            $table->text('completion_note')->nullable();
            $table->text('cancel_reason')->nullable();
            // These nullable keys provide portable partial uniqueness on PostgreSQL and SQLite.
            $table->ulid('active_vehicle_key')->nullable()->unique();
            $table->ulid('active_driver_key')->nullable()->unique();
            $table->timestampsTz();
            $table->index(['company_id', 'location_id', 'status']);
            $table->index(['driver_id', 'departed_at']);
        });

        Schema::create('checklist_submissions', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('vehicle_trip_id')->unique()->constrained()->restrictOnDelete();
            $table->foreignUlid('checklist_template_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('submitted_by')->constrained('users')->restrictOnDelete();
            $table->timestampTz('submitted_at');
            $table->timestampsTz();
        });

        Schema::create('checklist_answers', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('checklist_submission_id')->constrained()->cascadeOnDelete();
            $table->foreignUlid('checklist_template_item_id')->constrained()->restrictOnDelete();
            $table->enum('result', ['pass', 'fail', 'not_applicable']);
            $table->text('note')->nullable();
            $table->timestampsTz();
            $table->unique(['checklist_submission_id', 'checklist_template_item_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('checklist_answers');
        Schema::dropIfExists('checklist_submissions');
        Schema::dropIfExists('vehicle_trips');
        Schema::dropIfExists('checklist_template_items');
        Schema::dropIfExists('checklist_templates');
    }
};
