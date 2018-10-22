##########################################

  #Author OracleGao
  #Date 2018-10-22
  #Reference: https://docs.docker.com/install/linux/docker-ce/ubuntu/
  #           https://docs.docker.com/install/linux/docker-ce/centos/

##########################################

#!/usr/bin/env bash
set -ex
cd ${0%/*}

sys="unknow"

if [ -f /usr/bin/apt-get ]; then
  sys="ubuntu"
fi

if [ -f /usr/bin/yum ]; then
  sys="centos"
fi

if [ "${sys}" == "unknow" ]; then
  echo "unkown operation system, just only support centos and ubuntu."
  exit 1
fi

if [ "${sys}" == "ubuntu" ]; then
  echo "ubuntu system"
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

  add-apt-repository \
    "deb [arch=armhf] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

  add-apt-repository \
    "deb [arch=s390x] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

  apt-get update

  apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

  apt-get install -y docker-ce
elif [ "${sys}" == "centos" ]; then
  yum install -y \
    yum-utils \
    device-mapper-persistent-data \
    lvm2
 
  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  yum-config-manager --enable docker-ce-edge
  yum-config-manager --enable docker-ce-testing

  yum makecache fast

  yum install -y docker-ce

  systemctl start docker
  systemctl enable docker
fi
docker run hello-world
