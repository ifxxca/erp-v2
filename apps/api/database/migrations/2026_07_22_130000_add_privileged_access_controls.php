<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('user_location_memberships', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->foreignUlid('user_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('company_id')->constrained()->restrictOnDelete();
            $table->foreignUlid('location_id')->constrained()->restrictOnDelete();
            $table->date('valid_from');
            $table->date('valid_until')->nullable();
            $table->timestamps();
            $table->unique(['user_id', 'location_id', 'valid_from']);
            $table->index(['user_id', 'company_id', 'valid_until']);
        });

        Schema::table('personal_access_tokens', function (Blueprint $table) {
            $table->timestamp('mfa_verified_at')->nullable()->after('last_used_at')->index();
        });

        Schema::table('access_requests', function (Blueprint $table) {
            $table->index(['company_id', 'status', 'created_at'], 'access_request_company_queue');
        });
    }

    public function down(): void
    {
        Schema::table('access_requests', function (Blueprint $table) {
            $table->dropIndex('access_request_company_queue');
        });

        Schema::table('personal_access_tokens', function (Blueprint $table) {
            $table->dropColumn('mfa_verified_at');
        });

        Schema::dropIfExists('user_location_memberships');
    }
};
