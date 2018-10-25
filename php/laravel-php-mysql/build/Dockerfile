FROM php:7.2
MAINTAINER oraclegao@126.com

USER root

RUN set -ex \
    && apt-get update

RUN set -ex \
    && apt-get install --no-install-recommends --no-install-suggests -y \
       git \
       unzip \
       zip \
       zlib1g-dev

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
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && docker-php-ext-enable zip \
    && docker-php-source delete

RUN set -ex \
    && php -r"copy('https://getcomposer.org/installer','composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \

RUN set -ex \ 
    && apt-get remove --purge --auto-remove -y \
       zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*
