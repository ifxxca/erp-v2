<?php

namespace App\Modules\Files\Infrastructure;

use App\Modules\Files\Application\FileScanner;
use App\Modules\Files\Application\FileScanResult;
use RuntimeException;

class ClamAvFileScanner implements FileScanner
{
    public function scan($stream): FileScanResult
    {
        $host = (string) config('files.clamav.host');
        $port = (int) config('files.clamav.port');
        $timeout = (int) config('files.clamav.timeout_seconds');
        $socket = @stream_socket_client("tcp://{$host}:{$port}", $errorCode, $errorMessage, $timeout);

        if (! is_resource($socket)) {
            throw new RuntimeException("ClamAV is unavailable: {$errorMessage} ({$errorCode}).");
        }

        stream_set_timeout($socket, $timeout);
        $this->writeAll($socket, "zINSTREAM\0");

        while (! feof($stream)) {
            $chunk = fread($stream, 8192);
            if ($chunk === false) {
                fclose($socket);
                throw new RuntimeException('Unable to read the stored file for malware scanning.');
            }
            if ($chunk !== '') {
                $this->writeAll($socket, pack('N', strlen($chunk)).$chunk);
            }
        }

        $this->writeAll($socket, pack('N', 0));
        $response = stream_get_contents($socket);
        $metadata = stream_get_meta_data($socket);
        fclose($socket);

        if ($metadata['timed_out'] || ! is_string($response) || $response === '') {
            throw new RuntimeException('ClamAV did not return a scan result.');
        }
        if (str_contains($response, ' FOUND')) {
            return FileScanResult::infected(trim($response));
        }
        if (str_contains($response, ' OK')) {
            return FileScanResult::clean();
        }

        throw new RuntimeException('ClamAV scan failed: '.trim($response));
    }

    /** @param resource $socket */
    private function writeAll($socket, string $payload): void
    {
        $offset = 0;
        while ($offset < strlen($payload)) {
            $written = fwrite($socket, substr($payload, $offset));
            if ($written === false || $written === 0) {
                throw new RuntimeException('Connection to ClamAV was interrupted.');
            }
            $offset += $written;
        }
    }
}
