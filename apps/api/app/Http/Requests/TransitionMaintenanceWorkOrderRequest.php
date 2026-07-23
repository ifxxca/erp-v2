<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class TransitionMaintenanceWorkOrderRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'status' => ['required', Rule::in(['scheduled', 'in_progress', 'completed', 'cancelled'])],
            'note' => ['nullable', 'required_if:status,completed,cancelled', 'string', 'min:5', 'max:2000'],
        ];
    }
}
