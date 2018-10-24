FROM php:7.2.5-fpm
MAINTAINER oraclegao@126.com

USER root

RUN set -ex \
    && docker-php-source extract \
    && docker-php-ext-configure pdo \
    && docker-php-ext-install pdo \
    && docker-php-ext-enable pdo \
    && docker-php-ext-configure mysqli \
    && docker-php-ext-install mysqli \
    && docker-php-ext-enable mysqli \
    && docker-php-ext-configure pdo_mysql \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-enable pdo_mysql \
    && docker-php-source delete

RUN set -ex \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
       git \
       unzip \
       zip \
    && php -r"copy('https://getcomposer.org/installer','composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    && apt-get remove --purge --auto-remove -y \
    && rm -rf /var/lib/apt/lists/*
