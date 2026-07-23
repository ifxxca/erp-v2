<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('document_sequence_rules', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('location_id')->nullable()->constrained()->restrictOnDelete();
            $table->string('scope_key', 32);
            $table->string('document_type', 100);
            $table->string('type_code', 24);
            $table->unsignedSmallInteger('version');
            $table->string('pattern', 191);
            $table->string('period', 16);
            $table->unsignedTinyInteger('padding')->default(5);
            $table->string('timezone', 64)->default('Asia/Jakarta');
            $table->date('effective_from');
            $table->date('effective_until')->nullable();
            $table->timestampsTz();

            $table->unique(
                ['company_id', 'scope_key', 'document_type', 'version'],
                'document_sequence_rule_version_unique',
            );
            $table->index(
                ['company_id', 'scope_key', 'document_type', 'effective_from', 'effective_until'],
                'document_sequence_rule_lookup',
            );
        });

        Schema::create('document_sequences', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('rule_id')->constrained('document_sequence_rules')->restrictOnDelete();
            $table->string('period_key', 16);
            $table->unsignedBigInteger('last_value');
            $table->timestampsTz();

            $table->unique(['rule_id', 'period_key']);
        });

        Schema::create('document_number_allocations', function (Blueprint $table): void {
            $table->ulid('id')->primary();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('location_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignUlid('rule_id')->constrained('document_sequence_rules')->restrictOnDelete();
            $table->unsignedSmallInteger('rule_version');
            $table->string('document_type', 100);
            $table->string('subject_type', 100);
            $table->ulid('subject_id');
            $table->string('period_key', 16);
            $table->unsignedBigInteger('sequence_value');
            $table->string('document_number', 191);
            $table->date('document_date');
            $table->foreignUlid('allocated_by')->nullable()->constrained('users')->restrictOnDelete();
            $table->timestampTz('allocated_at');
            $table->timestampsTz();

            $table->unique(['company_id', 'document_number']);
            $table->unique(
                ['company_id', 'document_type', 'subject_type', 'subject_id'],
                'document_number_subject_unique',
            );
            $table->unique(
                ['rule_id', 'period_key', 'sequence_value'],
                'document_number_sequence_unique',
            );
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('document_number_allocations');
        Schema::dropIfExists('document_sequences');
        Schema::dropIfExists('document_sequence_rules');
    }
};
