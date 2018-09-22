#!/usr/bin/env bash
cd ${0%/*}

source ./env

docker-compose run --rm scrapyd-client scrapyd-deploy 
