<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use LogicException;

class DocumentSequenceRule extends Model
{
    use HasUlids;

    protected $fillable = [
        'company_id',
        'location_id',
        'document_type',
        'type_code',
        'version',
        'pattern',
        'period',
        'padding',
        'timezone',
        'effective_from',
        'effective_until',
    ];

    protected function casts(): array
    {
        return [
            'version' => 'integer',
            'padding' => 'integer',
            'effective_from' => 'immutable_date',
            'effective_until' => 'immutable_date',
        ];
    }

    protected static function booted(): void
    {
        static::saving(function (self $rule): void {
            $rule->scope_key = $rule->location_id ?? 'GLOBAL';
        });
        static::updating(function (self $rule): void {
            $sequenceFields = [
                'company_id',
                'location_id',
                'document_type',
                'type_code',
                'version',
                'pattern',
                'period',
                'padding',
                'timezone',
                'effective_from',
            ];
            if ($rule->isDirty($sequenceFields)
                && ($rule->counters()->exists() || $rule->allocations()->exists())) {
                throw new LogicException('An allocated document sequence rule is immutable; publish a new version.');
            }
        });
    }

    /**
     * Keep the non-null scope key present before PostgreSQL prepares an insert.
     * The saving hook remains a final guard for low-level attribute changes.
     */
    protected function locationId(): Attribute
    {
        return Attribute::make(
            set: fn (?string $value): array => [
                'location_id' => $value,
                'scope_key' => $value ?? 'GLOBAL',
            ],
        );
    }

    public function company(): BelongsTo
    {
        return $this->belongsTo(Company::class);
    }

    public function location(): BelongsTo
    {
        return $this->belongsTo(Location::class);
    }

    public function counters(): HasMany
    {
        return $this->hasMany(DocumentSequence::class, 'rule_id');
    }

    public function allocations(): HasMany
    {
        return $this->hasMany(DocumentNumberAllocation::class, 'rule_id');
    }
}
