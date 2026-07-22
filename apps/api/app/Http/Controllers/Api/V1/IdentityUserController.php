<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\ChangeIdentityStatusRequest;
use App\Http\Requests\ListIdentityUsersRequest;
use App\Models\Company;
use App\Models\User;
use App\Modules\Identity\Application\IdentityAdministrationService;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

class IdentityUserController extends Controller
{
    public function __construct(private readonly IdentityAdministrationService $identity) {}

    public function index(ListIdentityUsersRequest $request, Company $company): JsonResponse
    {
        $filters = $request->validated();
        $users = User::query()
            ->whereHas('companyMemberships', fn (Builder $query) => $query
                ->where('company_id', $company->id)
                ->when(
                    $filters['employment_status'] ?? null,
                    fn (Builder $query, string $status) => $query->where('employment_status', $status),
                ))
            ->when($filters['status'] ?? null, fn (Builder $query, string $status) => $query->where('status', $status))
            ->when($filters['search'] ?? null, fn (Builder $query, string $search) => $query
                ->where(fn (Builder $query) => $query
                    ->whereLike('name', "%{$search}%")
                    ->orWhereLike('email', "%{$search}%")
                    ->orWhereHas('companyMemberships', fn (Builder $query) => $query
                        ->where('company_id', $company->id)
                        ->whereLike('employee_no', "%{$search}%"))))
            ->with($this->companyRelations($company))
            ->orderBy('name')
            ->paginate($filters['per_page'] ?? 25)
            ->through(fn (User $user) => $this->userData($user));

        return response()->json($users);
    }

    public function show(Company $company, User $user): JsonResponse
    {
        if (! $user->companyMemberships()->where('company_id', $company->id)->exists()) {
            abort(Response::HTTP_NOT_FOUND);
        }

        $user->load($this->companyRelations($company));

        return response()->json(['data' => $this->userData($user)]);
    }

    public function changeStatus(ChangeIdentityStatusRequest $request, User $user): JsonResponse
    {
        $user = $this->identity->changeStatus(
            $user,
            $request->user(),
            $request->validated('status'),
            $request->validated('reason'),
            $request,
        );

        return response()->json(['data' => $user->only(['id', 'name', 'email', 'status'])]);
    }

    /** @return array<string, callable> */
    private function companyRelations(Company $company): array
    {
        return [
            'companyMemberships' => fn ($query) => $query
                ->where('company_id', $company->id)
                ->orderByDesc('valid_from'),
            'departmentMemberships' => fn ($query) => $query
                ->where('company_id', $company->id)
                ->with('department:id,code,name')
                ->orderByDesc('valid_from'),
            'locationMemberships' => fn ($query) => $query
                ->where('company_id', $company->id)
                ->with('location:id,code,name,timezone')
                ->orderByDesc('valid_from'),
        ];
    }

    /** @return array<string, mixed> */
    private function userData(User $user): array
    {
        return [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'status' => $user->status,
            'last_login_at' => $user->last_login_at?->toIso8601String(),
            'company_memberships' => $user->companyMemberships->map(fn ($membership) => [
                'id' => $membership->id,
                'employee_no' => $membership->employee_no,
                'employment_status' => $membership->employment_status,
                'is_primary' => $membership->is_primary,
                'valid_from' => $membership->valid_from->toDateString(),
                'valid_until' => $membership->valid_until?->toDateString(),
            ])->values(),
            'department_memberships' => $user->departmentMemberships->map(fn ($membership) => [
                'id' => $membership->id,
                'department' => $membership->department,
                'is_primary' => $membership->is_primary,
                'valid_from' => $membership->valid_from->toDateString(),
                'valid_until' => $membership->valid_until?->toDateString(),
            ])->values(),
            'location_memberships' => $user->locationMemberships->map(fn ($membership) => [
                'id' => $membership->id,
                'location' => $membership->location,
                'valid_from' => $membership->valid_from->toDateString(),
                'valid_until' => $membership->valid_until?->toDateString(),
            ])->values(),
        ];
    }
}
