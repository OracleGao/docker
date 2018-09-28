#!/usr/bin/env bash
cd ${0%/*}

source ./env

docker-compose up -d php-laravel
