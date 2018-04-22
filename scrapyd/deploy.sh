#!/usr/bin/env bash
source ./env

if [ "$1" == "" ]; then
  echo "$0 <project name>"
  exit 1
fi

export SCRAPY_SRC_PATH=$SCRAPY_SRC_PATH/$1
docker-compose run scrapyd-client scrapyd-client deploy 
