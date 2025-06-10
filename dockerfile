# Base image to run
FROM php:8.3.9-cli-alpine3.20

# Update alpine image and install packeges
RUN apk --update --no-cache add curl \
    zip \
    unzip \
    vim \
    libzip \
    libzip-dev \
    libpq-dev \
    libpng-dev \
    oniguruma-dev \
    linux-headers \
    git \
    lynx \
    nodejs \
    npm \
    postgresql-client

# Install packages to run PHP/laravel and our app
RUN apk --update --no-cache add php83-bcmath \
    php83-bz2 \
    php83-calendar \
    php83-exif \
    php83-gettext \
    php83-opcache \
    php83-pcntl \
    php83-zip \
    php83-pgsql

# Install extensions for PHP
RUN docker-php-ext-install \
    pdo \
    pdo_pgsql \
    exif

# Use php.ini-production as php.ini and add extra.ini
RUN ln -s /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
COPY ./docker/php/extra.ini /usr/local/etc/php/conf.d/99_extra.ini

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Workdir
WORKDIR /usr/local/bin/app

# Copy source files and create .env using .env.example
COPY . ./
COPY .env.example .env
COPY ./docker/entrypoint.sh ./

# Criando um Database SQLite vazio
RUN touch database/database.sqlite
RUN chmod 777 database/database.sqlite

# Update composer optimizing autoload with no dev dependencies
RUN composer update -o --no-dev --with-all-dependencies

# Generate laravel key
RUN php artisan key:generate

# Build frontend using npm
RUN npm install
RUN npm run build

# Change application to production
RUN sed -i 's/APP_ENV=local/APP_ENV=production/g' .env
RUN sed -i 's/APP_DEBUG=true/APP_DEBUG=false/g' .env
RUN chmod 755 entrypoint.sh

# Expose port
EXPOSE 8000

# Run using this command
# CMD [ "php", "artisan", "serve", "--host=0.0.0.0", "--port=8000" ]
ENTRYPOINT ["./entrypoint.sh"]
