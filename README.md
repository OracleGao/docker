# docker
## 安装docker
- 执行下面指令（仅支持ubuntu和centos，请确保操作系统内核版本符合docker官方要求）
```
curl -L github.com/OracleGao/docker/raw/master/bin/docker-install.sh | bash
```

## 安装docker-compose
- 执行下面指令
```
curl -L github.com/OracleGao/docker/raw/master/bin/docker-compose-install.sh | bash
```

## 安装docker服务
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

## Reference
- [docker install](https://docs.docker.com/engine/installation/)
- [docker-compose github](https://github.com/docker/compose)
- [docker-compose install](https://github.com/docker/compose/releases/)
