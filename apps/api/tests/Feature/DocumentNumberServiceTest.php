<?php

namespace Tests\Feature;

use App\Models\Company;
use App\Models\DocumentSequence;
use App\Models\DocumentSequenceRule;
use App\Models\Location;
use App\Models\User;
use App\Modules\Documents\Application\DocumentNumberingException;
use App\Modules\Documents\Application\DocumentNumberService;
use Carbon\CarbonImmutable;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use LogicException;
use RuntimeException;
use Tests\TestCase;

class DocumentNumberServiceTest extends TestCase
{
    use RefreshDatabase;

    public function test_allocation_is_atomic_sequential_audited_and_idempotent_per_subject(): void
    {
        $company = $this->company('RKS');
        $actor = User::factory()->create();
        $rule = $this->rule($company);
        $service = app(DocumentNumberService::class);
        $date = CarbonImmutable::parse('2026-07-23', 'Asia/Jakarta');
        $firstSubject = (string) Str::ulid();

        [$first, $second, $replayed] = DB::transaction(fn () => [
            $service->allocate($company, 'maintenance.work_order', 'maintenance.work_order', $firstSubject, $date, actor: $actor),
            $service->allocate($company, 'maintenance.work_order', 'maintenance.work_order', (string) Str::ulid(), $date, actor: $actor),
            $service->allocate($company, 'maintenance.work_order', 'maintenance.work_order', $firstSubject, $date, actor: $actor),
        ]);

        $this->assertSame('WO/RKS/2026/07/0001', $first->document_number);
        $this->assertSame(1, $first->rule_version);
        $this->assertSame('WO/RKS/2026/07/0002', $second->document_number);
        $this->assertTrue($first->is($replayed));
        $this->assertDatabaseCount('document_number_allocations', 2);
        $this->assertSame(2, DocumentSequence::query()->where('rule_id', $rule->id)->value('last_value'));
        $this->assertSame(2, DB::table('audit_logs')->where('event', 'document.number_allocated')->count());
    }

    public function test_rolled_back_domain_transaction_does_not_consume_a_number(): void
    {
        $company = $this->company('RKS');
        $this->rule($company);
        $service = app(DocumentNumberService::class);
        $date = CarbonImmutable::parse('2026-07-23', 'Asia/Jakarta');

        try {
            DB::transaction(function () use ($service, $company, $date): void {
                $service->allocate(
                    $company,
                    'maintenance.work_order',
                    'maintenance.work_order',
                    (string) Str::ulid(),
                    $date,
                );
                throw new RuntimeException('Simulated owning-domain failure.');
            });
            $this->fail('The simulated domain transaction should fail.');
        } catch (RuntimeException $exception) {
            $this->assertSame('Simulated owning-domain failure.', $exception->getMessage());
        }

        $allocation = DB::transaction(fn () => $service->allocate(
            $company,
            'maintenance.work_order',
            'maintenance.work_order',
            (string) Str::ulid(),
            $date,
        ));

        $this->assertSame(1, $allocation->sequence_value);
        $this->assertSame('WO/RKS/2026/07/0001', $allocation->document_number);
        $this->assertDatabaseCount('document_number_allocations', 1);
        $this->assertDatabaseCount('audit_logs', 1);
    }

    public function test_monthly_period_resets_without_reusing_a_formatted_number(): void
    {
        $company = $this->company('RKS');
        $this->rule($company);
        $service = app(DocumentNumberService::class);

        [$december, $january] = DB::transaction(fn () => [
            $service->allocate(
                $company,
                'maintenance.work_order',
                'maintenance.work_order',
                (string) Str::ulid(),
                CarbonImmutable::parse('2026-12-31', 'Asia/Jakarta'),
            ),
            $service->allocate(
                $company,
                'maintenance.work_order',
                'maintenance.work_order',
                (string) Str::ulid(),
                CarbonImmutable::parse('2027-01-01', 'Asia/Jakarta'),
            ),
        ]);

        $this->assertSame(1, $december->sequence_value);
        $this->assertSame('2026-12', $december->period_key);
        $this->assertSame('WO/RKS/2026/12/0001', $december->document_number);
        $this->assertSame(1, $january->sequence_value);
        $this->assertSame('2027-01', $january->period_key);
        $this->assertSame('WO/RKS/2027/01/0001', $january->document_number);
        $this->assertDatabaseCount('document_sequences', 2);
    }

