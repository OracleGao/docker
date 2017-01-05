#!/usr/bin/env bash
cd ${0%/*}

source env
docker-compose restart ${DEV_DOCKER_COMPOSE_SERVICE}
