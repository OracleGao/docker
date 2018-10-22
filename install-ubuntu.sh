##########################################

  #Author OracleGao
  #Date 2018-10-22
  #Reference: https://docs.docker.com/install/linux/docker-ce/ubuntu/
  # @Deprecated

##########################################

#!/usr/bin/env bash
set -ex
cd ${0%/*}

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

docker run hello-world
