<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DocumentNumberAllocation extends Model
{
    use HasUlids;

    protected $fillable = [
        'company_id',
        'location_id',
        'rule_id',
        'rule_version',
        'document_type',
        'subject_type',
        'subject_id',
        'period_key',
        'sequence_value',
        'document_number',
        'document_date',
        'allocated_by',
        'allocated_at',
    ];

    protected function casts(): array
    {
        return [
            'sequence_value' => 'integer',
            'rule_version' => 'integer',
            'document_date' => 'immutable_date',
            'allocated_at' => 'immutable_datetime',
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

    public function rule(): BelongsTo
    {
        return $this->belongsTo(DocumentSequenceRule::class, 'rule_id');
    }

    public function allocator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'allocated_by');
    }
}
