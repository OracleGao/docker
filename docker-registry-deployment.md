# Docker Registry Deployment
## Http
## 环境准备
- 安装docker
- 安装docker-composer
- 从[官方镜像库](https://hub.docker.com/_/registry)拉取镜像库docker镜像
``` shell
docker pull registry
```
- 编辑docker-compose.yml文件, 其中环境变量需要自行替换
``` yml
version: '2'
services:
  nginx:
    restart: always
    image: registry:latest
    ports:
      - ${PORT}:5000
    volumes:
      - ${REGISTRY_PATH}:/var/lib/registry
      - ${CONFIG_FILE}:/etc/docker/registry/config.yml
    environment:
      TZ: Asia/Shanghai
    logging:
      options:
        max-size: 10mb
```
### 配置dockerd参数，允许非https的方式访问镜像库
- 以下三种方式任选其一(有些环境下，不同版本的操作系统，不同版本的docker服务，可能某一种会生效，自行尝试)
#### /etc/docker/daemon.json【推荐（linux）】
- insecure-registries数组中追加${REGISTRY_HOST}:${REGISTRY_HOST}
``` json
{
...,
    "insecure-registries": [
        "192.168.10.2:5000"
    ],
...
}
```
- 重启docker服务
``` shell
service docker restart
```
#### /lib/systemd/system/docker.service
- ExecStart=/usr/bin/dockerd 行尾追加 --insecure-registry ${REGISTRY_HOST}:${REGISTRY_HOST}
``` properteis
ExecStart=/usr/bin/dockerd ... --insecure-registry 192.168.10.2:5000
```
- 重启docker服务
``` shell
systemctl daemon-reload
service docker restart
```
#### /etc/default/docker
- DOKCER_OPT 行尾追加 --insecure-registry ${REGISTRY_HOST}:${REGISTRY_HOST}
``` properties
DOKCER_OPT=" --insecure-registry 192.168.10.2:5000"
```
- 重启docker服务
``` shell
service docker restart
```

## Https(TLS)

## Https(TLS) with Client Cert

## 完整代码示例
- [完整代码示例](https://github.com/OracleGao/docker/tree/master/registry)中执行start.sh启动服务

## FAQs
### Get https://192.168.10.2/v1/_ping: x509: cannot validate certificate for 192.168.10.2 because it doesn't contain any IP SANs
- 参考[配置dockerd参数，允许非https的方式访问镜像库](# 配置dockerd参数，允许非https的方式访问镜像库)

## Refs
- [docker hub registry 官方镜像库](https://hub.docker.com/_/registry)
- [centos7 Docker私有仓库搭建及删除镜像](https://www.cnblogs.com/Tempted/p/7768694.html)
- [docker registry push错误“server gave HTTP response to HTTPS client”](https://www.cnblogs.com/hobinly/p/6110624.html)
- [Docker Registry服务器部署配置](https://www.myfreax.com/deploying-a-registry-server/)
