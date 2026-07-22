<?php

namespace App\Http\Middleware;

use App\Modules\Identity\Application\EffectivePermissionResolver;
use Closure;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RequireGlobalPermission
{
    public function __construct(private readonly EffectivePermissionResolver $permissions) {}

    public function handle(Request $request, Closure $next, string $permission): Response
    {
        if (! $this->permissions->allowsGlobal($request->user(), $permission)) {
            return new JsonResponse([
                'message' => 'This action requires a global platform assignment.',
                'code' => 'GLOBAL_PERMISSION_DENIED',
            ], Response::HTTP_FORBIDDEN);
        }

        return $next($request);
    }
}
