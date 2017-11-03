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
apt-get install -y --allow-unauthenticated net-tools
```
- ps
```shell
apt-get install -y --allow-unauthenticated procps
```
- vim
```shell
apt-get install -y --allow-unauthenticated vim
```

# docker remote control
## centos7
- edit the file "/usr/lib/systemd/system/docker.service"
```text
[Service]
Type=notify
# the default is not to use systemd for cgroups because the delegate issues still
# exists and systemd currently does not support the cgroup feature set required
# for containers run by docker
#ExecStart=/usr/bin/dockerd
ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://0.0.0.0:8080
```
- execute shell cmd
```shell
systemctl daemon-reload
service docker restart
```
- verify
```shell
ps -ax | grep docker
```
```text
11609 ?        Ssl    0:00 /usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://0.0.0.0:8080
```
- if you install in Ali ECS instance, after the modification, you must restart the instance.

# Reference
- [docker install](https://docs.docker.com/engine/installation/)
- [docker-compose github](https://github.com/docker/compose)
- [docker-compose install](https://github.com/docker/compose/releases/)
