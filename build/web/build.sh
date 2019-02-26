#!/usr/bin/env bash
cd ${0%/*}

set -ex

. ./.build

docker run --rm -it -v ~/.npm:/root/.npm -v $(pwd):/usr/src -e TZ=Asia/Shanghai -v /etc/localtime:/etc/localtime:ro -w /usr/src ${DOCKER_IMAGE_BUILD} yarn install

#docker run --rm -it -d -p 8101:8101 -v ~/.npm:/root/.npm -v $(pwd):/usr/src -e TZ=Asia/Shanghai -v /etc/localtime:/etc/localtime:ro -w /usr/src ${DOCKER_IMAGE_BUILD} yarn run dev

docker run --rm -it -v ~/.npm:/root/.npm -v $(pwd):/usr/src -e TZ=Asia/Shanghai -v /etc/localtime:/etc/localtime:ro -w /usr/src ${DOCKER_IMAGE_BUILD} yarn run build


SERVICE_VERSION=$(cat package.json  | grep version | awk -F '"' '{print$4}')

docker build -t ${SERVICE_NAME}:${SERVICE_VERSION} -f Dockerfile .

