#!/usr/bin/env bash
cd $(dirname $0)

services="$(docker-compose config --service)"

count=0
for item in ${services}; do

done

function usage() {
  echo "Usage $0 <service>"
  echo "    service: all"
  for item in ${services}; do
    echo "             ${item}"
  done
  exit 1
}

docker-compose up -d

