FROM python:3.6-alpine 
MAINTAINER oraclegao@126.com

USER root

RUN set -ex \
    && apk add --no-cache \
    zlib \
    libffi \
    libxml2 \
    openssl \
    libxslt \
    tiff

RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
               bash \
               curl \
               git \
               gcc \
               g++ \
               make \
               libc-dev \
               zlib-dev \
               libffi-dev \
               libxml2-dev \
               openssl-dev \
               libxslt-dev \
               tiff-dev \
    && ln -s /usr/include/libxml2/libxml /usr/include/libxml

RUN set -ex \
    && pip install scrapy \
                   scrapyd \
                   scrapyd-client \
                   scrapy-splash \
                   scrapyrt \
                   Pillow
RUN set -ex \
    && mkdir -p /usr/src \
    && cd /usr/src \
    && git clone https://github.com/edenhill/librdkafka.git \
    && cd librdkafka \
    && ./configure && make && make install \
    && pip install confluent-kafka

RUN set -ex \
    && rm -rf /usr/src/librdkafka \
    && rm -rf /usr/include/libxml \
    && apk del .build-deps

COPY ./scrapyd.conf /etc/scrapyd/

EXPOSE 6800

CMD ["scrapyd", "--pidfile="]
