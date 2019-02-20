FROM python:3.7-alpine 
MAINTAINER oraclegao@126.com

USER root

RUN apk add --no-cache \
		gcc \
                libc-dev \
                make \
                curl \
                git \
                openssl \
                openssl-dev \
                libffi-dev \
                jpeg-dev \
                zlib-dev

RUN pip install --upgrade pip

RUN pip3 install sanic 

COPY requirements.txt .
RUN pip3 install -r requirements.txt
RUN rm -rf requirements.txt

EXPOSE 8000
