$ErrorActionPreference = 'Stop'

Push-Location $PSScriptRoot
try {
    docker compose --env-file .env.example exec -T postgres dropdb -U rajawali --if-exists rajawali_v2_test
    if ($LASTEXITCODE -ne 0) { throw 'Unable to reset the PostgreSQL test database.' }

    docker compose --env-file .env.example exec -T postgres createdb -U rajawali rajawali_v2_test
    if ($LASTEXITCODE -ne 0) { throw 'Unable to create the PostgreSQL test database.' }

    docker compose --env-file .env.example exec -T `
        -e DB_CONNECTION=pgsql `
        -e DB_DATABASE=rajawali_v2_test `
        -e QUEUE_CONNECTION=sync `
        -e CACHE_STORE=array `
        -e SESSION_DRIVER=array `
        -e FILESYSTEM_DISK=local `
        -e FILES_SCAN_DRIVER=skipped `
        -e FILES_ALLOW_UNSCANNED=true `
        -e MAIL_MAILER=array `
        -e LOG_CHANNEL=null `
        api vendor/bin/phpunit --colors=never
    if ($LASTEXITCODE -ne 0) { throw 'PostgreSQL API tests failed.' }
} finally {
    Pop-Location
}
