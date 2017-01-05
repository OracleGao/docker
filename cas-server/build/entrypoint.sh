#!/bin/sh

if [ -z ${CAS_DATABASE_HOST} ]; then
  echo "CAS_DATABASE_HOST invalidate"
  exit 2
fi

if [ -z ${CAS_DATABASE_PORT} ]; then
  export CAS_DATABASE_PORT=3306   
fi

configFile=/etc/cas/config/cas.properties

sed -i "s/@CAS_DATABASE_HOST@/${CAS_DATABASE_HOST}/g" ${configFile}.template 
sed -i "s/@CAS_DATABASE_PORT@/${CAS_DATABASE_PORT}/g" ${configFile}.template
mv ${configFile}.template ${configFile}

java -classpath / -jar cas.war

