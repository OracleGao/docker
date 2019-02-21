#!/usr/bin/env bash
set -ex

. ./.dc-build

SERVICE_VERSION=$(mvn help:evaluate -Dexpression=project.build.finalName | grep ${SERVICE_NAME} | grep -v "^\[INFO]")
SERVICE_VERSION=${SERVICE_VERSION##*${SERVICE_NAME}-}

echo "export SERVICE_VERSION=${SERVICE_VERSION}" >> .dc-build

jarName=${SERVICE_NAME}-${SERVICE_VERSION}.jar
mvn install -Dskip.test=true -Dmaven.test.skip=true

cp ./target/${jarName} runnable.jar

mvn clean

