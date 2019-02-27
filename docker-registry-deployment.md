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
- [代码示例](https://github.com/OracleGao/docker/tree/master/registry)
## Https(TLS)

## Https(TLS) with Client Cert

## Refs
- [docker hub registry 官方镜像库](https://hub.docker.com/_/registry)
- [centos7 Docker私有仓库搭建及删除镜像](https://www.cnblogs.com/Tempted/p/7768694.html)
- [docker registry push错误“server gave HTTP response to HTTPS client”](https://www.cnblogs.com/hobinly/p/6110624.html)
- [Docker Registry服务器部署配置](https://www.myfreax.com/deploying-a-registry-server/)
