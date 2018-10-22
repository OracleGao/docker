#!/usr/bin/env bash
set -ex

export PATH=${PATH:-.}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/bin

config="unknow"
if [ -f /lib/systemd/system/docker.service ]; then
  config="/lib/systemd/system/docker.service"
fi

if [ -f /usr/lib/systemd/system/docker.service ]; then
  config="/usr/lib/systemd/system/docker.service"
fi

if [ "${config}" == "unknow" ]; then
  echo "unknow docker.service file"
  exit 2
fi

cp ${config} ${config}.$(date "+%Y%m%d%H%M%S")

sed -i 's%-H fd://%%g' ${config}

