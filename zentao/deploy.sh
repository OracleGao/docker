#!/usr/bin/env bash
cd ${0%/*}

source ./env

mkdir -p ${DATA_PATH}

docker-compose stop
docker-compose up -d
