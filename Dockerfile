FROM php:7.2-fpm

LABEL maintainer = "Armin Felder(https://github.com/arminfelder)"

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        mcrypt \
        libcurl4-openssl-dev \
        libevent-dev \
        libicu-dev \
        libjpeg-dev \
        libldap2-dev \
        libmemcached-dev \
        libpq-dev \
        libxml2-dev \
        libmagickwand-dev \
        libzip-dev \
        libwebp-dev \
    && docker-php-ext-install -j$(nproc) iconv\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure ldap \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-install -j$(nproc) soap \
    && docker-php-ext-install -j$(nproc) zip\
    && docker-php-ext-install -j$(nproc) pdo_mysql\
    && docker-php-ext-install -j$(nproc) pdo_pgsql\
    && docker-php-ext-install -j$(nproc) exif\
    && docker-php-ext-install -j$(nproc) ldap\
    && docker-php-ext-install -j$(nproc) opcache\
    && docker-php-ext-install -j$(nproc) pcntl\
    && docker-php-ext-install -j$(nproc) intl\
    && docker-php-ext-install -j$(nproc) bz2\
    && apt clean \
    && pecl install APCu-5.1.17; \
    pecl install memcached-3.1.3; \
    pecl install redis-4.3.0; \
    pecl install imagick-3.4.4; \
    docker-php-ext-enable \
        apcu \
        memcached \
        redis \
        imagick \
    ;

USER www-data

VOLUME /var/www/

EXPOSE 9000

CMD ["php-fpm"]
