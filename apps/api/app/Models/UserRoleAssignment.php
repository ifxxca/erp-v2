<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class UserRoleAssignment extends Model
{
    use HasFactory, HasUlids;

    protected $fillable = [
        'user_id',
        'role_id',
        'company_id',
        'department_id',
        'location_id',
        'access_request_id',
        'valid_from',
        'valid_until',
        'assigned_by',
        'revoked_at',
        'revoked_by',
        'revocation_reason',
    ];

    protected function casts(): array
    {
        return [
            'valid_from' => 'datetime',
            'valid_until' => 'datetime',
            'revoked_at' => 'datetime',
        ];
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query
            ->whereNull('revoked_at')
            ->where('valid_from', '<=', now())
            ->where(fn (Builder $query) => $query
                ->whereNull('valid_until')
                ->orWhere('valid_until', '>', now()));
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function role(): BelongsTo
    {
        return $this->belongsTo(Role::class);
    }

    public function assignedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'assigned_by');
    }

    public function revokedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'revoked_by');
    }

    public function company(): BelongsTo
    {
        return $this->belongsTo(Company::class);
    }

    public function department(): BelongsTo
    {
        return $this->belongsTo(Department::class);
    }

    public function location(): BelongsTo
    {
        return $this->belongsTo(Location::class);
    }

    public function accessRequest(): BelongsTo
    {
        return $this->belongsTo(AccessRequest::class);
    }
}
