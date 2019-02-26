#!/usr/bin/env bash
cd ${0%/*}

set -ex

source ./.build

docker build -t ${DOCKER_IMAGE_BUILD} -f Dockerfile.base .