    public function test_location_rule_takes_precedence_and_global_rule_is_the_fallback(): void
    {
        $company = $this->company('RKS');
        $kresek = $this->location($company, 'KRESEK');
        $other = $this->location($company, 'OTHER');
        $this->rule($company, pattern: '{TYPE}/{COMPANY}/{YYYY}/{SEQ}', period: 'yearly');
        $this->rule(
            $company,
            location: $kresek,
            version: 1,
            pattern: '{TYPE}/{COMPANY}/{LOCATION}/{YYYY}/{SEQ}',
            period: 'yearly',
        );
        $service = app(DocumentNumberService::class);
        $date = CarbonImmutable::parse('2026-07-23', 'Asia/Jakarta');

        [$scoped, $fallback] = DB::transaction(fn () => [
            $service->allocate(
                $company,
                'maintenance.work_order',
                'maintenance.work_order',
                (string) Str::ulid(),
                $date,
                $kresek,
            ),
            $service->allocate(
                $company,
                'maintenance.work_order',
                'maintenance.work_order',
                (string) Str::ulid(),
                $date,
                $other,
            ),
        ]);

        $this->assertSame('WO/RKS/KRESEK/2026/0001', $scoped->document_number);
        $this->assertSame($kresek->id, $scoped->location_id);
        $this->assertSame('WO/RKS/2026/0001', $fallback->document_number);
        $this->assertSame($other->id, $fallback->location_id);
    }

    public function test_effective_dated_rule_version_preserves_historical_format(): void
    {
        $company = $this->company('RKS');
        $v1 = $this->rule($company, pattern: '{TYPE}/V1/{YYYY}/{SEQ}', period: 'yearly');
        $v2 = $this->rule(
            $company,
            version: 2,
            pattern: '{TYPE}/V2/{YYYY}/{SEQ}',
            period: 'yearly',
            effectiveFrom: '2027-01-01',
        );
        $service = app(DocumentNumberService::class);

        [$historical, $current] = DB::transaction(fn () => [
            $service->allocate(
                $company,
                'maintenance.work_order',
                'maintenance.work_order',
                (string) Str::ulid(),
                CarbonImmutable::parse('2026-12-31', 'Asia/Jakarta'),
            ),
            $service->allocate(
                $company,
                'maintenance.work_order',
                'maintenance.work_order',
                (string) Str::ulid(),
                CarbonImmutable::parse('2027-01-01', 'Asia/Jakarta'),
            ),
        ]);

        $this->assertSame($v1->id, $historical->rule_id);
        $this->assertSame('WO/V1/2026/0001', $historical->document_number);
        $this->assertSame($v2->id, $current->rule_id);
        $this->assertSame('WO/V2/2027/0001', $current->document_number);
    }

    public function test_allocated_rule_cannot_be_rewritten_in_place(): void
    {
        $company = $this->company('RKS');
        $rule = $this->rule($company);
        DB::transaction(fn () => app(DocumentNumberService::class)->allocate(
            $company,
            'maintenance.work_order',
            'maintenance.work_order',
            (string) Str::ulid(),
            CarbonImmutable::parse('2026-07-23', 'Asia/Jakarta'),
        ));

        try {
            $rule->update(['pattern' => '{TYPE}/REWRITTEN/{YYYY}/{MM}/{SEQ}']);
            $this->fail('An allocated rule must be immutable.');
        } catch (LogicException $exception) {
            $this->assertStringContainsString('publish a new version', $exception->getMessage());
        }

        $this->assertSame('{TYPE}/{COMPANY}/{YYYY}/{MM}/{SEQ}', $rule->fresh()->pattern);
    }

