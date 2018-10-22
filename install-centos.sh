##########################################

  #Author OracleGao
  #Date 2017-07-27
  #Reference: https://docs.docker.com/engine/installation/linux/docker-ce/centos/#install-using-the-repository
  # @Deprecated

##########################################

#!/usr/bin/env bash
set -ex
cd ${0%/*}

yum remove docker
yum remove docker-common
yum remove docker-selinux
yum remove docker-engine

yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum-config-manager --enable docker-ce-edge

yum-config-manager --enable docker-ce-testing

yum makecache fast

yum install -y docker-ce

systemctl start docker

systemctl enable docker

docker run hello-world
