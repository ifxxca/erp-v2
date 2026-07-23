<?php

namespace Tests\Feature;

use App\Models\Company;
use App\Models\NotificationDelivery;
use App\Models\OutboxMessage;
use App\Models\PlatformNotification;
use App\Models\User;
use App\Modules\Notifications\Application\NotificationChannelSender;
use App\Modules\Outbox\Application\OutboxDispatcher;
use App\Modules\Outbox\Application\OutboxHandler;
use App\Modules\Outbox\Application\OutboxWriter;
use App\Modules\Outbox\Application\OutboxWriterException;
use App\Notifications\PlatformMessageNotification;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Notification;
use RuntimeException;
use Tests\TestCase;

class OutboxNotificationTest extends TestCase
{
    use RefreshDatabase;

    public function test_writer_rolls_back_with_owning_transaction(): void
    {
        $writer = app(OutboxWriter::class);

        try {
            DB::transaction(function () use ($writer): void {
                $writer->record('test.recorded', 'test', null, ['value' => 1], 'test-rolled-back-message-0001');
                throw new RuntimeException('Rollback the domain transaction.');
            });
        } catch (RuntimeException) {
            // Expected: the domain write and outbox message are atomic.
        }

        $this->assertDatabaseCount('outbox_messages', 0);
    }

    public function test_writer_replays_identical_deduplication_key_and_rejects_mismatch(): void
    {
        $writer = app(OutboxWriter::class);

        DB::transaction(function () use ($writer): void {
            $first = $writer->record(
                'test.recorded',
                'test',
                'aggregate-1',
                ['nested' => ['b' => 2, 'a' => 1]],
                'test-deduplication-message-0001',
            );
            $replayed = $writer->record(
                'test.recorded',
                'test',
                'aggregate-1',
                ['nested' => ['a' => 1, 'b' => 2]],
                'test-deduplication-message-0001',
            );

            $this->assertTrue($first->is($replayed));

            try {
                $writer->record(
                    'test.recorded',
                    'test',
                    'aggregate-1',
                    ['nested' => ['a' => 99, 'b' => 2]],
                    'test-deduplication-message-0001',
                );
                $this->fail('A mismatched deduplication replay was accepted.');
            } catch (OutboxWriterException $exception) {
                $this->assertSame('OUTBOX_DEDUPLICATION_MISMATCH', $exception->errorCode);
            }
        });

        $this->assertDatabaseCount('outbox_messages', 1);
    }

    public function test_notification_outbox_creates_idempotent_inbox_and_delivers_mail(): void
    {
        Notification::fake();
        $company = $this->company();
        $user = User::factory()->create();
        $request = Request::create('/', 'POST', server: ['HTTP_X_REQUEST_ID' => 'request-outbox-0001']);
        $message = $this->recordNotification(
            [$user->id],
            'platform.test.completed',
            'Pekerjaan selesai',
            'Proses pengujian telah selesai.',
            ['inbox', 'mail'],
            'notification-happy-path-0001',
            $company,
            $request,
        );

        $this->assertSame('pending', $message->status);
        $this->assertSame('request-outbox-0001', $message->request_id);
        $this->assertDatabaseCount('notifications', 0);

        $first = app(OutboxDispatcher::class)->dispatchPending();
        $this->assertSame(['outbox' => 1, 'deliveries' => 0], $first);
        $message->refresh();
        $this->assertSame(
            'processed',
            $message->status,
            ($message->last_error_code ?? 'UNKNOWN').': '.($message->last_error_message ?? 'No error message.'),
        );
        $this->assertDatabaseHas('outbox_messages', ['id' => $message->id, 'status' => 'processed', 'attempts' => 1]);
        $this->assertDatabaseHas('notification_deliveries', ['channel' => 'inbox', 'status' => 'delivered']);
        $this->assertDatabaseHas('notification_deliveries', ['channel' => 'mail', 'status' => 'pending']);

        $second = app(OutboxDispatcher::class)->dispatchPending();
        $this->assertSame(['outbox' => 0, 'deliveries' => 1], $second);
        $this->assertDatabaseHas('notification_deliveries', ['channel' => 'mail', 'status' => 'delivered']);
        Notification::assertSentTo($user, PlatformMessageNotification::class);

        app(OutboxDispatcher::class)->dispatchPending();
        $this->assertDatabaseCount('notifications', 1);
        $this->assertDatabaseCount('outbox_attempts', 1);
        $this->assertDatabaseCount('notification_deliveries', 2);
        $this->assertDatabaseCount('notification_delivery_attempts', 2);
        Notification::assertSentToTimes($user, PlatformMessageNotification::class, 1);
    }

    public function test_permanent_handler_failure_is_dead_lettered_with_attempt_history(): void
    {
        $message = DB::transaction(fn () => app(OutboxWriter::class)->record(
            'unknown.event',
            'test',
            null,
            ['value' => 1],
            'unknown-handler-message-0001',
        ));

        app(OutboxDispatcher::class)->dispatchPending();

        $this->assertDatabaseHas('outbox_messages', [
            'id' => $message->id,
            'status' => 'dead_letter',
            'attempts' => 1,
            'last_error_code' => 'OUTBOX_HANDLER_NOT_FOUND',
        ]);
        $this->assertDatabaseHas('outbox_attempts', [
            'outbox_message_id' => $message->id,
            'attempt_no' => 1,
            'status' => 'failed',
            'error_code' => 'OUTBOX_HANDLER_NOT_FOUND',
        ]);
    }

