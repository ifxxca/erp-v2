<?php

namespace App\Http\Middleware;

use App\Models\Company;
use App\Models\Location;
use App\Modules\Identity\Application\EffectivePermissionResolver;
use Closure;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class RequireScopedPermission
{
    public function __construct(private readonly EffectivePermissionResolver $permissions) {}

    public function handle(Request $request, Closure $next, string $permission): Response
    {
        $company = $request->route('company') ?? $request->input('company_id');
        $companyId = $company instanceof Company ? $company->id : $company;
        // Only a route-scoped location constrains the actor. A mutation body may describe
        // a target user's assignment scope and must not be mistaken for the actor's scope.
        $location = $request->route('location');
        $locationId = $location instanceof Location ? $location->id : $location;

        if ($location instanceof Location && $location->company_id !== $companyId) {
            return new JsonResponse([
                'message' => 'This action is not permitted for the requested location.',
                'code' => 'PERMISSION_DENIED',
            ], Response::HTTP_FORBIDDEN);
        }

        if (! is_string($companyId)
            || ($locationId !== null && ! is_string($locationId))
            || ! $this->permissions->allows($request->user(), $permission, $companyId, locationId: $locationId)) {
            return new JsonResponse([
                'message' => 'This action is not permitted for the requested company.',
                'code' => 'PERMISSION_DENIED',
            ], Response::HTTP_FORBIDDEN);
        }

        return $next($request);
    }
}
