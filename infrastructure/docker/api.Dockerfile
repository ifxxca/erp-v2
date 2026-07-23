FROM php:8.5-cli

RUN apt-get update \
    && apt-get install -y --no-install-recommends libpq-dev libzip-dev unzip \
    && docker-php-ext-install -j$(nproc) pcntl pdo_pgsql zip \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && rm -rf /var/lib/apt/lists/* /tmp/pear

COPY --from=composer:2.8 /usr/bin/composer /usr/bin/composer

WORKDIR /app

EXPOSE 8000

# Run PHP's development server directly. `artisan serve` starts a child process
# from PHP's `$_ENV`, which can omit Docker-provided variables and make HTTP
# requests fall back to the bind-mounted `.env` file instead of Compose values.
CMD ["sh", "-c", "cd public && exec php -S 0.0.0.0:8000 ../vendor/laravel/framework/src/Illuminate/Foundation/resources/server.php"]
