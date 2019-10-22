#!/usr/bin/env bash
set -ex
cd ${0%/*}
source ./env
#echo ${JENKINS_DEPLOY_HOME}
#echo ${MAVEN_LIB}
docker-compose up -d
