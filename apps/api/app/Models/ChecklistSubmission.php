<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ChecklistSubmission extends Model
{
    use HasUlids;

    protected $fillable = ['vehicle_trip_id', 'checklist_template_id', 'submitted_by', 'submitted_at'];

    protected function casts(): array
    {
        return ['submitted_at' => 'immutable_datetime'];
    }

    public function trip(): BelongsTo
    {
        return $this->belongsTo(VehicleTrip::class, 'vehicle_trip_id');
    }

    public function template(): BelongsTo
    {
        return $this->belongsTo(ChecklistTemplate::class, 'checklist_template_id');
    }

    public function submitter(): BelongsTo
    {
        return $this->belongsTo(User::class, 'submitted_by');
    }

    public function answers(): HasMany
    {
        return $this->hasMany(ChecklistAnswer::class);
    }
}
