<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class UserCompanyMembership extends Model
{
    use HasFactory, HasUlids;

    protected $fillable = [
        'user_id',
        'company_id',
        'employee_no',
        'employment_status',
        'is_primary',
        'valid_from',
        'valid_until',
    ];

    protected function casts(): array
    {
        return [
            'is_primary' => 'boolean',
            'valid_from' => 'date',
            'valid_until' => 'date',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function company(): BelongsTo
    {
        return $this->belongsTo(Company::class);
    }
}
