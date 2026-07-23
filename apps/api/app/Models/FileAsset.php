<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUlids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class FileAsset extends Model
{
    use HasUlids;

    protected $table = 'files';

    protected $hidden = ['disk', 'object_key'];

    protected $fillable = [
        'id',
        'company_id',
        'created_by',
        'purpose',
        'original_name',
        'disk',
        'object_key',
        'declared_mime_type',
        'detected_mime_type',
        'expected_size',
        'actual_size',
        'expected_checksum_sha256',
        'actual_checksum_sha256',
        'status',
        'scan_status',
        'rejection_reason',
        'attached_type',
        'attached_id',
        'attached_at',
        'pending_expires_at',
        'retention_until',
        'uploaded_at',
        'finalized_at',
        'deleted_at',
        'deleted_by',
    ];

    protected function casts(): array
    {
        return [
            'expected_size' => 'integer',
            'actual_size' => 'integer',
            'attached_at' => 'immutable_datetime',
            'pending_expires_at' => 'immutable_datetime',
            'retention_until' => 'immutable_datetime',
            'uploaded_at' => 'immutable_datetime',
            'finalized_at' => 'immutable_datetime',
            'deleted_at' => 'immutable_datetime',
        ];
    }

    public function company(): BelongsTo
    {
        return $this->belongsTo(Company::class);
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}
