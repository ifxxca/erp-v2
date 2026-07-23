<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DocumentSequence extends Model
{
    use HasUlids;

    protected $fillable = ['rule_id', 'period_key', 'last_value'];

    protected function casts(): array
    {
        return ['last_value' => 'integer'];
    }

    public function rule(): BelongsTo
    {
        return $this->belongsTo(DocumentSequenceRule::class, 'rule_id');
    }
}
