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

## Protect the Docker daemon socket(docker 带鉴权的远程加密访问)
- 通过配置证书，访问远程的docker service

### 环境准备
- 远程机器 47.93.199.97,已经正确安装docker并可以使用
- 本地机器已经安装docker并可以正常使用
- 

### 服务端配置
1. 将准备好的证书"ca.pem server-cert.pem server-key.pem"放在~/.docker目录下
2. 编辑/lib/systemd/system/docker.service，在"ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock"后面追加--tlsverify -H tcp://0.0.0.0:2376,打开带鉴权的远程加密访问
``` txt
...
# the default is not to use systemd for cgroups because the delegate issues still
# exists and systemd currently does not support the cgroup feature set required
# for containers run by docker
ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock --tlsverify -H tcp://0.0.0.0:2376
ExecReload=/bin/kill -s HUP $MAINPID
# Having non-zero Limit*s causes performance problems due to accounting overhead
# in the kernel. We recommend using cgroups to do container-local accounting.
...
```
3. 重启docker服务
``` shell
systemctl daemon-reload
service docker restart
```
4. 验证服务
- 查看2376端口已经打开，并且对外提供服务
``` shell
netstat -ntlp
```
``` txt
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      2582/sshd
tcp6       0      0 :::2376                 :::*                    LISTEN      19513/dockerd
```

- 使用curl验证服务可用性
``` shell
curl -k https://127.0.0.1:2376/images/json --cert ~/.docker/cert.pem --key ~/.docker/key.pem --cacert ~/.docker/ca.pem
```
``` json
[ {
	"Containers": -1,
	"Created": 1525884318,
	"Id": "sha256:f759510436c8fd6f7ffa13dd9e9d85e64bec8d2bfd12c5aa3fb9af1288eccdab",
	"Labels": {
		"maintainer": "NGINX Docker Maintainers <docker-maint@nginx.com>"
	},
	"ParentId": "",
	"RepoDigests": ["nginx@sha256:ccec51bccf6cf451393c809831cff022ae9c5374a3bea8361a09e142a49b9ed4"],
	"RepoTags": ["nginx:stable"],
	"SharedSize": -1,
	"Size": 108938415,
	"VirtualSize": 108938415
},  {
	"Containers": -1,
	"Created": 1509774650,
	"Id": "sha256:837969d6f96848f6286f6925774b20f587980496d21c5eabccf7f5c36896f481",
	"Labels": null,
	"ParentId": "",
	"RepoDigests": ["openjdk@sha256:e82dda3f40256c0fe0cc4472521555b7d68f4fb428f2542c2b86064de715d552"],
	"RepoTags": ["openjdk:8u151-jre-slim"],
	"SharedSize": -1,
	"Size": 204732311,
	"VirtualSize": 204732311
}, {
	"Containers": -1,
	"Created": 1505255051,
	"Id": "sha256:05a3bd381fc2470695a35f230afefd7bf978b566253199c4ae5cc96fafa29b37",
	"Labels": null,
	"ParentId": "",
	"RepoDigests": ["hello-world@sha256:b2ba691d8aac9e5ac3644c0788e3d3823f9e97f757f01d2ddc6eb5458df9d801"],
	"RepoTags": ["hello-world:latest"],
	"SharedSize": -1,
	"Size": 1840,
	"VirtualSize": 1840
}]
```
### 客户端配置
1. 将ca.pem,cert.pem,key.pem拷贝的远程docker client机器的~/.docker下
2. 远程访问docker服务
``` shell
docker --tls -H=192.168.10.:2376 version
```

### 秘钥和证书生成
1. 生成ca-key.pem和ca.pem
- 执输入密码，生成ca-key.pem
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
- 使用生成的ca-key.pem,执行下列指令并输入密码，生成ca.pem
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
2. 生成server-key.pem和server-cert.pem
- 生成server-key.pem
``` shell
openssl genrsa -out server-key.pem 4096
```
``` txt
Generating RSA private key, 4096 bit long modulus
...................++
.....................................................++
e is 65537 (0x10001)
```
- 生成server.csr
``` shell
openssl req -sha256 -new -key server-key.pem -out server.csr
```
``` txt
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

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
```
- 输入密码生成server-cert.pem
``` shell
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem
```
``` txt
Signature ok
subject=/C=XX/L=Default City/O=Default Company Ltd
Getting CA Private Key
Enter pass phrase for ca-key.pem:
```
3. 生成key.pem和cert.pem
- 生成key.pem
``` shell
openssl genrsa -out key.pem 4096
```
``` txt
Generating RSA private key, 4096 bit long modulus
......++
........................................................................++
```
- 生成client.csr
``` shell
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
```
- 输入密码生成cert.pem
``` shell
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem
```
``` txt
Signature ok
subject=/CN=client
Getting CA Private Key
Enter pass phrase for ca-key.pem:
```
4. 清理中间证书文件与修改证书访问权限
- 清理中间证书文件
``` shell
rm -rf client.csr server.csr
```
- 修改证书访问权限
``` shell
chmod 0400 ca-key.pem key.pem server-key.pem
chmod -v 0444 ca.pem server-cert.pem cert.pem
```

### FAQ
#### curl: (60) Peer's certificate has an invalid signature
``` txt
curl: (60) Peer's certificate has an invalid signature.
More details here: http://curl.haxx.se/docs/sslcerts.html

curl performs SSL certificate verification by default, using a "bundle"
 of Certificate Authority (CA) public keys (CA certs). If the default
 bundle file isn't adequate, you can specify an alternate file
 using the --cacert option.
If this HTTPS server uses a certificate signed by a CA represented in
 the bundle, the certificate verification probably failed due to a
 problem with the certificate (it might be expired, or the name might
 not match the domain name in the URL).
If you'd like to turn off curl's verification of the certificate, use
 the -k (or --insecure) option.
```
- 使用curl -k 跳过证书验证
