<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Vehicle extends Model
{
    use HasUlids;

    protected $fillable = [
        'company_id', 'location_id', 'vehicle_type_id', 'code', 'plate_number', 'brand', 'model',
        'model_year', 'ownership_type', 'provider_name', 'current_odometer', 'operational_status',
        'status_reason', 'legacy_source_id', 'created_by',
    ];

    protected function casts(): array
    {
        return ['model_year' => 'integer', 'current_odometer' => 'integer'];
    }

    public function company(): BelongsTo
    {
        return $this->belongsTo(Company::class);
    }

    public function location(): BelongsTo
    {
        return $this->belongsTo(Location::class);
    }

    public function type(): BelongsTo
    {
        return $this->belongsTo(VehicleType::class, 'vehicle_type_id');
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function statusHistory(): HasMany
    {
        return $this->hasMany(VehicleStatusHistory::class);
    }

    public function workOrders(): HasMany
    {
        return $this->hasMany(MaintenanceWorkOrder::class);
    }

    public function trips(): HasMany
    {
        return $this->hasMany(VehicleTrip::class);
    }
}
