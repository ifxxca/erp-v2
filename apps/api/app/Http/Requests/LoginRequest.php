<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class LoginRequest extends FormRequest
{
    protected function prepareForValidation(): void
    {
        if ($this->isJson() && is_string($this->input('email'))) {
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
        return [
            'email' => ['required', 'email:rfc', 'max:255'],
            'password' => ['required', 'string'],
            'surface' => ['required', Rule::in(['erp_web', 'ops_web', 'mobile'])],
            'device_name' => ['required', 'string', 'max:120'],
        ];
    }
}
