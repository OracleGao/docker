#!/usr/bin/env bash
cd ${0%/*}

mkdir -p data
mkdir -p src

export SCRAPYD_HOST=8888
source ./env

docker-compose stop scrapyd
docker-compose up -d scrapyd
