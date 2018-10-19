#!/usr/bin/env bash
cd ${0%/*}


source ./env

docker-compose run --rm ansible ansible-playbook ./playbook.yml
