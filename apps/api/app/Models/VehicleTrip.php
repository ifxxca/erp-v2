<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class VehicleTrip extends Model
{
    use HasUlids;

    protected $fillable = [
        'company_id', 'location_id', 'vehicle_id', 'driver_id', 'status', 'purpose', 'destination',
        'start_odometer', 'end_odometer', 'departed_at', 'arrived_at', 'cancelled_at',
        'completion_note', 'cancel_reason', 'active_vehicle_key', 'active_driver_key',
    ];

    protected function casts(): array
    {
        return [
            'start_odometer' => 'integer', 'end_odometer' => 'integer', 'departed_at' => 'immutable_datetime',
            'arrived_at' => 'immutable_datetime', 'cancelled_at' => 'immutable_datetime',
        ];
    }

    public function vehicle(): BelongsTo
    {
        return $this->belongsTo(Vehicle::class);
    }

    public function driver(): BelongsTo
    {
        return $this->belongsTo(User::class, 'driver_id');
    }

    public function company(): BelongsTo
    {
        return $this->belongsTo(Company::class);
    }

    public function location(): BelongsTo
    {
        return $this->belongsTo(Location::class);
    }

    public function checklist(): HasOne
    {
        return $this->hasOne(ChecklistSubmission::class);
    }
}
