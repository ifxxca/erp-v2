<?php

namespace App\Modules\Files\Infrastructure;

use App\Modules\Files\Application\FileScanner;
use App\Modules\Files\Application\FileScanResult;

class SkippedFileScanner implements FileScanner
{
    public function scan($stream): FileScanResult
    {
        return FileScanResult::skipped('Malware scanning is explicitly disabled in this environment.');
    }
}
