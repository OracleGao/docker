#!/usr/bin/env bash
set -ex
cd ${0%/*}

source ./env
mkdir -p ${SAMBA_PATH}
chmod 777 ${SAMBA_PATH}
docker-compose up -d
