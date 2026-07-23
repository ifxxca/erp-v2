<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CheckoutVehicleRequest extends FormRequest
{
    public function rules(): array
    {
        $companyId = $this->route('company')->id;
        $locationId = $this->route('location')->id;

        return [
            'vehicle_id' => ['required', 'ulid', Rule::exists('vehicles', 'id')->where(
                fn ($query) => $query->where('company_id', $companyId)->where('location_id', $locationId),
            )],
            'purpose' => ['required', 'string', 'max:255'],
            'destination' => ['nullable', 'string', 'max:255'],
            'start_odometer' => ['required', 'integer', 'min:0'],
            'departed_at' => ['nullable', 'date', 'before_or_equal:now'],
            'answers' => ['required', 'array', 'min:1'],
            'answers.*.item_id' => ['required', 'ulid', 'distinct'],
            'answers.*.result' => ['required', Rule::in(['pass', 'fail', 'not_applicable'])],
            'answers.*.note' => ['nullable', 'string', 'max:1000'],
            'answers.*.evidence_file_ids' => ['nullable', 'array', 'max:3'],
            'answers.*.evidence_file_ids.*' => ['required', 'ulid', 'distinct'],
        ];
    }
}
