<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('mobile_refresh_token_families', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->foreignUlid('user_id')->constrained()->restrictOnDelete();
            $table->string('device_name', 120);
            $table->timestamp('mfa_verified_at')->nullable();
            $table->timestamp('absolute_expires_at')->index();
            $table->timestamp('last_rotated_at')->nullable();
            $table->timestamp('revoked_at')->nullable()->index();
            $table->string('revocation_reason', 64)->nullable();
            $table->timestamps();
            $table->index(['user_id', 'revoked_at', 'absolute_expires_at'], 'mobile_refresh_family_active');
        });

        Schema::create('mobile_refresh_tokens', function (Blueprint $table) {
            $table->ulid('id')->primary();
            $table->foreignUlid('family_id')->constrained('mobile_refresh_token_families')->cascadeOnDelete();
            $table->foreignUlid('parent_id')->nullable()->constrained('mobile_refresh_tokens')->restrictOnDelete();
            $table->string('token_hash', 64)->unique();
            $table->timestamp('consumed_at')->nullable()->index();
            $table->timestamp('expires_at')->index();
            $table->timestamps();
        });

        Schema::table('personal_access_tokens', function (Blueprint $table) {
            $table->foreignUlid('refresh_token_family_id')
                ->nullable()
                ->constrained('mobile_refresh_token_families')
                ->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('personal_access_tokens', function (Blueprint $table) {
            $table->dropConstrainedForeignId('refresh_token_family_id');
        });

        Schema::dropIfExists('mobile_refresh_tokens');
        Schema::dropIfExists('mobile_refresh_token_families');
    }
};
