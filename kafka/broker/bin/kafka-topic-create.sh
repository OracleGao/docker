#!/usr/bin/env bash
cd ${0%/*}

if [ $# -lt 1 ];then
  echo "Usage: $0 <topic>"
  exit 1
fi

source ../env

cmd="docker run --rm ${DOCKER_IMAGE_KAFKA}"

topicCmd="$cmd kafka-topics.sh"

topicCreateCmd="${topicCmd} --create --zookeeper ${HOST_NAME}:${ZOOKEEPER_PORT} --if-not-exists --topic"

$topicCreateCmd $1 --partitions 1 --replication-factor 1

