#!/usr/bin/env bash
cd ${0%/*}

source ./env
./rc-stop.sh
docker-compose up -d ${DEV_DOCKER_COMPOSE_SERVICE}
