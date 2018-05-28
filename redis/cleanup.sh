#!/usr/bin/env bash
cd ${0%/*}

source ./env
docker-compose stop
docker-compose rm -f
