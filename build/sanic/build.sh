#!/usr/bin/env bash
cd ${0%/*}

set -ex

source .build

SERVICE_VERSION=$(cat ./version)

docker build -t ${SERVICE_NAME}:${SERVICE_VERSION} .

if [ "$1" == "-d" ]; then
  docker run --rm -it ${SERVICE_NAME}:${SERVICE_VERSION} 
fi
