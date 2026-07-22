<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class SyncRolePermissionsRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'permission_ids' => ['required', 'array', 'min:1', 'max:100'],
            'permission_ids.*' => ['required', 'ulid', 'distinct', Rule::exists('permissions', 'id')],
            'reason' => ['required', 'string', 'min:10', 'max:1000'],
        ];
    }
}
