<?php

namespace Tests\Unit;

use App\Models\Company;
use App\Modules\Documents\Application\DocumentNumberingException;
use App\Modules\Documents\Application\DocumentNumberService;
use Carbon\CarbonImmutable;
use Illuminate\Support\Str;
use Tests\TestCase;

class DocumentNumberTransactionGuardTest extends TestCase
{
    public function test_allocation_requires_an_owning_domain_transaction(): void
    {
        $company = new Company(['code' => 'RKS', 'legal_name' => 'PT Rajawali Kreatif Sentosa']);
        $company->id = (string) Str::ulid();

        try {
            app(DocumentNumberService::class)->allocate(
                $company,
                'maintenance.work_order',
                'maintenance.work_order',
                (string) Str::ulid(),
                CarbonImmutable::parse('2026-07-23', 'Asia/Jakarta'),
            );
            $this->fail('Allocation outside an owning domain transaction must fail.');
        } catch (DocumentNumberingException $exception) {
            $this->assertSame('DOCUMENT_SEQUENCE_TRANSACTION_REQUIRED', $exception->errorCode);
        }
    }
}
