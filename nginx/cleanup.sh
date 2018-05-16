#!/usr/bin/env bash
cd ${0%/*}

source ./env

if [ "$1" != "-y" ]; then
  echo "###########################################"
  echo -e "cleanup will destory the docker container \nand delete log path [${LOG_PATH}] recursively."
  echo "###########################################"
  echo -e "are you sure cleanup the docker service? <y/N>: \c"
  read flag
fi

if [ "$1" == "-y" -o "${flag}" == "y" ]; then
  docker-compose stop
  docker-compose rm -f
  rm -rf ${LOG_PATH}
fi
