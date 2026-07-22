<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\AcceptInvitationRequest;
use App\Http\Requests\CreateInvitationRequest;
use App\Models\Company;
use App\Models\User;
use App\Models\UserCompanyMembership;
use App\Models\UserDepartmentMembership;
use App\Models\UserInvitation;
use App\Models\UserLocationMembership;
use App\Modules\Identity\Application\AuditLogger;
use App\Notifications\UserInvitationNotification;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Symfony\Component\HttpFoundation\Response;

class InvitationController extends Controller
{
    public function __construct(private readonly AuditLogger $audit) {}

    public function store(CreateInvitationRequest $request): JsonResponse
    {
        $data = $request->validated();
        $actor = $request->user();
        $company = Company::query()->findOrFail($data['company_id']);
        $plainToken = bin2hex(random_bytes(32));
        $expiresAt = now()->addHours((int) config('identity.invitation_lifetime_hours'));

        [$user, $invitation] = DB::transaction(function () use (
            $data,
            $actor,
            $plainToken,
            $expiresAt,
            $request,
        ): array {
            $user = User::query()->create([
                'name' => $data['name'],
                'email' => mb_strtolower($data['email']),
                'password' => Str::random(64),
                'status' => 'invited',
            ]);

            UserCompanyMembership::query()->create([
                'user_id' => $user->id,
                'company_id' => $data['company_id'],
                'employee_no' => $data['employee_no'] ?? null,
                'employment_status' => 'invited',
                'is_primary' => true,
                'valid_from' => $data['valid_from'],
            ]);

            foreach ($data['department_ids'] as $departmentId) {
                UserDepartmentMembership::query()->create([
                    'user_id' => $user->id,
                    'company_id' => $data['company_id'],
                    'department_id' => $departmentId,
                    'is_primary' => $departmentId === $data['primary_department_id'],
                    'valid_from' => $data['valid_from'],
                ]);
            }

            foreach ($data['location_ids'] ?? [] as $locationId) {
                UserLocationMembership::query()->create([
                    'user_id' => $user->id,
                    'company_id' => $data['company_id'],
                    'location_id' => $locationId,
                    'valid_from' => $data['valid_from'],
                ]);
            }

            $invitation = UserInvitation::query()->create([
                'user_id' => $user->id,
                'invited_by' => $actor->id,
                'token_hash' => hash('sha256', $plainToken),
                'expires_at' => $expiresAt,
            ]);

            $this->audit->record(
                'identity.invitation_created',
                $actor,
                $user,
                ['company_id' => $data['company_id'], 'invitation_id' => $invitation->id],
                $request,
            );

            return [$user, $invitation];
        });

        $user->notify(new UserInvitationNotification(
            $plainToken,
            $company->legal_name,
            $expiresAt->toIso8601String(),
        ));

        return response()->json([
            'id' => $invitation->id,
            'user_id' => $user->id,
            'status' => 'invited',
            'expires_at' => $expiresAt->toIso8601String(),
        ], Response::HTTP_CREATED);
    }

    public function accept(AcceptInvitationRequest $request): JsonResponse
    {
        $data = $request->validated();

        $user = DB::transaction(function () use ($data, $request): ?User {
            $invitation = UserInvitation::query()
                ->where('token_hash', hash('sha256', $data['token']))
                ->whereNull('accepted_at')
                ->where('expires_at', '>', now())
                ->lockForUpdate()
                ->first();

            if (! $invitation || $invitation->user->status !== 'invited') {
                return null;
            }

            $user = $invitation->user;
            $user->forceFill([
                'password' => $data['password'],
                'status' => 'active',
                'email_verified_at' => now(),
            ])->save();
            $user->companyMemberships()
                ->where('employment_status', 'invited')
                ->update(['employment_status' => 'active']);
            $invitation->update(['accepted_at' => now()]);

            $this->audit->record(
                'identity.invitation_accepted',
                subject: $user,
                metadata: ['invitation_id' => $invitation->id],
                request: $request,
            );

            return $user;
        });

        if (! $user) {
            return response()->json([
                'message' => 'Invitation is invalid, expired, or already used.',
                'code' => 'INVITATION_INVALID',
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        return response()->json(['status' => 'active']);
    }
}
