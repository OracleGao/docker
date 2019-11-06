# Nginx

## 安装
1. 默认安装到 ~/docker-services/nginx下
``` shell
curl -L github.com/OracleGao/docker/raw/master/setup.sh | bash -s nginx
```
2. 拉取镜像
``` shell
~/docker-services/nginx/pull.sh
```
3. 启动
``` shell
~/docker-services/nginx/startup.sh
```
4. 停止
``` shell
~/docker-services/nginx/cleanup.sh
```

## 卸载
1. 停止
``` shell
~/docker-services/nginx/cleanup.sh
```
2. 清理
``` shell
rm -rf ~/docker-services/nginx
```

## 环境变量说明
- NGINX_IMAGE_TAG docker镜像tag，默认alpine，详见[nginx docker hub](https://hub.docker.com/_/nginx)
- NGINX_PORT 端口，默认80
- NGINX_SSL_PORT https端口，默认443
- NGINX_WWW_PATH 服务文件路径， 默认./data/www
- NGINX_CONF_PATH 配置文件路径，默认./conf/nginx
- NGINX_CERT_PATH SSL证书路径，默认./cert/nginx，容器内路径/etc/nginx/cert

## 配置文件模版
- [https配置模版](https://github.com/OracleGao/technology/blob/master/example/nginx/https.conf)
- [php配置模版](https://github.com/OracleGao/technology/blob/master/example/nginx/php.conf)

## docker环境安装
- 详见[docker环境安装](https://github.com/OracleGao/docker/blob/master/README.md)

## Refs
- [nginx docker hub](https://hub.docker.com/_/nginx)
