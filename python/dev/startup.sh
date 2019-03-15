#!/usr/bin/env bash
cd ${0%/*}

source ./env

IMAGE_NAME=${BASE_IMAGE//:*}
IMAGE_VERSION=${BASE_IMAGE//*:}

imageFlag=$(docker images | grep ${IMAGE_NAME} | grep ${IMAGE_VERSION} | wc -l)

if [ "${imageFlag}" == "0" ]; then
  ./build.sh
fi

docker-compose stop
docker-compose up -d
