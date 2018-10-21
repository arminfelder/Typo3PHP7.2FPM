FROM php:7.2-fpm

LABEL maintainer = "Armin Felder(https://github.com/arminfelder)"

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        mcrypt \
    && docker-php-ext-install -j$(nproc) iconv\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) mysqli \
    && docker-php-ext-install -j$(nproc) soap \
    && docker-php-ext-install -j$(nproc) zip\
    && apt clean

VOLUME /var/www/html

EXPOSE 9000

CMD ["php-fpm"]