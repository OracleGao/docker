#!/usr/bin/env bash
set -ex
cd ${0%/*}

source ./env

SERVER_XML_TMP=${CONFIG_PATH}/.server.xml.tmp

if [ ! -f ${SERVER_XML_FILE} ]; then
  if [ ! -f ${SERVER_XML_TEMPLATE} ]; then
     echo "missing tomcat server.xml.template file to generate server.xml: ${SERVER_XML_TEMPLATE}"
     exit 1
  fi
  cp ${SERVER_XML_TEMPLATE} ${SERVER_XML_TMP}
  sed -i s/'${KEY_STORE_TYPE}'/${KEY_STORE_TYPE}/g ${SERVER_XML_TMP}
  sed -i s/'${KEY_STORE_ALIAS}'/${KEY_STORE_ALIAS}/g ${SERVER_XML_TMP}
  sed -i s/'${KEY_STORE_PASSWORD}'/${KEY_STORE_PASSWORD}/g ${SERVER_XML_TMP}
  mv ${SERVER_XML_TMP} ${SERVER_XML_FILE}
fi

if [ ! -f ${KEY_STORE_FILE} ]; then
  echo "missing tomcat https keystore file: ${KEY_STORE_FILE}"
  exit 2
fi

prepare_path() {
  if [ ! -d ${1} ]; then
    mkdir -p ${1}
  fi
}

prepare_path ${DEPLOY_PATH}
prepare_path ${WEBAPPS_PATH}
prepare_path ${WORK_PATH}
prepare_path ${LOGS_PATH}

exit 0
