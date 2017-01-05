#!/usr/bin/env bash
cd ${0%/*}

source ./env
./dev-stop.sh
./rc-stop.sh
docker-compose up -d ${DEV_DOCKER_COMPOSE_SERVICE}
