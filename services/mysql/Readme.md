# Mysql

## 安装
1. 默认安装到 ~/docker-services/mysql下
``` shell
curl -L github.com/OracleGao/docker/raw/master/setup.sh | bash -s mysql
```
2. 拉取镜像
``` shell
~/docker-services/mysql/pull.sh
```
3. 启动
``` shell
~/docker-services/mysql/startup.sh
```
4. 停止
``` shell
~/docker-services/mysql/cleanup.sh
```

## 卸载
1. 停止
``` shell
~/docker-services/mysql/cleanup.sh
```
2. 清理
``` shell
rm -rf ~/docker-services/mysql
```

## 环境变量说明
- MYSQL_IMAGE_TAG docker镜像tag，默认5.7，详见[mysql docker hub](https://hub.docker.com/_/mysql)
- MYSQL_PORT 端口，默认3306
- MYSQL_DATA_PATH 数据文件路径，默认./data/mysql

## docker环境安装
- 详见[docker环境安装](https://github.com/OracleGao/docker/blob/master/README.md)

## Refs
- [mysql docker hub](https://hub.docker.com/_/mysql/)
