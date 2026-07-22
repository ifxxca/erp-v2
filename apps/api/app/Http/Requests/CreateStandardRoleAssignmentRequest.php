<?php

namespace App\Http\Requests;

use App\Models\Company;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CreateStandardRoleAssignmentRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        $company = $this->route('company');
        $companyId = $company instanceof Company ? $company->id : $company;

        return [
            'role_id' => [
                'required',
                'ulid',
                Rule::exists('roles', 'id')->where(fn ($query) => $query
                    ->where('is_privileged', false)
                    ->whereIn('assignment_scope', ['company', 'department', 'location'])),
            ],
            'department_id' => [
                'nullable',
                'ulid',
                Rule::exists('departments', 'id')->where(fn ($query) => $query
                    ->where('company_id', $companyId)
                    ->where('status', 'active')),
            ],
            'location_id' => [
                'nullable',
                'ulid',
                Rule::exists('locations', 'id')->where(fn ($query) => $query
                    ->where('company_id', $companyId)
                    ->where('status', 'active')),
            ],
            'valid_from' => ['required', 'date', 'after_or_equal:today'],
            'valid_until' => ['nullable', 'date', 'after_or_equal:valid_from'],
            'reason' => ['required', 'string', 'min:10', 'max:2000'],
        ];
    }
}
