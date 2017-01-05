#!/usr/bin/env bash
cd ${0%/*}

source ./env

docker-compose stop ${DEV_DOCKER_COMPOSE_SERVICE}