    public function test_transient_handler_failure_is_retried_then_processed(): void
    {
        RetryingOutboxHandler::$calls = 0;
        config(['outbox.handlers' => [
            ...config('outbox.handlers'),
            'test.retrying' => RetryingOutboxHandler::class,
        ]]);
        $message = DB::transaction(fn () => app(OutboxWriter::class)->record(
            'test.retrying',
            'test',
            null,
            ['value' => 1],
            'retrying-handler-message-0001',
        ));

        app(OutboxDispatcher::class)->dispatchPending();
        $this->assertDatabaseHas('outbox_messages', [
            'id' => $message->id,
            'status' => 'pending',
            'attempts' => 1,
            'last_error_code' => 'OUTBOX_HANDLER_FAILED',
        ]);

        $message->refresh()->forceFill(['available_at' => now()])->save();
        app(OutboxDispatcher::class)->dispatchPending();

        $this->assertDatabaseHas('outbox_messages', ['id' => $message->id, 'status' => 'processed', 'attempts' => 2]);
        $this->assertDatabaseCount('outbox_attempts', 2);
        $this->assertSame(2, RetryingOutboxHandler::$calls);
    }

    public function test_delivery_failure_retries_then_moves_to_dead_letter(): void
    {
        $user = User::factory()->create();
        config(['outbox.delivery_max_attempts' => 2]);
        $this->app->bind(NotificationChannelSender::class, fn () => new FailingNotificationSender);
        $this->recordNotification(
            [$user->id],
            'platform.test.failed',
            'Pengiriman diuji',
            'Pesan ini menguji retry.',
            ['mail'],
            'notification-delivery-failure-0001',
        );

        app(OutboxDispatcher::class)->dispatchPending();
        app(OutboxDispatcher::class)->dispatchPending();
        $delivery = NotificationDelivery::query()->sole();
        $this->assertSame('pending', $delivery->status);
        $this->assertSame(1, $delivery->attempts);

        $delivery->forceFill(['available_at' => now()])->save();
        app(OutboxDispatcher::class)->dispatchPending();

        $this->assertDatabaseHas('notification_deliveries', [
            'id' => $delivery->id,
            'status' => 'dead_letter',
            'attempts' => 2,
            'last_error_code' => 'NOTIFICATION_DELIVERY_FAILED',
        ]);
        $this->assertDatabaseCount('notification_delivery_attempts', 2);
    }

    public function test_notification_api_is_user_isolated_and_supports_read_state(): void
    {
        $user = User::factory()->create();
        $other = User::factory()->create();
        $this->recordNotification(
            [$user->id, $other->id],
            'platform.notice',
            'Pemberitahuan',
            'Ada informasi baru.',
            ['inbox'],
            'notification-api-shared-0001',
        );
        $this->recordNotification(
            [$user->id],
            'platform.notice.second',
            'Pemberitahuan kedua',
            'Ada informasi berikutnya.',
            ['inbox'],
            'notification-api-second-0001',
        );
        app(OutboxDispatcher::class)->dispatchPending();

        $own = PlatformNotification::query()->where('user_id', $user->id)->firstOrFail();
        $foreign = PlatformNotification::query()->where('user_id', $other->id)->sole();
        $this->actingAs($user, 'sanctum')
            ->getJson('/api/v1/notifications')
            ->assertOk()
            ->assertJsonCount(2, 'data')
            ->assertJsonPath('meta.unread_count', 2);

        $this->actingAs($user, 'sanctum')
            ->withHeader('Idempotency-Key', 'notification-read-one-0000001')
            ->patchJson("/api/v1/notifications/{$own->id}/read")
            ->assertOk()
            ->assertJsonPath('data.id', $own->id)
            ->assertJsonPath('data.deliveries.inbox', 'delivered');
        $this->assertNotNull($own->refresh()->read_at);

        $this->actingAs($user, 'sanctum')
            ->withHeader('Idempotency-Key', 'notification-read-foreign-0001')
            ->patchJson("/api/v1/notifications/{$foreign->id}/read")
            ->assertNotFound();

        $this->actingAs($user, 'sanctum')
            ->withHeader('Idempotency-Key', 'notification-read-all-0000001')
            ->postJson('/api/v1/notifications/read-all')
            ->assertOk()
            ->assertJsonPath('updated', 1);
        $this->assertSame(0, PlatformNotification::query()
            ->where('user_id', $user->id)
            ->whereNull('read_at')
            ->count());
        $this->assertNull($foreign->refresh()->read_at);
    }

    /**
     * @param  list<string>  $recipientIds
     * @param  list<string>  $channels
     */
    private function recordNotification(
        array $recipientIds,
        string $kind,
        string $title,
        string $body,
        array $channels,
        string $deduplicationKey,
        ?Company $company = null,
        ?Request $request = null,
    ): OutboxMessage {
        return DB::transaction(fn () => app(OutboxWriter::class)->record(
            'notification.requested',
            'notification',
            null,
            [
                'recipient_user_ids' => $recipientIds,
                'kind' => $kind,
                'title' => $title,
                'body' => $body,
                'data' => ['source' => 'test'],
                'action_url' => '/notifications',
                'channels' => $channels,
            ],
            $deduplicationKey,
            $company,
            $request,
        ));
    }

    private function company(): Company
    {
        return Company::query()->create([
            'code' => 'TEST',
            'legal_name' => 'Test Company',
            'status' => 'active',
        ]);
    }
}

class RetryingOutboxHandler implements OutboxHandler
{
    public static int $calls = 0;

    public function handle(OutboxMessage $message): void
    {
        self::$calls++;
        if (self::$calls === 1) {
            throw new RuntimeException('Temporary handler failure.');
        }
    }
}

class FailingNotificationSender implements NotificationChannelSender
{
    public function send(NotificationDelivery $delivery): ?string
    {
        throw new RuntimeException('Temporary provider failure.');
    }
}
