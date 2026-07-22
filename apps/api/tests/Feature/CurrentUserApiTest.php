<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class CurrentUserApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_current_user_endpoint_requires_authentication(): void
    {
        $this->getJson('/api/v1/me')->assertUnauthorized();
    }

    public function test_current_user_endpoint_returns_only_public_identity_fields(): void
    {
        $user = User::factory()->create();
        Sanctum::actingAs($user);

        $this->getJson('/api/v1/me')
            ->assertOk()
            ->assertExactJson([
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'status' => 'active',
            ]);
    }
}
