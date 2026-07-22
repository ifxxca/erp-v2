<?php

namespace Tests\Feature;

use App\Models\IdempotencyKey;
use App\Models\User;
use App\Modules\Identity\Application\AuditLogger;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Str;
use Tests\TestCase;

class RequestControlApiTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        Cache::flush();

        Route::middleware(['api', 'auth:sanctum', 'identity.active', 'idempotent'])
            ->post('/api/v1/_test/request-control', function (Request $request) {
                $sequence = Cache::increment('request-control-executions');
                app(AuditLogger::class)->record('test.request_control_executed', $request->user(), request: $request);

                if ($request->boolean('fail_first') && $sequence === 1) {
                    return response()->json(['message' => 'Temporary failure.'], 503);
                }

                return response()->json([
                    'sequence' => $sequence,
                    'value' => $request->input('value'),
                ], 201)->header('Location', '/api/v1/_test/resources/1');
            });
    }

    public function test_request_id_is_preserved_generated_and_written_to_errors_and_audit(): void
    {
        $user = User::factory()->create();
        $token = $user->createToken('Request controls')->plainTextToken;
        $provided = 'client-request-20260722-0001';

        $this->withToken($token)
            ->withHeader('X-Request-ID', $provided)
            ->postJson('/api/v1/_test/request-control', ['value' => 1])
            ->assertCreated()
            ->assertHeader('X-Request-ID', $provided);
        $this->assertDatabaseHas('audit_logs', [
            'event' => 'test.request_control_executed',
            'request_id' => $provided,
        ]);

        $response = $this->withToken($token)
            ->withHeaders([
                'X-Request-ID' => 'invalid id',
                'Idempotency-Key' => 'short',
            ])
            ->postJson('/api/v1/_test/request-control', ['value' => 2])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'IDEMPOTENCY_KEY_INVALID');

        $generated = $response->headers->get('X-Request-ID');
        $this->assertTrue(Str::isUlid($generated));
        $response->assertJsonPath('request_id', $generated);
    }

    public function test_framework_errors_use_stable_request_correlated_envelope(): void
    {
        $unauthenticated = $this->getJson('/api/v1/identity/companies')
            ->assertUnauthorized()
            ->assertJsonPath('code', 'UNAUTHENTICATED')
            ->assertJsonStructure(['message', 'request_id']);
        $unauthenticated->assertHeader('X-Request-ID', $unauthenticated->json('request_id'));

        $validation = $this->postJson('/api/v1/auth/login', [])
            ->assertUnprocessable()
            ->assertJsonPath('code', 'VALIDATION_FAILED')
            ->assertJsonStructure(['message', 'errors', 'request_id']);
        $validation->assertHeader('X-Request-ID', $validation->json('request_id'));
    }

    public function test_completed_request_is_replayed_without_reexecuting_side_effects(): void
    {
        [$token] = $this->actor();
        $key = '01J4IDEMPOTENCYREPLAY00000001';

        $first = $this->withToken($token)
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/v1/_test/request-control', ['value' => 17, 'context' => 'fleet'])
            ->assertCreated()
            ->assertHeader('Idempotency-Replayed', 'false')
            ->assertHeader('Location', '/api/v1/_test/resources/1')
            ->assertJsonPath('sequence', 1);

        $second = $this->withToken($token)
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/v1/_test/request-control', ['context' => 'fleet', 'value' => 17])
            ->assertCreated()
            ->assertHeader('Idempotency-Replayed', 'true')
            ->assertHeader('Location', '/api/v1/_test/resources/1')
            ->assertExactJson($first->json());

        $this->assertSame(1, Cache::get('request-control-executions'));
        $this->assertDatabaseCount('idempotency_keys', 1);
        $this->assertDatabaseHas('idempotency_keys', ['status' => 'completed', 'response_status' => 201]);
        $this->assertDatabaseCount('audit_logs', 1);
    }

    public function test_reusing_key_for_different_payload_is_rejected(): void
    {
        [$token] = $this->actor();
        $key = '01J4IDEMPOTENCYMISMATCH0000001';

        $this->withToken($token)
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/v1/_test/request-control', ['value' => 1])
            ->assertCreated();

        $this->withToken($token)
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/v1/_test/request-control', ['value' => 2])
            ->assertConflict()
            ->assertJsonPath('code', 'IDEMPOTENCY_KEY_REUSED')
            ->assertJsonStructure(['request_id']);

        $this->assertSame(1, Cache::get('request-control-executions'));
    }

    public function test_same_key_is_isolated_between_authenticated_identities(): void
    {
        [$firstToken] = $this->actor();
        [$secondToken] = $this->actor();
        $key = '01J4IDEMPOTENCYUSERSCOPE000001';

        $this->withToken($firstToken)
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/v1/_test/request-control', ['value' => 1])
            ->assertCreated()
            ->assertHeader('Idempotency-Replayed', 'false')
            ->assertJsonPath('sequence', 1);

        $this->app['auth']->forgetGuards();
        $this->withToken($secondToken)
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/v1/_test/request-control', ['value' => 1])
            ->assertCreated()
            ->assertHeader('Idempotency-Replayed', 'false')
            ->assertJsonPath('sequence', 2);

        $this->assertDatabaseCount('idempotency_keys', 2);
    }

    public function test_processing_request_returns_retryable_conflict(): void
    {
        [$token, $user] = $this->actor();
        $key = '01J4IDEMPOTENCYPROCESSING00001';
        IdempotencyKey::query()->create([
            'user_id' => $user->id,
            'key_hash' => hash('sha256', $key),
            'request_method' => 'POST',
            'request_path' => '/api/v1/_test/request-control',
            'request_fingerprint' => $this->fingerprint(['value' => 1]),
            'status' => 'processing',
            'expires_at' => now()->addMinutes(5),
        ]);

        $this->withToken($token)
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/v1/_test/request-control', ['value' => 1])
            ->assertConflict()
            ->assertHeader('Retry-After', '1')
            ->assertJsonPath('code', 'IDEMPOTENCY_REQUEST_IN_PROGRESS');

        $this->assertNull(Cache::get('request-control-executions'));
    }

    public function test_expired_processing_record_is_reacquired_after_a_crash(): void
    {
        [$token, $user] = $this->actor();
        $key = '01J4IDEMPOTENCYEXPIRED0000001';
        $expired = IdempotencyKey::query()->create([
            'user_id' => $user->id,
            'key_hash' => hash('sha256', $key),
            'request_method' => 'POST',
            'request_path' => '/api/v1/_test/request-control',
            'request_fingerprint' => $this->fingerprint(['value' => 1]),
            'status' => 'processing',
            'expires_at' => now()->subSecond(),
        ]);

        $this->withToken($token)
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/v1/_test/request-control', ['value' => 2])
            ->assertCreated()
            ->assertHeader('Idempotency-Replayed', 'false')
            ->assertJsonPath('sequence', 1);

        $this->assertDatabaseCount('idempotency_keys', 1);
        $this->assertDatabaseMissing('idempotency_keys', ['id' => $expired->id]);
        $this->assertDatabaseHas('idempotency_keys', ['status' => 'completed', 'response_status' => 201]);
    }

    public function test_failed_response_releases_key_for_a_later_retry(): void
    {
        [$token] = $this->actor();
        $key = '01J4IDEMPOTENCYRECOVERY0000001';

        $this->withToken($token)
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/v1/_test/request-control', ['value' => 9, 'fail_first' => true])
            ->assertStatus(503)
            ->assertJsonPath('code', 'INTERNAL_ERROR');
        $this->assertDatabaseCount('idempotency_keys', 0);

        $this->withToken($token)
            ->withHeader('Idempotency-Key', $key)
            ->postJson('/api/v1/_test/request-control', ['value' => 9, 'fail_first' => true])
            ->assertCreated()
            ->assertHeader('Idempotency-Replayed', 'false')
            ->assertJsonPath('sequence', 2);
        $this->assertDatabaseCount('idempotency_keys', 1);
    }

    /** @return array{string, User} */
    private function actor(): array
    {
        $user = User::factory()->create();
        $token = $user->createToken('Request controls')->plainTextToken;
        $this->app['auth']->forgetGuards();

        return [$token, $user];
    }

    /** @param array<string, mixed> $body */
    private function fingerprint(array $body): string
    {
        return hash('sha256', json_encode([
            'method' => 'POST',
            'path' => '/api/v1/_test/request-control',
            'query' => [],
            'body' => $body,
        ], JSON_THROW_ON_ERROR | JSON_UNESCAPED_SLASHES));
    }
}
