#!/usr/bin/env bash
cd ${0%/*}

set -ex

. ./.build

docker run --rm -v $(pwd):/usr/src -e TZ=Asia/Shanghai -v /etc/localtime:/etc/localtime:ro -w /usr/src ${DOCKER_IMAGE_BUILD} composer install

SERVICE_VERSION=$(cat version)

docker build -t ${SERVICE_NAME}-laravel:${SERVICE_VERSION} -f Dockerfile.laravel .

docker build -t ${SERVICE_NAME}-nginx:${SERVICE_VERSION} -f Dockerfile.nginx .

