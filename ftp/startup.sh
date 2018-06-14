#!/usr/bin/env bash
cd ${0%/*}

source ./env

docker-compose start
if [ "$?" == "1" ]; then
  ./deploy.sh
fi
