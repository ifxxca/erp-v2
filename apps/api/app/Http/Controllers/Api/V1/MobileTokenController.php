<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\RefreshMobileTokenRequest;
use App\Modules\Identity\Application\MobileTokenService;
use Illuminate\Http\JsonResponse;

class MobileTokenController extends Controller
{
    public function __construct(private readonly MobileTokenService $tokens) {}

    public function refresh(RefreshMobileTokenRequest $request): JsonResponse
    {
        $pair = $this->tokens->rotate($request->validated('refresh_token'), $request);

        return response()->json([
            'token_type' => 'Bearer',
            'access_token' => $pair['access_token'],
            'expires_at' => $pair['expires_at'],
            'refresh_token' => $pair['refresh_token'],
            'refresh_expires_at' => $pair['refresh_expires_at'],
            'mfa_required' => $pair['mfa_required'],
        ]);
    }
}
