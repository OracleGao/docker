#!/usr/bin/env bash
cd ${0%/*}

source ./env
currectPath=$(pwd)

cp -a ${DEV_DATA_PATH}/etc ${RC_BUILD_PATH}/. 
docker cp ${RC_DOCKER_CONTAINER_NAME_DEV}:/cas-overlay/target/cas.war ${RC_BUILD_PATH}/.

cd ${RC_BUILD_PATH}
docker build -t cas:5.0.0 \
  --build-arg buildtime="$(date +"%Y-%m-%d %T")"  \
  --build-arg builder="${RC_DOCKER_IMAGE_BUILDER}" .

cd ${currentPath}

rm -rf ${RC_BUILD_PATH}/cas.war
rm -rf ${RC_BUILD_PATH}/etc

