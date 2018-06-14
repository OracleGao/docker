#!/usr/bin/env bash
cd ${0%/*}

source ./env

if [ $# -lt 1 ];then
  echo "Usage $0 <username>"
  exit 1
fi

docker-compose run --rm pure-ftpd pure-pw useradd $1 -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u ftpuser -d /home/ftpusers/$1

if [ "$?" == "0" ]; then
  echo "add user success, you need restart the ftp service. use: './shutdown.sh && ./startup.sh'"
fi

