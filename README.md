# docker container debug
## ubuntu debian 
### replace apt source with aliyun
```shell
echo "deb http://mirrors.aliyun.com/ubuntu/ vivid main restricted universe multiverse              " > /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ vivid-security main restricted universe multiverse     " >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ vivid-updates main restricted universe multiverse      " >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ vivid-proposed main restricted universe multiverse     " >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ vivid-backports main restricted universe multiverse    " >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ vivid main restricted universe multiverse          " >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ vivid-security main restricted universe multiverse " >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ vivid-updates main restricted universe multiverse  " >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ vivid-proposed main restricted universe multiverse " >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ vivid-backports main restricted universe multiverse" >> /etc/apt/sources.list
apt-get update
```
### debug tools
- netstat
```shell
apt-get install -y net-tools
```
- ps
```shell
apt-get install -y procps
```
- vim
```shell
apt-get install -y vim
```

# Reference
- [docker install](https://docs.docker.com/engine/installation/)
- [docker-compose github](https://github.com/docker/compose)
- [docker-compose install](https://github.com/docker/compose/releases/)
