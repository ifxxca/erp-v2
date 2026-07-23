<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CheckInVehicleRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'end_odometer' => ['required', 'integer', 'min:0'],
            'arrived_at' => ['nullable', 'date', 'before_or_equal:now'],
            'note' => ['nullable', 'string', 'max:2000'],
        ];
    }
}
