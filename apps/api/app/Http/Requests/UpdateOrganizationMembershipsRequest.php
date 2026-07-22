<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Validator;

class UpdateOrganizationMembershipsRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        return [
            'department_ids' => ['required', 'array', 'min:1'],
            'department_ids.*' => ['required', 'ulid', 'distinct'],
            'primary_department_id' => ['required', 'ulid'],
            'location_ids' => ['present', 'array'],
            'location_ids.*' => ['required', 'ulid', 'distinct'],
            'effective_from' => ['required', 'date', 'after_or_equal:today'],
            'reason' => ['required', 'string', 'min:10', 'max:1000'],
        ];
    }

    public function after(): array
    {
        return [function (Validator $validator): void {
            if (! in_array($this->input('primary_department_id'), $this->input('department_ids', []), true)) {
                $validator->errors()->add(
                    'primary_department_id',
                    'The primary department must be included in department_ids.',
                );
            }
        }];
    }
}
