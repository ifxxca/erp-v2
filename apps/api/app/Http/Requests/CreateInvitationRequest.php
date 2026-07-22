<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CreateInvitationRequest extends FormRequest
{
    protected function prepareForValidation(): void
    {
        if (is_string($this->input('email'))) {
            $this->merge(['email' => mb_strtolower(trim($this->input('email')))]);
        }
    }

    public function authorize(): bool
    {
        return true;
    }

    /** @return array<string, mixed> */
    public function rules(): array
    {
        $companyId = $this->input('company_id');

        return [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'email:rfc', 'max:255', 'unique:users,email'],
            'company_id' => ['required', 'ulid', Rule::exists('companies', 'id')->where('status', 'active')],
            'employee_no' => [
                'nullable',
                'string',
                'max:64',
                Rule::unique('user_company_memberships', 'employee_no')->where('company_id', $companyId),
            ],
            'department_ids' => ['required', 'array', 'min:1', 'max:8'],
            'department_ids.*' => [
                'required',
                'ulid',
                'distinct',
                Rule::exists('departments', 'id')->where(fn ($query) => $query
                    ->where('company_id', $companyId)
                    ->where('status', 'active')),
            ],
            'primary_department_id' => ['required', 'ulid', Rule::in($this->input('department_ids', []))],
            'location_ids' => ['sometimes', 'array', 'max:50'],
            'location_ids.*' => [
                'required',
                'ulid',
                'distinct',
                Rule::exists('locations', 'id')->where(fn ($query) => $query
                    ->where('company_id', $companyId)
                    ->where('status', 'active')),
            ],
            'valid_from' => ['required', 'date'],
        ];
    }
}
