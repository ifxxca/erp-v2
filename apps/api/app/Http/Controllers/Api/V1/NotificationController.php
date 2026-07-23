<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\PlatformNotification;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class NotificationController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'company_id' => ['nullable', 'ulid'],
            'unread' => ['nullable', 'boolean'],
            'per_page' => ['nullable', 'integer', 'min:1', 'max:50'],
        ]);
        $query = PlatformNotification::query()
            ->where('user_id', $request->user()->id)
            ->with('deliveries:id,notification_id,channel,status')
            ->when($validated['company_id'] ?? null, fn ($query, $companyId) => $query
                ->where('company_id', $companyId))
            ->when($request->boolean('unread'), fn ($query) => $query->whereNull('read_at'))
            ->latest();
        $unreadCount = (clone $query)->whereNull('read_at')->count();
        $page = $query->paginate($validated['per_page'] ?? 20);

        return response()->json([
            'data' => $page->getCollection()->map(fn (PlatformNotification $notification) => $this->resource($notification)),
            'meta' => [
                'current_page' => $page->currentPage(),
                'last_page' => $page->lastPage(),
                'per_page' => $page->perPage(),
                'total' => $page->total(),
                'unread_count' => $unreadCount,
            ],
        ]);
    }

    public function read(PlatformNotification $notification, Request $request): JsonResponse
    {
        $this->assertOwner($notification, $request);
        if ($notification->read_at === null) {
            $notification->forceFill(['read_at' => now()])->save();
        }

        return response()->json(['data' => $this->resource($notification->loadMissing('deliveries'))]);
    }

    public function readAll(Request $request): JsonResponse
    {
        $updated = PlatformNotification::query()
            ->where('user_id', $request->user()->id)
            ->whereNull('read_at')
            ->update(['read_at' => now(), 'updated_at' => now()]);

        return response()->json(['updated' => $updated]);
    }

    private function assertOwner(PlatformNotification $notification, Request $request): void
    {
        if ($notification->user_id !== $request->user()->id) {
            abort(404);
        }
    }

    /** @return array<string, mixed> */
    private function resource(PlatformNotification $notification): array
    {
        return [
            'id' => $notification->id,
            'company_id' => $notification->company_id,
            'kind' => $notification->kind,
            'title' => $notification->title,
            'body' => $notification->body,
            'data' => $notification->data ?? [],
            'action_url' => $notification->action_url,
            'read_at' => $notification->read_at?->toIso8601String(),
            'created_at' => $notification->created_at->toIso8601String(),
            'deliveries' => $notification->deliveries
                ->mapWithKeys(fn ($delivery) => [$delivery->channel => $delivery->status]),
        ];
    }
}
