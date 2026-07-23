<?php

namespace App\Modules\Outbox\Application;

use Illuminate\Contracts\Container\Container;

class OutboxHandlerRegistry
{
    public function __construct(private readonly Container $container) {}

    public function for(string $eventType): OutboxHandler
    {
        $handlerClass = config('outbox.handlers')[$eventType] ?? null;
        if (! is_string($handlerClass)) {
            throw new PermanentOutboxFailure(
                "No outbox handler is registered for {$eventType}.",
                'OUTBOX_HANDLER_NOT_FOUND',
            );
        }

        $handler = $this->container->make($handlerClass);
        if (! $handler instanceof OutboxHandler) {
            throw new PermanentOutboxFailure(
                "Configured handler for {$eventType} is invalid.",
                'OUTBOX_HANDLER_INVALID',
            );
        }

        return $handler;
    }
}
