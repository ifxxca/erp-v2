<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ChecklistAnswer extends Model
{
    use HasUlids;

    protected $fillable = ['checklist_submission_id', 'checklist_template_item_id', 'result', 'note'];

    public function submission(): BelongsTo
    {
        return $this->belongsTo(ChecklistSubmission::class, 'checklist_submission_id');
    }

    public function item(): BelongsTo
    {
        return $this->belongsTo(ChecklistTemplateItem::class, 'checklist_template_item_id');
    }
}
