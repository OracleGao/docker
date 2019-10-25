#!/usr/bin/env bash

current_path=$(pwd)

cd $(dirname $0)

function usage() {
  echo "Usage $0 <service> [setup path:~/docker-services]"
  echo "    service: docker,         install docker servicei, ignore setup path"
  echo "             docker-compose, install docker-compose, ignore setup path"
  for item in $(ls ./services)
  do
    echo "             ${item},          setup redis service"
  done
  exit 1
}

if [ $# -lt 1 ]; then
  usage
fi

if [ "$1" == "docker" ]; then
  ./bin/docker-install.sh
  exit 0
fi

if [ "$1" == "docker-compose" ]; then
  ./bin/docker-compose-install.sh
  exit 0
fi

if [ -d "./services/$1" ]; then
  setup_path=${2:-~/docker-services}
  if [ ! -d ${setup_path} ]; then
    mkdir -p ${setup_path}
  fi
  if [ "${setup_path}" == "." ]; then
    setup_path=${current_path}
  fi

  echo "./services/$1"
else 
  echo "invalid service [$1]"
  usage
fi



