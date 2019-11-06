# Redis

## 安装
1. 默认安装到 ~/docker-services/redis下
``` shell
curl -L github.com/OracleGao/docker/raw/master/setup.sh | bash -s redis
```
2. 拉取镜像
``` shell
~/docker-services/redis/pull.sh
```
3. 启动
``` shell
~/docker-services/redis/startup.sh
```
4. 停止
``` shell
~/docker-services/redis/cleanup.sh
```

## 卸载
1. 停止
``` shell
~/docker-services/redis/cleanup.sh
```
2. 清理
``` shell
rm -rf ~/docker-services/redis
```

## 环境变量说明
- REDIS_IMAGE_TAG docker镜像tag，默认5-alpine，详见[redis docker hub](https://hub.docker.com/_/redis)
- REDIS_PORT 端口，默认6379
- REDIS_CONF_PATH 配置文件路径，默认./conf/redis，配置文件名固定为redis.conf
- REDIS_DATA_PATH 数据文件路径，默认./data/redis

## docker环境安装
- 详见[docker环境安装](https://github.com/OracleGao/docker/blob/master/README.md)

## Refs
- [redis docker hub](https://hub.docker.com/_/redis)
- [redis conf](https://redis.io/topics/config) 
