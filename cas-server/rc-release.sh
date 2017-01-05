#!/usr/bin/env bash
cd ${0%/*}

echo "wait for releasing..."
source ./env

docker tag ${RC_BUILD_DOCKER_IMAGE} ${RC_RELEASE_DOCKER_IMAGE}
docker push ${RC_RELEASE_DOCKER_IMAGE}
