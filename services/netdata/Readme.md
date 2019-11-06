# Netdata

## 安装
1. 默认安装到 ~/docker-services/netdata下
``` shell
curl -L github.com/OracleGao/docker/raw/master/setup.sh | bash -s netdata
```
2. 拉取镜像
``` shell
~/docker-services/netdata/pull.sh
```
3. 启动
``` shell
~/docker-services/netdata/startup.sh
```
4. 停止
``` shell
~/docker-services/netdata/cleanup.sh
```

## 卸载
1. 停止
``` shell
~/docker-services/netdata/cleanup.sh
```
2. 清理
``` shell
rm -rf ~/docker-services/netdata
```

## 环境变量说明
- NETDATA_IMAGE_TAG docker镜像tag，默认latest-amd64，详见[netdata docker hub](https://hub.docker.com/r/netdata/netdata/)
- NETDATA_PORT 端口，默认19999

## docker环境安装
- 详见[docker环境安装](https://github.com/OracleGao/docker/blob/master/README.md)

## Refsdocker
- [netdata github](https://github.com/netdata/netdata)
- [netdata docker hub](https://hub.docker.com/r/netdata/netdata/)
