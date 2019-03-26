#!/usr/bin/env bash
cd ${0%/*}

source ../env

cmd="docker run --rm ${DOCKER_IMAGE_KAFKA}"

topicCmd="$cmd kafka-topics.sh"

topicCreateCmd="${topicCmd} --create --zookeeper ${HOST_NAME}:${ZOOKEEPER_PORT} --if-not-exists --topic"

$topicCreateCmd cw-test --partitions 1 --replication-factor 1

