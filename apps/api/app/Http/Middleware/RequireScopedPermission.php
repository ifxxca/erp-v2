<?php

namespace App\Http\Middleware;

use App\Models\Company;
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

        if (! is_string($companyId) || ! $this->permissions->allows($request->user(), $permission, $companyId)) {
            return new JsonResponse([
                'message' => 'This action is not permitted for the requested company.',
                'code' => 'PERMISSION_DENIED',
            ], Response::HTTP_FORBIDDEN);
        }

        return $next($request);
    }
}
