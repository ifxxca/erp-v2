<?php

use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\CompanyMembershipController;
use App\Http\Controllers\Api\V1\InvitationController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function (): void {
    Route::post('/auth/login', [AuthController::class, 'login'])->middleware('throttle:5,1');
    Route::post('/auth/invitations/accept', [InvitationController::class, 'accept'])
        ->middleware('throttle:10,1');

    Route::get('/me', function (Request $request) {
        return $request->user()?->only(['id', 'name', 'email', 'status']);
    })->middleware(['auth:sanctum', 'identity.active']);

    Route::middleware(['auth:sanctum', 'identity.active'])->group(function (): void {
        Route::post('/auth/logout', [AuthController::class, 'logout']);
        Route::post('/identity/users/invitations', [InvitationController::class, 'store'])
            ->middleware('permission.scoped:identity.user.manage');
        Route::post(
            '/identity/users/{user}/companies/{company}/terminate',
            [CompanyMembershipController::class, 'terminate'],
        )->middleware('permission.scoped:identity.user.manage');
    });
});
