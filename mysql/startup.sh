#!/usr/bin/env bash
set -ex
source ./env
docker-compose stop
docker-compose up -d
