<?php

namespace App\Http\Requests;

use App\Models\Company;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CreatePrivilegedAccessRequest extends FormRequest
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
        $latestExpiry = now()->addDays((int) config('identity.privileged_assignment_max_days'));

        return [
            'target_user_id' => ['required', 'ulid', Rule::exists('users', 'id')->where('status', 'active')],
            'role_id' => [
                'required',
                'ulid',
                Rule::exists('roles', 'id')->where(fn ($query) => $query
                    ->where('is_privileged', true)
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
            'reason' => ['required', 'string', 'max:2000'],
            'valid_until' => [
                'required',
                'date',
                'after:now',
                'before_or_equal:'.$latestExpiry->toIso8601String(),
            ],
        ];
    }
}
