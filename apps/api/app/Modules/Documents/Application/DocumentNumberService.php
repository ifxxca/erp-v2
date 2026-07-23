<?php

namespace App\Modules\Documents\Application;

use App\Models\Company;
use App\Models\DocumentNumberAllocation;
use App\Models\DocumentSequenceRule;
use App\Models\Location;
use App\Models\User;
use App\Modules\Identity\Application\AuditLogger;
use Carbon\CarbonImmutable;
use DateTimeInterface;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class DocumentNumberService
{
    private const GLOBAL_SCOPE = 'GLOBAL';

    private const ALLOWED_PLACEHOLDERS = [
        'COMPANY',
        'LOCATION',
        'TYPE',
        'YYYY',
        'YY',
        'MM',
        'DD',
        'PERIOD',
        'SEQ',
    ];

    public function __construct(private readonly AuditLogger $audit) {}

    public function allocate(
        Company $company,
        string $documentType,
        string $subjectType,
        string $subjectId,
        DateTimeInterface $documentDate,
        ?Location $location = null,
        ?User $actor = null,
        ?Request $request = null,
    ): DocumentNumberAllocation {
        if (DB::transactionLevel() < 1) {
            throw new DocumentNumberingException(
                'Document numbers must be allocated inside the owning domain transaction.',
                'DOCUMENT_SEQUENCE_TRANSACTION_REQUIRED',
            );
        }
        $this->assertIdentifier($documentType, 'document type');
        $this->assertIdentifier($subjectType, 'subject type');
        if (! Str::isUlid($subjectId)) {
            throw new DocumentNumberingException('Subject ID must be a ULID.', 'DOCUMENT_SEQUENCE_SUBJECT_INVALID');
        }
        if ($location !== null && $location->company_id !== $company->id) {
            throw new DocumentNumberingException(
                'Sequence location does not belong to the requested company.',
                'DOCUMENT_SEQUENCE_LOCATION_INVALID',
            );
        }

        $existing = DocumentNumberAllocation::query()
            ->where('company_id', $company->id)
            ->where('document_type', $documentType)
            ->where('subject_type', $subjectType)
            ->where('subject_id', $subjectId)
            ->first();
        if ($existing !== null) {
            $existingDate = CarbonImmutable::instance($documentDate)
                ->setTimezone($existing->rule->timezone)
                ->toDateString();
            if ($existing->location_id !== $location?->id
                || $existing->document_date->toDateString() !== $existingDate) {
                throw new DocumentNumberingException(
                    'The subject already has a document number with a different location or document date.',
                    'DOCUMENT_SEQUENCE_SUBJECT_MISMATCH',
                );
            }

            return $existing;
        }

        $rule = $this->resolveRule($company, $documentType, $documentDate, $location);
        $this->validateRule($rule, $location);
        $localDate = CarbonImmutable::instance($documentDate)->setTimezone($rule->timezone);
        $periodKey = $this->periodKey($rule->period, $localDate);
        $sequence = $this->increment($rule, $periodKey);
        $number = $this->format($rule, $company, $location, $localDate, $periodKey, $sequence);

        $allocation = DocumentNumberAllocation::query()->create([
            'company_id' => $company->id,
            'location_id' => $location?->id,
            'rule_id' => $rule->id,
            'rule_version' => $rule->version,
            'document_type' => $documentType,
            'subject_type' => $subjectType,
            'subject_id' => $subjectId,
            'period_key' => $periodKey,
            'sequence_value' => $sequence,
            'document_number' => $number,
            'document_date' => $localDate->toDateString(),
            'allocated_by' => $actor?->id,
            'allocated_at' => now(),
        ]);
        $this->audit->record('document.number_allocated', $actor, $allocation, [
            'company_id' => $company->id,
            'location_id' => $location?->id,
            'document_type' => $documentType,
            'subject_type' => $subjectType,
            'subject_id' => $subjectId,
            'rule_id' => $rule->id,
            'rule_version' => $rule->version,
            'period_key' => $periodKey,
            'sequence_value' => $sequence,
        ], $request);

        return $allocation;
    }

    private function resolveRule(
        Company $company,
        string $documentType,
        DateTimeInterface $documentDate,
        ?Location $location,
    ): DocumentSequenceRule {
        $scopes = $location === null ? [self::GLOBAL_SCOPE] : [$location->id, self::GLOBAL_SCOPE];

        foreach ($scopes as $scope) {
            $rules = DocumentSequenceRule::query()
                ->where('company_id', $company->id)
                ->where('scope_key', $scope)
                ->where('document_type', $documentType)
                ->orderByDesc('version')
                ->get();
            foreach ($rules as $rule) {
                if (! in_array($rule->timezone, timezone_identifiers_list(), true)) {
                    throw new DocumentNumberingException(
                        'Document sequence timezone is not a valid IANA timezone.',
                        'DOCUMENT_SEQUENCE_TIMEZONE_INVALID',
                    );
                }
                $localDate = CarbonImmutable::instance($documentDate)->setTimezone($rule->timezone)->toDateString();
                if ($rule->effective_from->toDateString() <= $localDate
                    && ($rule->effective_until === null || $rule->effective_until->toDateString() >= $localDate)) {
                    return $rule;
                }
            }
        }

        throw new DocumentNumberingException(
            'No effective document sequence rule exists for this scope and date.',
            'DOCUMENT_SEQUENCE_RULE_NOT_FOUND',
        );
    }

    private function increment(DocumentSequenceRule $rule, string $periodKey): int
    {
        $timestamp = now()->format('Y-m-d H:i:s.uP');
        $row = DB::selectOne(
            <<<'SQL'
                INSERT INTO document_sequences (id, rule_id, period_key, last_value, created_at, updated_at)
                VALUES (?, ?, ?, 1, ?, ?)
                ON CONFLICT (rule_id, period_key)
                DO UPDATE SET
                    last_value = document_sequences.last_value + 1,
                    updated_at = excluded.updated_at
                RETURNING last_value
            SQL,
            [(string) Str::ulid(), $rule->id, $periodKey, $timestamp, $timestamp],
        );

        if (! is_object($row) || ! isset($row->last_value)) {
            throw new DocumentNumberingException(
                'The database did not return an allocated sequence value.',
                'DOCUMENT_SEQUENCE_ALLOCATION_FAILED',
            );
        }

        return (int) $row->last_value;
    }

    private function format(
        DocumentSequenceRule $rule,
        Company $company,
        ?Location $location,
        CarbonImmutable $date,
        string $periodKey,
        int $sequence,
    ): string {
        $number = strtr($rule->pattern, [
            '{COMPANY}' => $company->code,
            '{LOCATION}' => $location?->code ?? '',
            '{TYPE}' => $rule->type_code,
            '{YYYY}' => $date->format('Y'),
            '{YY}' => $date->format('y'),
            '{MM}' => $date->format('m'),
            '{DD}' => $date->format('d'),
            '{PERIOD}' => $periodKey,
            '{SEQ}' => str_pad((string) $sequence, $rule->padding, '0', STR_PAD_LEFT),
        ]);

        if (strlen($number) > 191) {
            throw new DocumentNumberingException(
                'The generated document number exceeds 191 characters.',
                'DOCUMENT_SEQUENCE_NUMBER_TOO_LONG',
            );
        }

        return $number;
    }

    private function periodKey(string $period, CarbonImmutable $date): string
    {
        return match ($period) {
            'none' => 'ALL',
            'yearly' => $date->format('Y'),
            'monthly' => $date->format('Y-m'),
            'daily' => $date->format('Y-m-d'),
            default => throw new DocumentNumberingException(
                'Document sequence period must be none, yearly, monthly, or daily.',
                'DOCUMENT_SEQUENCE_PERIOD_INVALID',
            ),
        };
    }

    private function validateRule(DocumentSequenceRule $rule, ?Location $location): void
    {
        if ($rule->padding < 1 || $rule->padding > 12) {
            throw new DocumentNumberingException(
                'Document sequence padding must be between 1 and 12.',
                'DOCUMENT_SEQUENCE_PADDING_INVALID',
            );
        }
        if (preg_match('/^[A-Z0-9-]{1,24}$/', $rule->type_code) !== 1) {
            throw new DocumentNumberingException(
                'Document sequence type code must use 1-24 uppercase letters, digits, or hyphens.',
                'DOCUMENT_SEQUENCE_TYPE_CODE_INVALID',
            );
        }
        if (! in_array($rule->timezone, timezone_identifiers_list(), true)) {
            throw new DocumentNumberingException(
                'Document sequence timezone is not a valid IANA timezone.',
                'DOCUMENT_SEQUENCE_TIMEZONE_INVALID',
            );
        }
        if (preg_match('/^[A-Z0-9{}._\/-]+$/', $rule->pattern) !== 1) {
            throw new DocumentNumberingException(
                'Document sequence pattern contains unsupported characters.',
                'DOCUMENT_SEQUENCE_PATTERN_INVALID',
            );
        }
        preg_match_all('/\{([A-Z_]+)\}/', $rule->pattern, $matches);
        $unknown = array_diff($matches[1], self::ALLOWED_PLACEHOLDERS);
        if ($unknown !== [] || ! str_contains($rule->pattern, '{SEQ}')) {
            throw new DocumentNumberingException(
                'Document sequence pattern contains an unknown placeholder or omits {SEQ}.',
                'DOCUMENT_SEQUENCE_PATTERN_INVALID',
            );
        }
        if (str_contains($rule->pattern, '{LOCATION}') && $location === null) {
            throw new DocumentNumberingException(
                'A location placeholder requires a location-scoped allocation.',
                'DOCUMENT_SEQUENCE_LOCATION_REQUIRED',
            );
        }
        $hasPeriodToken = str_contains($rule->pattern, '{PERIOD}');
        $hasYear = str_contains($rule->pattern, '{YYYY}') || str_contains($rule->pattern, '{YY}');
        $hasMonth = str_contains($rule->pattern, '{MM}');
        $hasDay = str_contains($rule->pattern, '{DD}');
        $periodRepresented = match ($rule->period) {
            'none' => true,
            'yearly' => $hasPeriodToken || $hasYear,
            'monthly' => $hasPeriodToken || ($hasYear && $hasMonth),
            'daily' => $hasPeriodToken || ($hasYear && $hasMonth && $hasDay),
            default => false,
        };
        if (! $periodRepresented) {
            throw new DocumentNumberingException(
                'The pattern must represent its reset period to prevent duplicate numbers.',
                'DOCUMENT_SEQUENCE_PERIOD_PATTERN_INVALID',
            );
        }
    }

    private function assertIdentifier(string $value, string $label): void
    {
        if (preg_match('/^[a-z][a-z0-9_.-]{2,99}$/', $value) !== 1) {
            throw new DocumentNumberingException(
                ucfirst($label).' must be a stable lowercase identifier.',
                'DOCUMENT_SEQUENCE_IDENTIFIER_INVALID',
            );
        }
    }
}
