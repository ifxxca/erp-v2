<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MaintenanceWorkOrderJob extends Model
{
    use HasUlids;

    protected $fillable = ['work_order_id', 'line_number', 'description', 'status', 'labor_cost', 'note'];

    protected function casts(): array
    {
        return ['line_number' => 'integer', 'labor_cost' => 'decimal:2'];
    }

    public function workOrder(): BelongsTo
    {
        return $this->belongsTo(MaintenanceWorkOrder::class, 'work_order_id');
    }
}
