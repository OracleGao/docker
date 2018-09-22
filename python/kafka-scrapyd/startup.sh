#!/usr/bin/env bash
cd ${0%/*}

mkdir -p data

source ./env

docker-compose stop scrapyd
docker-compose up -d scrapyd
