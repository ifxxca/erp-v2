<?php

namespace App\Modules\Files\Application;

final readonly class FileScanResult
{
    private function __construct(
        public string $status,
        public ?string $detail = null,
    ) {}

    public static function clean(): self
    {
        return new self('clean');
    }

    public static function infected(string $detail): self
    {
        return new self('infected', $detail);
    }

    public static function skipped(string $detail): self
    {
        return new self('skipped', $detail);
    }
}
