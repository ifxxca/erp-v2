<?php

namespace App\Modules\Files\Application;

interface FileScanner
{
    /** @param resource $stream */
    public function scan($stream): FileScanResult;
}
