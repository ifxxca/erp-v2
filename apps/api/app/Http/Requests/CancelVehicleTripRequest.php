<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CancelVehicleTripRequest extends FormRequest
{
    public function rules(): array
    {
        return ['reason' => ['required', 'string', 'min:5', 'max:2000']];
    }
}
