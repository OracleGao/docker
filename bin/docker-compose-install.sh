#!/usr/bin/env bash

##########################################

  #Author OracleGao
  #Date 2019-10-22
  #Reference: https://github.com/docker/compose/releases/

##########################################

export PATH=${PATH:-.}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/bin

if [ -f /usr/local/bin/docker-compose ]; then
  if [ ! -x /usr/local/bin/docker-compose ]; then
    chmod +x /usr/local/bin/docker-compose
  fi
else 
  cmd="curl$(curl https://github.com/docker/compose/releases/ | grep https://github.com/docker/compose/releases/download  | head -n1 | awk -F 'curl' '{print $2}')"
  eval ${cmd}
  chmod +x /usr/local/bin/docker-compose
fi
docker-compose -v
