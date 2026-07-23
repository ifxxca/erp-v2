<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('vehicle_types', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->string('code', 64);
            $table->string('name');
            $table->enum('status', ['active', 'inactive'])->default('active')->index();
            $table->timestampsTz();
            $table->unique(['company_id', 'code']);
        });

        Schema::create('vehicles', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('location_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('vehicle_type_id')->constrained()->restrictOnDelete();
            $table->string('code', 64);
            $table->string('plate_number', 32);
            $table->string('brand', 100);
            $table->string('model', 100);
            $table->unsignedSmallInteger('model_year')->nullable();
            $table->enum('ownership_type', ['owned', 'leased', 'vendor'])->default('owned');
            $table->string('provider_name')->nullable();
            $table->unsignedBigInteger('current_odometer')->default(0);
            $table->enum('operational_status', ['available', 'in_use', 'maintenance', 'blocked', 'inactive'])
                ->default('available')->index();
            $table->text('status_reason')->nullable();
            $table->string('legacy_source_id', 100)->nullable();
            $table->foreignUlid('created_by')->constrained('users')->restrictOnDelete();
            $table->timestampsTz();
            $table->unique(['company_id', 'code']);
            $table->unique(['company_id', 'plate_number']);
            $table->index(['company_id', 'location_id', 'operational_status']);
        });

        Schema::create('vehicle_status_histories', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('vehicle_id')->constrained()->restrictOnDelete();
            $table->string('from_status', 32)->nullable();
            $table->string('to_status', 32);
            $table->text('reason')->nullable();
            $table->foreignUlid('changed_by')->constrained('users')->restrictOnDelete();
            $table->timestampTz('changed_at');
            $table->timestampsTz();
            $table->index(['vehicle_id', 'changed_at']);
        });

        Schema::create('maintenance_work_orders', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('location_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('vehicle_id')->constrained()->restrictOnDelete();
            $table->string('document_number', 191)->nullable();
            $table->date('work_order_date');
            $table->enum('priority', ['low', 'normal', 'high', 'urgent'])->default('normal');
            $table->enum('status', ['draft', 'scheduled', 'in_progress', 'completed', 'cancelled'])
                ->default('draft')->index();
            $table->text('problem_description');
            $table->text('completion_note')->nullable();
            $table->decimal('labor_cost', 18, 2)->default(0);
            $table->decimal('parts_cost', 18, 2)->default(0);
            $table->decimal('total_cost', 18, 2)->default(0);
            $table->foreignUlid('created_by')->constrained('users')->restrictOnDelete();
            $table->foreignUlid('completed_by')->nullable()->constrained('users')->restrictOnDelete();
            $table->timestampTz('scheduled_at')->nullable();
            $table->timestampTz('started_at')->nullable();
            $table->timestampTz('completed_at')->nullable();
            $table->timestampTz('cancelled_at')->nullable();
            $table->timestampsTz();
            $table->unique(['company_id', 'document_number']);
            $table->index(['company_id', 'location_id', 'status']);
            $table->index(['vehicle_id', 'status']);
        });

        Schema::create('maintenance_work_order_jobs', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('work_order_id')->constrained('maintenance_work_orders')->cascadeOnDelete();
            $table->unsignedSmallInteger('line_number');
            $table->string('description');
            $table->enum('status', ['pending', 'in_progress', 'completed', 'cancelled'])->default('pending');
            $table->decimal('labor_cost', 18, 2)->default(0);
            $table->text('note')->nullable();
            $table->timestampsTz();
            $table->unique(['work_order_id', 'line_number']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('maintenance_work_order_jobs');
        Schema::dropIfExists('maintenance_work_orders');
        Schema::dropIfExists('vehicle_status_histories');
        Schema::dropIfExists('vehicles');
        Schema::dropIfExists('vehicle_types');
    }
};
