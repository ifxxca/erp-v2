<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function (): void {
    Route::get('/me', function (Request $request) {
        return $request->user()?->only(['id', 'name', 'email', 'status']);
    })->middleware('auth:sanctum');
});
