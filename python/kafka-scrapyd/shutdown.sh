#!/usr/bin/env bash
set -ex
cd ${0%/*}

source ./env
echo $SCRAPYD_DIR
docker-compose stop
