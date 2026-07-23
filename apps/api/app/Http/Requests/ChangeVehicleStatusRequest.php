<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ChangeVehicleStatusRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'status' => ['required', Rule::in(['available', 'in_use', 'maintenance', 'blocked', 'inactive'])],
            'reason' => ['required', 'string', 'min:5', 'max:1000'],
        ];
    }
}
