#!/usr/bin/env bash
cd ${0%/*}

source ./env

./rc-build.sh
./dev-stop.sh
docker-compose up -d ${RC_DOCKER_COMPOSE_SERVICE}
