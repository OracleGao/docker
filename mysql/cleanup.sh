#!/usr/bin/env bash
set -ex
cd ${0%/*}

source ./env
docker-compose stop
docker-compose rm -f
rm -rf ${DATA_PATH}
