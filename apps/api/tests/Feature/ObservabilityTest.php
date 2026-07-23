<?php

namespace Tests\Feature;

use App\Models\NotificationDelivery;
use App\Models\OutboxMessage;
use App\Models\User;
use App\Modules\Notifications\Application\NotificationChannelSender;
use App\Modules\Observability\Application\OperationalMetrics;
use App\Modules\Observability\Application\ReadinessChecker;
use App\Modules\Outbox\Application\OutboxDispatcher;
use App\Modules\Outbox\Application\OutboxHandler;
use App\Modules\Outbox\Application\OutboxWriter;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Tests\TestCase;

class ObservabilityTest extends TestCase
{
    use RefreshDatabase;

    public function test_liveness_and_dependency_readiness_are_distinct(): void
    {
        $this->getJson('/api/v1/health/live')
            ->assertOk()
            ->assertJsonPath('status', 'alive')
            ->assertJsonStructure(['checked_at']);
        $this->getJson('/api/v1/health/ready')
            ->assertOk()
            ->assertJsonPath('status', 'ready')
            ->assertJsonPath('checks.database.status', 'up')
            ->assertJsonPath('checks.cache.status', 'up')
            ->assertJsonPath('checks.queue.status', 'up')
            ->assertJsonPath('checks.object_storage.status', 'up');

        $this->app->instance(ReadinessChecker::class, new class extends ReadinessChecker
        {
            public function snapshot(): array
            {
                return [
                    'ready' => false,
                    'checks' => [
                        'database' => ['status' => 'down', 'latency_ms' => 1.25],
                    ],
                ];
            }
        });

        $this->getJson('/api/v1/health/ready')
            ->assertServiceUnavailable()
            ->assertJsonPath('status', 'unavailable')
            ->assertJsonPath('checks.database.status', 'down');
    }

    public function test_metrics_require_internal_token_and_export_low_cardinality_gauges(): void
    {
        config(['observability.metrics_token' => 'test-observability-token-00000001']);
        $dead = DB::transaction(fn () => app(OutboxWriter::class)->record(
            'test.unhandled',
            'test',
            null,
            ['value' => 2],
            'observability-dead-message-000001',
        ));
        app(OutboxDispatcher::class)->dispatchPending();
        $this->assertSame('dead_letter', $dead->refresh()->status);
        $pending = DB::transaction(fn () => app(OutboxWriter::class)->record(
            'test.pending',
            'test',
            null,
            ['value' => 1],
            'observability-pending-message-0001',
        ));
        $pending->forceFill(['occurred_at' => now()->subMinutes(2)])->save();

        $this->getJson('/api/v1/internal/metrics')
            ->assertUnauthorized()
            ->assertJsonPath('code', 'METRICS_UNAUTHENTICATED');
        $response = $this->withToken('test-observability-token-00000001')
            ->get('/api/v1/internal/metrics')
            ->assertOk();
        $this->assertStringContainsString('no-store', $response->headers->get('Cache-Control'));
        $this->assertStringContainsString(
            'rajawali_outbox_messages{status="dead_letter"} 1',
            $response->getContent(),
        );
        $this->assertMatchesRegularExpression(
            '/rajawali_outbox_oldest_pending_seconds 12[0-5]/',
            $response->getContent(),
        );
        $this->assertStringNotContainsString($pending->id, $response->getContent());
    }

    public function test_operational_thresholds_are_machine_evaluable(): void
    {
        config([
            'observability.thresholds.outbox_pending_count' => 1,
            'observability.thresholds.outbox_oldest_seconds' => 60,
        ]);
        $message = DB::transaction(fn () => app(OutboxWriter::class)->record(
            'test.pending',
            'test',
            null,
            ['value' => 1],
            'observability-alert-message-00001',
        ));
        $message->forceFill(['occurred_at' => now()->subMinutes(2)])->save();

        $alerts = collect(app(OperationalMetrics::class)->alerts());

        $this->assertTrue($alerts->contains('code', 'outbox_pending_count'));
        $this->assertTrue($alerts->contains('code', 'outbox_oldest_seconds'));
        $this->assertSame(0, Artisan::call('observability:check'));
    }

    public function test_request_telemetry_is_structured_and_correlated(): void
    {
        Log::spy();

        $this->withHeader('X-Request-ID', 'observability-request-0001')
            ->getJson('/api/v1/health/live')
            ->assertOk();

        Log::shouldHaveReceived('debug')->withArgs(fn (string $message, array $context) => $message === 'HTTP request completed.'
            && $context['request_id'] === 'observability-request-0001'
            && $context['route'] === 'api/v1/health/live'
            && $context['status'] === 200
            && is_float($context['duration_ms']));
    }

