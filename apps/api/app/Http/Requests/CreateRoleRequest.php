<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CreateRoleRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'code' => ['required', 'string', 'max:128', 'regex:/^[a-z][a-z0-9-]{2,127}$/', 'unique:roles,code'],
            'name' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string', 'max:2000'],
            'is_privileged' => ['required', 'boolean'],
            'assignment_scope' => ['required', Rule::in(['company', 'department', 'location'])],
            'permission_ids' => ['required', 'array', 'min:1', 'max:100'],
            'permission_ids.*' => ['required', 'ulid', 'distinct', Rule::exists('permissions', 'id')],
            'reason' => ['required', 'string', 'min:10', 'max:1000'],
        ];
    }
}
