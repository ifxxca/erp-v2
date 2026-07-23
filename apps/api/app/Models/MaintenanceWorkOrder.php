<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class MaintenanceWorkOrder extends Model
{
    use HasUlids;

    protected $fillable = [
        'company_id', 'location_id', 'vehicle_id', 'document_number', 'work_order_date', 'priority',
        'status', 'problem_description', 'completion_note', 'labor_cost', 'parts_cost', 'total_cost',
        'created_by', 'completed_by', 'scheduled_at', 'started_at', 'completed_at', 'cancelled_at',
    ];

    protected function casts(): array
    {
        return [
            'work_order_date' => 'immutable_date', 'labor_cost' => 'decimal:2', 'parts_cost' => 'decimal:2',
            'total_cost' => 'decimal:2', 'scheduled_at' => 'immutable_datetime', 'started_at' => 'immutable_datetime',
            'completed_at' => 'immutable_datetime', 'cancelled_at' => 'immutable_datetime',
        ];
    }

    public function company(): BelongsTo
    {
        return $this->belongsTo(Company::class);
    }

    public function location(): BelongsTo
    {
        return $this->belongsTo(Location::class);
    }

    public function vehicle(): BelongsTo
    {
        return $this->belongsTo(Vehicle::class);
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function jobs(): HasMany
    {
        return $this->hasMany(MaintenanceWorkOrderJob::class, 'work_order_id')->orderBy('line_number');
    }
}
