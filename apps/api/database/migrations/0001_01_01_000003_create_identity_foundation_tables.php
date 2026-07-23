<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('companies', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->string('code', 32)->unique();
            $table->string('legal_name')->unique();
            $table->string('tax_identifier')->nullable();
            $table->enum('status', ['active', 'inactive'])->default('active')->index();
            $table->timestamps();
        });

        Schema::create('departments', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->ulid('parent_id')->nullable();
            $table->string('code', 64);
            $table->string('name');
            $table->enum('status', ['active', 'inactive'])->default('active')->index();
            $table->timestamps();
            $table->unique(['company_id', 'code']);
        });

        Schema::table('departments', function (Blueprint $table) {
            $table->foreign('parent_id')->references('id')->on('departments')->restrictOnDelete();
        });

        Schema::create('locations', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->string('code', 64);
            $table->string('name');
            $table->text('address')->nullable();
            $table->string('timezone', 64)->default('Asia/Jakarta');
            $table->enum('status', ['active', 'inactive'])->default('active')->index();
            $table->timestamps();
            $table->unique(['company_id', 'code']);
        });

        Schema::create('user_company_memberships', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->foreignUlid('user_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->string('employee_no', 64)->nullable();
            $table->enum('employment_status', ['invited', 'active', 'leave', 'terminated'])->default('invited')->index();
            $table->boolean('is_primary')->default(false);
            $table->date('valid_from');
            $table->date('valid_until')->nullable();
            $table->timestamps();
            $table->unique(['company_id', 'employee_no']);
            $table->index(['user_id', 'company_id', 'valid_until']);
        });

        Schema::create('user_department_memberships', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->foreignUlid('user_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('department_id')->constrained()->restrictOnDelete();
            $table->boolean('is_primary')->default(false);
            $table->date('valid_from');
            $table->date('valid_until')->nullable();
            $table->timestamps();
            $table->index(['user_id', 'company_id', 'valid_until']);
        });

        Schema::create('roles', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->string('code', 128)->unique();
            $table->string('name');
            $table->text('description')->nullable();
            $table->boolean('is_system')->default(false);
            $table->boolean('is_privileged')->default(false)->index();
            $table->timestamps();
        });

        Schema::create('permissions', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->string('code', 191)->unique();
            $table->string('module', 64)->index();
            $table->string('resource', 64);
            $table->string('action', 64);
            $table->text('description')->nullable();
            $table->timestamps();
        });

        Schema::create('role_permissions', function (Blueprint $table) {
            $table->foreignUlid('role_id')->constrained()->cascadeOnDelete();
            $table->foreignUlid('permission_id')->constrained()->cascadeOnDelete();
            $table->primary(['role_id', 'permission_id']);
        });

        Schema::create('access_requests', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->foreignUlid('target_user_id')->constrained('users')->restrictOnDelete();
            $table->foreignUlid('role_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('company_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignUlid('department_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignUlid('location_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignUlid('requested_by')->constrained('users')->restrictOnDelete();
            $table->foreignUlid('decided_by')->nullable()->constrained('users')->restrictOnDelete();
            $table->enum('status', ['pending', 'approved', 'rejected', 'cancelled'])->default('pending')->index();
            $table->text('reason');
            $table->timestamp('requested_valid_until')->nullable();
            $table->timestamp('decided_at')->nullable();
            $table->text('decision_note')->nullable();
            $table->timestamps();
        });

        Schema::create('user_role_assignments', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->foreignUlid('user_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('role_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('company_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignUlid('department_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignUlid('location_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignUlid('access_request_id')->nullable()->unique()->constrained()->restrictOnDelete();
            $table->timestamp('valid_from');
            $table->timestamp('valid_until')->nullable();
            $table->foreignUlid('assigned_by')->constrained('users')->restrictOnDelete();
            $table->timestamp('revoked_at')->nullable();
            $table->foreignUlid('revoked_by')->nullable()->constrained('users')->restrictOnDelete();
            $table->text('revocation_reason')->nullable();
            $table->timestamps();
            $table->index(['user_id', 'company_id', 'valid_until', 'revoked_at'], 'role_assignment_active_lookup');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('user_role_assignments');
        Schema::dropIfExists('access_requests');
        Schema::dropIfExists('role_permissions');
        Schema::dropIfExists('permissions');
        Schema::dropIfExists('roles');
        Schema::dropIfExists('user_department_memberships');
        Schema::dropIfExists('user_company_memberships');
        Schema::dropIfExists('locations');
        Schema::dropIfExists('departments');
        Schema::dropIfExists('companies');
    }
};
