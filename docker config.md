# Docker Config

## Docker Remote Control

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
- ping
```shell
apt-get install -y iputils-ping
```
# Docker Remote Control
## Centos7 and Ubuntu 16.04+
- Edit the file "/usr/lib/systemd/system/docker.service", add "-H unix:///var/run/docker.sock -H tcp://0.0.0.0:1103" after "ExecStart=/usr/bin/dockerd"
```text
[Service]
Type=notify
# the default is not to use systemd for cgroups because the delegate issues still
# exists and systemd currently does not support the cgroup feature set required
# for containers run by docker
#ExecStart=/usr/bin/dockerd
ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://0.0.0.0:1103
```
- Execute shell cmd
```shell
systemctl daemon-reload
service docker restart
```
- Verify
```shell
ps -ax | grep docker
```
```text
11609 ?        Ssl    0:00 /usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://0.0.0.0:1103
```
```shell
docker -H ${REMOTE_DOCKER_IP}:1103 ps
```
- If you install the remoted docker service in Ali ECS instance, after the modification, you must restart the instance at first time.

## Ubuntu 14.04
- 编辑/etc/default/docker
- 文件末尾追加以下内容
``` text
export DOCKER_OPTS=" -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock"
```
- 重启服务
``` shell
service docker restart
```

## Protect the Docker daemon socket(docker 待鉴权和加密的远程访问)
- 通过配置证书，访问远程的docker service
### 服务端配置
1. 生成ca-key.pem和ca.pem
- 执行下列指令并输入密码，生成ca-key.pem
``` shell
openssl genrsa -aes256 -out ca-key.pem 4096
```
``` txt
Generating RSA private key, 4096 bit long modulus
...........................................................................................................................++
................++
e is 65537 (0x10001)
Enter pass phrase for ca-key.pem:
Verifying - Enter pass phrase for ca-key.pem:
```
2. 使用生成的ca-key.pem,执行下列指令并输入密码，生成ca.pem
- 对于绑定ip或域名需要在"Common Name (eg, your name or your server's hostname) []:",当不设置域名是，使用docker使用--tls,curl使用-k
``` shell
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
```
``` txt
Enter pass phrase for ca-key.pem:
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:
State or Province Name (full name) []:
Locality Name (eg, city) [Default City]:
Organization Name (eg, company) [Default Company Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (eg, your name or your server's hostname) []:
Email Address []:
```
