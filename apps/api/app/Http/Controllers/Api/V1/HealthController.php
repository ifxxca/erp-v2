<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Modules\Observability\Application\ReadinessChecker;
use Illuminate\Http\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

class HealthController extends Controller
{
    public function live(): JsonResponse
    {
        return response()->json([
            'status' => 'alive',
            'checked_at' => now()->toIso8601String(),
        ]);
    }

    public function ready(ReadinessChecker $readiness): JsonResponse
    {
        $snapshot = $readiness->snapshot();

        return response()->json([
            'status' => $snapshot['ready'] ? 'ready' : 'unavailable',
            'checks' => $snapshot['checks'],
            'checked_at' => now()->toIso8601String(),
        ], $snapshot['ready'] ? Response::HTTP_OK : Response::HTTP_SERVICE_UNAVAILABLE);
    }
}
