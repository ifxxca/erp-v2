<?php

use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\CompanyMembershipController;
use App\Http\Controllers\Api\V1\IdentityCompanyController;
use App\Http\Controllers\Api\V1\IdentityUserController;
use App\Http\Controllers\Api\V1\InvitationController;
use App\Http\Controllers\Api\V1\MfaController;
use App\Http\Controllers\Api\V1\MobileTokenController;
use App\Http\Controllers\Api\V1\OrganizationMembershipController;
use App\Http\Controllers\Api\V1\PasswordRecoveryController;
use App\Http\Controllers\Api\V1\PrivilegedAccessController;
use App\Http\Controllers\Api\V1\RoleAdministrationController;
use App\Http\Controllers\Api\V1\SessionController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function (): void {
    Route::post('/auth/login', [AuthController::class, 'login'])->middleware('throttle:5,1');
    Route::post('/auth/password/forgot', [PasswordRecoveryController::class, 'request'])
        ->middleware('throttle:3,1');
    Route::post('/auth/password/reset', [PasswordRecoveryController::class, 'reset'])
        ->middleware('throttle:5,1');
    Route::post('/auth/mobile/refresh', [MobileTokenController::class, 'refresh'])
        ->middleware('throttle:10,1');
    Route::post('/auth/invitations/accept', [InvitationController::class, 'accept'])
        ->middleware('throttle:10,1');

    Route::get('/me', function (Request $request) {
        return $request->user()?->only(['id', 'name', 'email', 'status']);
    })->middleware(['auth:sanctum', 'identity.active', 'mfa.authenticated']);

    Route::middleware(['auth:sanctum', 'identity.active'])->group(function (): void {
        Route::post('/auth/logout', [AuthController::class, 'logout']);
        Route::get('/auth/mfa', [MfaController::class, 'status']);
        Route::post('/auth/mfa/totp/enroll', [MfaController::class, 'enroll'])->middleware('throttle:3,1');
        Route::post('/auth/mfa/totp/confirm', [MfaController::class, 'confirm'])->middleware('throttle:5,1');
        Route::post('/auth/mfa/challenge', [MfaController::class, 'challenge'])->middleware('throttle:5,1');
        Route::post('/auth/mfa/recovery-codes/regenerate', [MfaController::class, 'regenerateRecoveryCodes'])
            ->middleware(['mfa.recent', 'throttle:3,1']);
        Route::delete('/auth/mfa/totp', [MfaController::class, 'disable'])
            ->middleware(['mfa.recent', 'throttle:3,1']);

        Route::middleware('mfa.authenticated')->group(function (): void {
            Route::get('/auth/sessions', [SessionController::class, 'index']);
            Route::delete('/auth/sessions/{tokenId}', [SessionController::class, 'revoke'])
                ->whereNumber('tokenId');
            Route::post('/auth/sessions/revoke-all', [SessionController::class, 'revokeAll'])
                ->middleware('throttle:3,1');

            Route::post('/identity/users/invitations', [InvitationController::class, 'store'])
                ->middleware('permission.scoped:identity.user.manage');
            Route::patch('/identity/users/{user}/status', [IdentityUserController::class, 'changeStatus'])
                ->middleware(['permission.global:identity.user.status.manage', 'mfa.recent']);
            Route::post(
                '/identity/users/{user}/companies/{company}/terminate',
                [CompanyMembershipController::class, 'terminate'],
            )->middleware('permission.scoped:identity.employment.manage');

            Route::get('/identity/companies', [IdentityCompanyController::class, 'index']);
            Route::get('/identity/roles', [RoleAdministrationController::class, 'index'])
                ->middleware('permission.global:identity.role.view');
            Route::post('/identity/roles', [RoleAdministrationController::class, 'store'])
                ->middleware(['permission.global:identity.role.manage', 'mfa.recent']);
            Route::patch('/identity/roles/{role}', [RoleAdministrationController::class, 'update'])
                ->middleware(['permission.global:identity.role.manage', 'mfa.recent']);
            Route::put('/identity/roles/{role}/permissions', [RoleAdministrationController::class, 'syncPermissions'])
                ->middleware(['permission.global:identity.role.manage', 'mfa.recent']);
            Route::delete('/identity/roles/{role}', [RoleAdministrationController::class, 'destroy'])
                ->middleware(['permission.global:identity.role.manage', 'mfa.recent']);

            Route::prefix('/identity/companies/{company}')->group(function (): void {
                Route::get('/organization', [IdentityCompanyController::class, 'organization'])
                    ->middleware('permission.scoped:identity.user.view');
                Route::get('/users', [IdentityUserController::class, 'index'])
                    ->middleware('permission.scoped:identity.user.view');
                Route::get('/users/{user}', [IdentityUserController::class, 'show'])
                    ->middleware('permission.scoped:identity.user.view');
                Route::put('/users/{user}/organization-memberships', [OrganizationMembershipController::class, 'update'])
                    ->middleware('permission.scoped:identity.employment.manage');
                Route::get('/access-requests', [PrivilegedAccessController::class, 'index'])
                    ->middleware('permission.scoped:identity.access.approve');
                Route::get('/access-requests/mine', [PrivilegedAccessController::class, 'mine'])
                    ->middleware('permission.scoped:identity.access.request');
                Route::get('/access-catalog', [PrivilegedAccessController::class, 'catalog'])
                    ->middleware('permission.scoped:identity.access.request');
                Route::post('/access-requests', [PrivilegedAccessController::class, 'store'])
                    ->middleware(['permission.scoped:identity.access.request', 'mfa.recent']);
                Route::post('/access-requests/{accessRequest}/approve', [PrivilegedAccessController::class, 'approve'])
                    ->middleware(['permission.scoped:identity.access.approve', 'mfa.recent']);
                Route::post('/access-requests/{accessRequest}/reject', [PrivilegedAccessController::class, 'reject'])
                    ->middleware(['permission.scoped:identity.access.approve', 'mfa.recent']);
                Route::post('/role-assignments/{assignment}/revoke', [PrivilegedAccessController::class, 'revoke'])
                    ->middleware(['permission.scoped:identity.access.revoke', 'mfa.recent']);
                Route::get('/role-assignments', [PrivilegedAccessController::class, 'assignments'])
                    ->middleware('permission.scoped:identity.access.revoke');
            });
        });
    });
});
