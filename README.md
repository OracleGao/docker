# docker @Drepeated
- 迁移到gitee https://gitee.com/oraclegao/docker

## 安装docker
- 执行下面指令（仅支持ubuntu和centos，请确保操作系统内核版本符合docker官方要求）
```
curl -L github.com/OracleGao/docker/raw/master/bin/docker-install.sh | bash
```
- 或者
```
curl -L github.com/OracleGao/docker/raw/master/setup.sh | bash -s docker
```
## 安装docker-compose
- 执行下面指令
```
curl -L github.com/OracleGao/docker/raw/master/bin/docker-compose-install.sh | bash
```
- 或者
```
curl -L github.com/OracleGao/docker/raw/master/setup.sh | bash -s docker-compose
```
## 安装docker服务
- 指令调用方式 服务名 安装路径（默认安装到~/docker-service下）
```
curl -L github.com/OracleGao/docker/raw/master/setup.sh | bash
```
```
Usage bash <service> [setup path:~/docker-services]
    service: docker,         install docker servicei, ignore setup path
             docker-compose, install docker-compose, ignore setup path
             nginx,          setup nginx service
             redis,          setup redis service
```
- 可用service
  - nginx
  - redis

### 管理指令
- 拉取镜像
```
~/docker-services/${SERVICE}/pull.sh
```
- 启动
```
~/docker-services/${SERVICE}/startup.sh
```
- 停止
```
~/docker-services/${SERVICE}/cleanup.sh
```

### 服务安装以nginx为例
- 默认安装到 ~/docker-services/nginx
```
curl -L github.com/OracleGao/docker/raw/master/setup.sh | bash -s nginx
```
- 拉取镜像
```
~/docker-services/nginx/pull.sh
```
- 启动
```
~/docker-services/nginx/startup.sh
```
- 停止
```
~/docker-services/nginx/cleanup.sh
```


## Reference
- [docker install](https://docs.docker.com/engine/installation/)
- [docker-compose github](https://github.com/docker/compose)
- [docker-compose install](https://github.com/docker/compose/releases/)
