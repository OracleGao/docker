#!/usr/bin/env bash
set -ex
cd ${0%/*}

source ./env
docker-compose stop
