<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureActiveIdentity
{
    public function handle(Request $request, Closure $next): Response
    {
        if ($request->user()?->status !== 'active') {
            return new JsonResponse([
                'message' => 'Identity is not active.',
                'code' => 'IDENTITY_INACTIVE',
            ], Response::HTTP_FORBIDDEN);
        }

        return $next($request);
    }
}
