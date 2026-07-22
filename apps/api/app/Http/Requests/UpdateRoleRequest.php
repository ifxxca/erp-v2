<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateRoleRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string', 'max:2000'],
            'is_privileged' => ['required', 'boolean'],
            'assignment_scope' => ['required', Rule::in(['company', 'department', 'location'])],
            'reason' => ['required', 'string', 'min:10', 'max:1000'],
        ];
    }
}
