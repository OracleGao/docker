#!/usr/bin/env bash
cd ${0%/*}

source ./env
./dev-stop.sh
./rc-stop.sh

configFile=${DEV_DATA_PATH}/etc/cas/config/cas.properties
sed "s/@CAS_DATABASE_HOST@/${DEV_DATABASE_HOST}/g" ${configFile}.template > ${configFile}
sed -i "s/@CAS_DATABASE_PORT@/${DEV_DATABASE_PORT}/g" ${configFile}

docker-compose up -d ${DEV_DOCKER_COMPOSE_SERVICE}
