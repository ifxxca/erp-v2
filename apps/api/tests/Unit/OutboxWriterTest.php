<?php

namespace Tests\Unit;

use App\Modules\Outbox\Application\OutboxWriter;
use App\Modules\Outbox\Application\OutboxWriterException;
use Tests\TestCase;

class OutboxWriterTest extends TestCase
{
    public function test_writer_rejects_messages_outside_an_owning_transaction(): void
    {
        try {
            app(OutboxWriter::class)->record(
                'test.recorded',
                'test',
                null,
                ['value' => 1],
                'test-outside-transaction-0001',
            );
            $this->fail('The writer accepted a message outside a transaction.');
        } catch (OutboxWriterException $exception) {
            $this->assertSame('OUTBOX_TRANSACTION_REQUIRED', $exception->errorCode);
        }
    }
}
