#!/usr/bin/env bash

current_path=$(pwd)
docker_path=$(dirname $0)

function usage() {
  echo "Usage $0 <service> [setup path:~/docker-services]"
  echo "    service: docker,         install docker servicei, ignore setup path"
  echo "             docker-compose, install docker-compose, ignore setup path"
  for item in $(ls ./services)
  do
    echo "             ${item},          setup ${item} service"
  done
  exit 1
}

if [ $# -lt 1 ]; then
  usage
fi

if [ "$1" == "docker" ]; then
  ${docker_path}/bin/docker-install.sh
  exit 0
fi

if [ "$1" == "docker-compose" ]; then
  ${docker_path}/bin/docker-compose-install.sh
  exit 0
fi

if [ -d "${docker_path}/services/$1" ]; then
  setup_path=${2:-~/docker-services}
  if [ $# -lt 2 ]; then
    setup_path=${setup_path}/$1
  fi
  if [ ! -d ${setup_path} ]; then
    mkdir -p ${setup_path}
  fi
  if [ "${setup_path}" == "." ]; then
    setup_path=${current_path}
  fi
  cp -a ${docker_path}/services/$1/* ${setup_path}/.
  cp -a ${docker_path}/lib/* ${setup_path}/.
  echo "setup success ${setup_path}"
else 
  echo "invalid service [$1]"
  usage
fi



