# Docker Registry Deployment
## 前置知识
- 了解docker命令行常用指令
- 了解docker-compose配置和常用命令行指令

## 环境准备
- 安装docker
- 安装docker-composer
- 从[官方镜像库](https://hub.docker.com/_/registry)拉取镜像库docker镜像
``` shell
docker pull registry
```

## Http
### config.yml配置文件
- (完整的配置文件示例)[https://github.com/OracleGao/docker/blob/master/registry/conf/config.yml.template]
- 默认配置
``` yml
version: 0.1
log:
  fields:
    service: registry
storage:
  delete:
    enabled: true
  cache:
    blobdescriptor: inmemory
  filesystem:
    rootdirectory: /var/lib/registry
http:
  addr: :5000
  headers:
    X-Content-Type-Options: [nosniff]
health:
  storagedriver:
    enabled: true
    interval: 10s
    threshold: 3
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
### <A NAME="A1">配置dockerd参数，允许非https的方式访问镜像库</A>
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

#### 启动验证
- 启动docker镜像库服务
``` shell
docker tag hello-world:latest 192.168.10.2:5000/hello-world:latest
docker push 192.168.10.2:5000/hello-world:latest
curl -X GET http://115.29.76.68:5000/v2/_catalog
```

## Https(TLS)
### 生成秘钥证书
- 生成秘钥文件dr-key.pem
``` shell
openssl genrsa -out dr-key.pem 4096
```
- 生成证书文件dr-crt.pem, “Common Name (e.g. server FQDN or YOUR name) []:”为空或私有证书，则需要在镜像库的客户端配置允许不安全的私有库，同[配置dockerd参数，允许非https的方式访问镜像库](#A1)
``` shell
openssl req -new -x509 -days 365 -key dr-key.pem -sha256 -out dr-crt.pem

You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:
State or Province Name (full name) [Some-State]:
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:
Email Address []:

```
### 修改配置文件
- docker-compose.yml中增加证书映射“- ${CERT_PATH}:/etc/docker/registry/cert”
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
      - ${CERT_PATH}:/etc/docker/registry/cert
    environment:
      TZ: Asia/Shanghai
    logging:
      options:
        max-size: 10mb
```
- config.yml中增加证书配置“tls.certificate”和“tls.key”
``` yml
version: 0.1
log:
  fields:
    service: registry
storage:
  delete:
    enabled: true
  cache:
    blobdescriptor: inmemory
  filesystem:
    rootdirectory: /var/lib/registry
http:
  addr: :5000
  secret: clouderworkdockerregistry
  tls:
    certificate: /etc/docker/registry/cert/dr-crt.pem
    key: /etc/docker/registry/cert/dr-key.pem
  headers:
    X-Content-Type-Options: [nosniff]
health:
  storagedriver:
    enabled: true
    interval: 10s
    threshold: 3
```
### 启动验证
- 启动docker镜像库服务
- 验证 curl命令加“-k”参数跳过证书验证
``` shell
docker tag hello-world:latest 192.168.10.2:5000/hello-world:latest
docker push 192.168.10.2:5000/hello-world:latest
curl -k -X GET https://115.29.76.68:5000/v2/_catalog
```

## Https(TLS) with Htpasswd Authentication
- https的基础上增加登录校验
- 生成登录私有镜像库的用户名密码文件【必须加"-B"参数，官方要求强制使用bcrypt加密方式】(用户名/密码： admin/changeit)
``` 
htpasswd -Bcb passtest admin changeit
```

  * 关于htpasswd,参考[Apache htpasswd file](https://httpd.apache.org/docs/2.4/programs/htpasswd.html)
  * registry:latest 镜像中自带了htpasswd指令，故可以使用以下指令创建密码文件
  ``` bash
  docker run --rm -it --entrypoint htpasswd registry:latest -Bbn admin changeit > passfile
  ```
- 将生成的密码文件与证书文件放在同一文件夹下
- 修改config.yml 增加“auth.htpasswd.realm”（值随便填写）和“auth.htpasswd.path”(密码文件位置)
```
version: 0.1
log:
  fields:
    service: registry
storage:
  delete:
    enabled: true
  cache:
    blobdescriptor: inmemory
  filesystem:
    rootdirectory: /var/lib/registry
auth:
  htpasswd:
    realm: basic-realm
    path: /etc/docker/registry/cert/passfile
http:
  addr: :5000
  secret: dockerregistry
  tls:
    certificate: /etc/docker/registry/cert/dr-crt.pem
    key: /etc/docker/registry/cert/dr-key.pem
  headers:
    X-Content-Type-Options: [nosniff]
health:
  storagedriver:
    enabled: true
    interval: 10s
    threshold: 3
```
- 其它同https的配置方式
### 启动验证
- 重启镜像库服务
- 登录镜像库,输入用户名/密码：admin/changeit
``` shell
docker login https://192.168.10.2:5000
```
- 登出镜像库
``` shell
docker logout
```
## Https(TLS) with Client Cert
- 即将更新...
## 完整代码示例
- [完整代码示例](https://github.com/OracleGao/docker/tree/master/registry)中执行start.sh启动服务

## FAQs
### Get https://192.168.10.2/v1/_ping: x509: cannot validate certificate for 192.168.10.2 because it doesn't contain any IP SANs
- 参考[配置dockerd参数，允许非https的方式访问镜像库](#A1)

## Refs
- [docker hub registry 官方镜像库](https://hub.docker.com/_/registry)
- [centos7 Docker私有仓库搭建及删除镜像](https://www.cnblogs.com/Tempted/p/7768694.html)
- [docker registry push错误“server gave HTTP response to HTTPS client”](https://www.cnblogs.com/hobinly/p/6110624.html)
- [Docker Registry服务器部署配置](https://www.myfreax.com/deploying-a-registry-server/)
- [docker registry config官方说明](https://docs.docker.com/registry/configuration/)
