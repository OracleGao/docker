FROM python:3.7-alpine 
MAINTAINER oraclegao@126.com

USER root

# RUN apk add --no-cache --virtual .build-deps \
#		gcc \
#                libc-dev \
#                make
RUN apk add gcc
RUN apk add libc-dev
RUN apk add make

RUN pip3 install sanic    
# RUN apk del .build-deps

EXPOSE 8000
