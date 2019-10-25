#!/usr/bin/env bash
cd ${0%/*}

set -ex

source ./.build

docker run --rm -v ~/.m2/repository:/root/.m2/repository -v $(pwd):/usr/src -e TZ=Asia/Shanghai -v /etc/localtime:/etc/localtime:ro -w /usr/src --entrypoint="/usr/src/.dc-build.sh" ${DOCKER_IMAGE_BUILD}


docker build -t ${SERVICE_NAME}:${SERVICE_VERSION} .

rm -rf runnable.jar

if [ "$1" == "-d" ]; then
  docker run -it --rm -e JAVA_OPTS="-Xms256m -Xmx256m -Xss1024K -XX:MetaspaceSize=64m -XX:MaxMetaspaceSize=64m" ${SERVICE_NAME}:${SERVICE_VERSION}
fi
