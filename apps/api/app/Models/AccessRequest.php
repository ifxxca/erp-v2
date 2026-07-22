<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AccessRequest extends Model
{
    use HasFactory, HasUlids;

    protected $fillable = [
        'target_user_id',
        'role_id',
        'company_id',
        'department_id',
        'location_id',
        'requested_by',
        'decided_by',
        'status',
        'reason',
        'requested_valid_until',
        'decided_at',
        'decision_note',
    ];

    protected function casts(): array
    {
        return [
            'requested_valid_until' => 'datetime',
            'decided_at' => 'datetime',
        ];
    }
}