    public function test_outbox_redrive_preserves_history_and_creates_a_new_attempt_cycle(): void
    {
        RecoverableOutboxHandler::$fail = true;
        config([
            'outbox.max_attempts' => 1,
            'outbox.handlers' => [
                ...config('outbox.handlers'),
                'test.recoverable' => RecoverableOutboxHandler::class,
            ],
        ]);
        $message = DB::transaction(fn () => app(OutboxWriter::class)->record(
            'test.recoverable',
            'test',
            null,
            ['value' => 1],
            'observability-redrive-message-0001',
        ));
        app(OutboxDispatcher::class)->dispatchPending();
        $this->assertDatabaseHas('outbox_messages', [
            'id' => $message->id,
            'status' => 'dead_letter',
            'attempts' => 1,
            'attempts_in_cycle' => 1,
        ]);

        $exit = Artisan::call('outbox:redrive', [
            'message' => $message->id,
            '--reason' => 'Handler dependency corrected under OPS-123.',
            '--operator' => 'ops@example.test',
        ]);
        $this->assertSame(0, $exit);
        $this->assertDatabaseHas('outbox_messages', [
            'id' => $message->id,
            'status' => 'pending',
            'attempts' => 1,
            'attempts_in_cycle' => 0,
            'redrive_count' => 1,
        ]);
        $this->assertDatabaseHas('audit_logs', [
            'event' => 'platform.outbox_redriven',
            'subject_id' => $message->id,
        ]);

        RecoverableOutboxHandler::$fail = false;
        app(OutboxDispatcher::class)->dispatchPending();
        $this->assertDatabaseHas('outbox_messages', [
            'id' => $message->id,
            'status' => 'processed',
            'attempts' => 2,
            'attempts_in_cycle' => 1,
            'redrive_count' => 1,
        ]);
        $this->assertDatabaseCount('outbox_attempts', 2);
    }

    public function test_notification_delivery_redrive_is_audited_and_can_recover(): void
    {
        RecoverableNotificationSender::$fail = true;
        config(['outbox.delivery_max_attempts' => 1]);
        $this->app->bind(NotificationChannelSender::class, fn () => new RecoverableNotificationSender);
        $user = User::factory()->create();
        DB::transaction(fn () => app(OutboxWriter::class)->record(
            'notification.requested',
            'notification',
            null,
            [
                'recipient_user_ids' => [$user->id],
                'kind' => 'platform.delivery.recovery',
                'title' => 'Delivery recovery',
                'body' => 'Test notification delivery recovery.',
                'channels' => ['mail'],
            ],
            'observability-delivery-redrive-0001',
        ));
        app(OutboxDispatcher::class)->dispatchPending();
        app(OutboxDispatcher::class)->dispatchPending();
        $delivery = NotificationDelivery::query()->sole();
        $this->assertSame('dead_letter', $delivery->status);

        $exit = Artisan::call('notifications:redrive-delivery', [
            'delivery' => $delivery->id,
            '--reason' => 'Mail provider connectivity restored under OPS-124.',
            '--operator' => 'ops@example.test',
        ]);
        $this->assertSame(0, $exit);
        RecoverableNotificationSender::$fail = false;
        app(OutboxDispatcher::class)->dispatchPending();

        $this->assertDatabaseHas('notification_deliveries', [
            'id' => $delivery->id,
            'status' => 'delivered',
            'attempts' => 2,
            'attempts_in_cycle' => 1,
            'redrive_count' => 1,
            'provider_message_id' => 'provider-recovered-001',
        ]);
        $this->assertDatabaseHas('audit_logs', [
            'event' => 'platform.notification_delivery_redriven',
            'subject_id' => $delivery->id,
        ]);
        $this->assertDatabaseCount('notification_delivery_attempts', 2);
    }
}

class RecoverableOutboxHandler implements OutboxHandler
{
    public static bool $fail = true;

    public function handle(OutboxMessage $message): void
    {
        if (self::$fail) {
            throw new \RuntimeException('Temporary handler dependency failure.');
        }
    }
}

class RecoverableNotificationSender implements NotificationChannelSender
{
    public static bool $fail = true;

    public function send(NotificationDelivery $delivery): ?string
    {
        if (self::$fail) {
            throw new \RuntimeException('Temporary mail provider failure.');
        }

        return 'provider-recovered-001';
    }
}
