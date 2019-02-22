#!/usr/bin/env bash
cd ${0%/*}

set -ex

. ./.build

echo "export SERVICE_NAME=${SERVICE_NAME}" > .dc-build

docker run --rm -v ~/.m2/repository:/root/.m2/repository -v $(pwd):/usr/src -e TZ=Asia/Shanghai -v /etc/localtime:/etc/localtime:ro -w /usr/src --entrypoint="/usr/src/.dc-build.sh" ${DOCKER_IMAGE_BUILD}

. ./.dc-build

docker build -t ${SERVICE_NAME}:${SERVICE_VERSION} .

rm -rf runnable.jar
rm -rf .dc-build

if [ "$1" == "-d" ]; then
  docker run --rm -e JAVA_OPTS="-Xms256m -Xmx256m -Xss1024K -XX:MetaspaceSize=64m -XX:MaxMetaspaceSize=64m" ${SERVICE_NAME}:${SERVICE_VERSION}
fi