    public function test_subject_replay_rejects_changed_location_or_document_date(): void
    {
        $company = $this->company('RKS');
        $firstLocation = $this->location($company, 'FIRST');
        $secondLocation = $this->location($company, 'SECOND');
        $this->rule($company);
        $service = app(DocumentNumberService::class);
        $subjectId = (string) Str::ulid();
        $date = CarbonImmutable::parse('2026-07-23', 'Asia/Jakarta');
        DB::transaction(fn () => $service->allocate(
            $company,
            'maintenance.work_order',
            'maintenance.work_order',
            $subjectId,
            $date,
            $firstLocation,
        ));

        foreach ([
            [$secondLocation, $date],
            [$firstLocation, $date->addDay()],
        ] as [$location, $changedDate]) {
            try {
                DB::transaction(fn () => $service->allocate(
                    $company,
                    'maintenance.work_order',
                    'maintenance.work_order',
                    $subjectId,
                    $changedDate,
                    $location,
                ));
                $this->fail('A changed subject scope must not replay an existing allocation.');
            } catch (DocumentNumberingException $exception) {
                $this->assertSame('DOCUMENT_SEQUENCE_SUBJECT_MISMATCH', $exception->errorCode);
            }
        }

        $this->assertDatabaseCount('document_number_allocations', 1);
        $this->assertSame(1, DocumentSequence::query()->value('last_value'));
        $this->assertDatabaseCount('audit_logs', 1);
    }

    public function test_allocation_rejects_cross_company_location_and_unsafe_pattern(): void
    {
        $company = $this->company('RKS');
        $otherCompany = $this->company('SINERGI');
        $otherLocation = $this->location($otherCompany, 'OTHER');
        $this->rule($company);
        $service = app(DocumentNumberService::class);
        $date = CarbonImmutable::parse('2026-07-23', 'Asia/Jakarta');

        try {
            DB::transaction(fn () => $service->allocate(
                $company,
                'maintenance.work_order',
                'maintenance.work_order',
                (string) Str::ulid(),
                $date,
                $otherLocation,
            ));
            $this->fail('Cross-company location must fail.');
        } catch (DocumentNumberingException $exception) {
            $this->assertSame('DOCUMENT_SEQUENCE_LOCATION_INVALID', $exception->errorCode);
        }

        DocumentSequenceRule::query()->where('company_id', $company->id)->delete();
        $this->rule($company, pattern: '{TYPE}/{COMPANY}/{SEQ}', period: 'monthly');
        try {
            DB::transaction(fn () => $service->allocate(
                $company,
                'maintenance.work_order',
                'maintenance.work_order',
                (string) Str::ulid(),
                $date,
            ));
            $this->fail('A reset period omitted from the pattern must fail.');
        } catch (DocumentNumberingException $exception) {
            $this->assertSame('DOCUMENT_SEQUENCE_PERIOD_PATTERN_INVALID', $exception->errorCode);
        }

        $this->assertDatabaseCount('document_number_allocations', 0);
        $this->assertDatabaseCount('document_sequences', 0);
    }

    private function company(string $code): Company
    {
        return Company::query()->create(['code' => $code, 'legal_name' => "Company {$code}"]);
    }

    private function location(Company $company, string $code): Location
    {
        return Location::query()->create([
            'company_id' => $company->id,
            'code' => $code,
            'name' => "Location {$code}",
            'timezone' => 'Asia/Jakarta',
        ]);
    }

    private function rule(
        Company $company,
        ?Location $location = null,
        int $version = 1,
        string $pattern = '{TYPE}/{COMPANY}/{YYYY}/{MM}/{SEQ}',
        string $period = 'monthly',
        string $effectiveFrom = '2026-01-01',
    ): DocumentSequenceRule {
        return DocumentSequenceRule::query()->create([
            'company_id' => $company->id,
            'location_id' => $location?->id,
            'document_type' => 'maintenance.work_order',
            'type_code' => 'WO',
            'version' => $version,
            'pattern' => $pattern,
            'period' => $period,
            'padding' => 4,
            'timezone' => 'Asia/Jakarta',
            'effective_from' => $effectiveFrom,
        ]);
    }
}
