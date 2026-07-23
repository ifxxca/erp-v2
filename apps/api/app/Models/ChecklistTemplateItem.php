<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ChecklistTemplateItem extends Model
{
    use HasUlids;

    protected $fillable = ['checklist_template_id', 'line_number', 'code', 'label', 'is_required', 'is_critical'];

    protected function casts(): array
    {
        return ['line_number' => 'integer', 'is_required' => 'boolean', 'is_critical' => 'boolean'];
    }

    public function template(): BelongsTo
    {
        return $this->belongsTo(ChecklistTemplate::class, 'checklist_template_id');
    }
}
