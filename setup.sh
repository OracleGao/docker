##########################################

  #Author OracleGao
  #Date 2019-10-27
  #Git: https://github.com/OracleGao/docker.git
  #Reference: https://docs.docker.com/install/linux/docker-ce/ubuntu/
  #           https://docs.docker.com/install/linux/docker-ce/centos/

##########################################
#!/usr/bin/env bash

current_path=$(pwd)

## 获取docker source code
if [ -f ./.git/config ]; then
  url=$(cat ./.git/config | grep OracleGao/docker.git | awk -F '= ' '{print $2}')
  if [ "${url}" == "https://github.com/OracleGao/docker.git" ]; then
    docker_path=$(pwd)
  fi
fi

if [ "${docker_path}" == "" ]; then
  docker_path=/tmp/docker-$(date "+%Y%m%d%H%M%S")
  git clone https://github.com/OracleGao/docker.git ${docker_path}
fi 

## 打印指令帮助
function usage() {
  echo "Usage $0 <service> [setup path:~/docker-services]"
  echo "    service: docker,         install docker servicei, ignore setup path"
  echo "             docker-compose, install docker-compose, ignore setup path"
  for item in $(ls ${docker_path}/services)
  do
    echo "             ${item},          setup ${item} service"
  done
  exit 1
}

if [ $# -lt 1 ]; then
  usage
fi

## 安装docker
if [ "$1" == "docker" ]; then
  ${docker_path}/bin/docker-install.sh
  exit 0
fi

## 安装docker-compose
if [ "$1" == "docker-compose" ]; then
  ${docker_path}/bin/docker-compose-install.sh
  exit 0
fi

if [ -d "${docker_path}/services/$1" ]; then
  setup_path=${2:-~/docker-services}
  if [ $# -lt 2 ]; then
    setup_path=${setup_path}/$1
  fi
  if [ ! -d ${setup_path} ]; then
    mkdir -p ${setup_path}
  fi
  if [ "${setup_path}" == "." ]; then
    setup_path=${current_path}
  fi
  cp -a ${docker_path}/services/$1/* ${setup_path}/.
  cp -a ${docker_path}/lib/* ${setup_path}/.
  echo "setup success ${setup_path}"
else 
  echo "invalid service [$1]"
  usage
fi



