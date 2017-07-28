#!/usr/bin/env bash
set -ex
cd ${0%/*}

source ./env

./prepare.sh

if [ $? != 0 ]; then
  echo "startup failed"
  exit 1
fi

docker-compose up -d
