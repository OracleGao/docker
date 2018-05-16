#!/usr/bin/env bash
cd ${0%/*}

source ./env

mkdir -p ${LOG_PATH}
mkdir -p ${WWW_PATH}

docker-compose stop
docker-compose up -d
