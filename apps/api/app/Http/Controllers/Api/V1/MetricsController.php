<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Modules\Observability\Application\OperationalMetrics;
use Illuminate\Http\Response;

class MetricsController extends Controller
{
    public function __invoke(OperationalMetrics $metrics): Response
    {
        return response($metrics->prometheus(), 200, [
            'Content-Type' => 'text/plain; version=0.0.4; charset=utf-8',
            'Cache-Control' => 'no-store',
        ]);
    }
}
