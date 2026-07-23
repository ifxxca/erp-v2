<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CreateVehicleRequest extends FormRequest
{
    protected function prepareForValidation(): void
    {
        $this->merge([
            'code' => strtoupper(trim((string) $this->input('code'))),
            'plate_number' => strtoupper(preg_replace('/\s+/', ' ', trim((string) $this->input('plate_number')))),
        ]);
    }

    public function rules(): array
    {
        $companyId = $this->route('company')->id;

        return [
            'vehicle_type_id' => ['required', 'ulid', Rule::exists('vehicle_types', 'id')->where('company_id', $companyId)->where('status', 'active')],
            'code' => ['required', 'string', 'max:64', 'regex:/^[A-Z0-9_-]+$/', Rule::unique('vehicles')->where('company_id', $companyId)],
            'plate_number' => ['required', 'string', 'max:32', Rule::unique('vehicles')->where('company_id', $companyId)],
            'brand' => ['required', 'string', 'max:100'],
            'model' => ['required', 'string', 'max:100'],
            'model_year' => ['nullable', 'integer', 'between:1900,'.(now()->year + 1)],
            'ownership_type' => ['required', Rule::in(['owned', 'leased', 'vendor'])],
            'provider_name' => ['nullable', 'required_unless:ownership_type,owned', 'string', 'max:255'],
            'current_odometer' => ['required', 'integer', 'min:0'],
        ];
    }
}
