<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class CreateMaintenanceWorkOrderRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'vehicle_id' => [
                'required', 'ulid', Rule::exists('vehicles', 'id')
                    ->where('company_id', $this->route('company')->id)
                    ->where('location_id', $this->route('location')->id),
            ],
            'work_order_date' => ['required', 'date'],
            'priority' => ['required', Rule::in(['low', 'normal', 'high', 'urgent'])],
            'problem_description' => ['required', 'string', 'min:5', 'max:5000'],
            'parts_cost' => ['sometimes', 'numeric', 'min:0', 'max:9999999999999999.99'],
            'jobs' => ['required', 'array', 'min:1', 'max:50'],
            'jobs.*.description' => ['required', 'string', 'max:255'],
            'jobs.*.labor_cost' => ['required', 'numeric', 'min:0', 'max:9999999999999999.99'],
            'jobs.*.note' => ['nullable', 'string', 'max:1000'],
        ];
    }
}
